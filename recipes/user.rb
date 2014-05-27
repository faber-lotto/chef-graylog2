#
# Cookbook Name:: graylog2
# Recipe:: user
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

group node.graylog2[:group] do
  action :create
  system true
end

user node.graylog2[:user] do
  comment "graylog2 web interface user"
  shell "/bin/bash"
  gid node.graylog2[:user]
  supports :manage_home => false
  action :create
  system true
end