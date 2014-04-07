#
# Copyright 2012, Peter Donald
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include Chef::Mixin::ShellOut
include Windows::Helper

use_inline_resources

action :set do
  group_key = "winrm/config#{new_resource.group ? "/#{new_resource.group}" : ''}"

  service_name = "WinRM"

  service service_name do
    action :nothing
  end

  winrm_exe = "C:\\Windows\\System32\\winrm.cmd"

  options = []
  options << "-username:#{new_resource.username}" if new_resource.username
  options << "-password:#{new_resource.password}" if new_resource.password

  command = "#{winrm_exe} set #{group_key} @{#{new_resource.key}=\"#{new_resource.value}\"} #{options.join(' ')}"

  windows_batch command do
    not_if do
      cmd = shell_out("#{winrm_exe} get #{group_key} #{options.join(' ')}", {:returns => [0, 42, 127]})
      !!(cmd.stderr.empty? && (cmd.stdout =~ /^ +#{new_resource.key} = #{new_resource.value}\r?$/i))
    end
    code command
    notifies :restart, "service[#{service_name}]", :immediately
  end
end
