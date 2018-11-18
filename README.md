# Description

[![Build Status](https://secure.travis-ci.org/realityforge/chef-winrm.svg?branch=master)](http://travis-ci.org/realityforge/chef-winrm)

Cookbook to apply 0 or more winrm configurations..

# Requirements

## Platform:

* Windows

## Cookbooks:

*No dependencies defined*

# Attributes

* `node['winrm']['username']` -  Defaults to `nil`.
* `node['winrm']['password']` -  Defaults to `nil`.
* `node['winrm']['config']` -  Defaults to `Mash.new`.

# Recipes

* windows::attribute_driven - Apply 0 or more winrm configurations

# Resources

* [winrm_property](#winrm_property)

## winrm_property

### Actions

- set:  Default action.

### Attribute Parameters

- group:  Defaults to <code>nil</code>.
- key:
- value:
- username:  Defaults to <code>nil</code>.
- password:  Defaults to <code>nil</code>.

# License and Maintainer

Maintainer:: Peter Donald (<peter@realityforge.org>)

License:: Apache 2.0
