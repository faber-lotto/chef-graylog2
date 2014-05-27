#
# Cookbook Name:: graylog2
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

install = node.graylog2.install

if install.java
  include_recipe 'graylog2::java'
end

if install.elasticsearch
  include_recipe 'graylog2::elasticsearch'
end

if install.mongodb
  include_recipe 'graylog2::mongodb'
end

include_recipe 'graylog2::user'
include_recipe 'graylog2::server'
include_recipe 'graylog2::server_monit'
include_recipe 'graylog2::server'

include_recipe 'graylog2::syslog_client'

include_recipe 'graylog2::web_interface'
include_recipe 'graylog2::web_interface_monit'