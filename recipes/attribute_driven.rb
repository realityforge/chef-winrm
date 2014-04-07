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

WinRmProperty = Struct.new("WinRmProperty", :group, :key, :value)

props = []

def collect_properties(attribute, group, props)
  attribute.each_pair do |k, v|
    if v.is_a?(Mash) || v.is_a?(Hash)
      collect_properties(v, group ? "#{group}/#{k}" : k, props)
    else
      props << WinRmProperty.new(group, k, v)
    end
  end
end

collect_properties(node['winrm']['config'], nil, props)

props.each do |property|
  winrm_property "winrm set #{property.group}@#{property.key} = #{property.value}" do
    username node['winrm']['username'] if node['winrm']['username']
    password node['winrm']['password'] if node['winrm']['password']
    group property.group if property.group
    key property.key
    value property.value
  end
end
