#
# Cookbook Name:: graylog2
# Recipe:: server
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "ark"

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

ark 'graylog2_web_interface' do
  url format(node.graylog2['web']['url_patern'], version: node.graylog2['web']['version'])
  owner node.graylog2[:user]
  group node.graylog2[:group]
  version node.graylog2['web']['version']
end

directory '/etc/graylog2' do
  owner node.graylog2[:user]
  owner "root"
  group node.graylog2[:group]
end

directory '/var/log/graylog2/web' do
  owner node.graylog2[:user]
  group node.graylog2[:group]
  recursive true
end

directory '/usr/local/graylog2_web_interface/log' do
  action :delete
  recursive true
  not_if "test -L /usr/local/graylog2_web_interface/log"
end

template "/etc/init.d/graylog2-web-interface" do
  source "graylog2-web-interface-init.erb"
  owner "root"
  group "root"
  mode 0755
end

link "/usr/local/graylog2_web_interface/log" do
  to '/var/log/graylog2/web'
  notifies :restart, 'service[graylog2-web-interface]', :immediately
end

template "/etc/graylog2/graylog2-web-interface.conf" do
  source "graylog2-web-interface.conf.erb"
  owner node.graylog2[:user]
  group node.graylog2[:group]
  mode 0640
  notifies :restart, 'service[graylog2-web-interface]', :immediately
end

template "/etc/graylog2/graylog2-web-interface-log.xml" do
  source "graylog2-web-interface-log.xml.erb"
  owner node.graylog2[:user]
  group node.graylog2[:group]
  mode 0640
  notifies :restart, 'service[graylog2-web-interface]', :immediately
end

file "/usr/local/graylog2_web_interface/conf/graylog2-web-interface.conf" do
  action :delete
  only_if { File.exists?(name) }
end

link "/usr/local/graylog2_web_interface/conf/graylog2-web-interface.conf" do
  to "/etc/graylog2/graylog2-web-interface.conf"
  notifies :restart, 'service[graylog2-web-interface]', :immediately
end

link "/usr/local/graylog2_web_interface/conf/graylog2-web-interface-log.xml" do
  to "/etc/graylog2/graylog2-web-interface-log.xml"
  notifies :restart, 'service[graylog2-web-interface]', :immediately
end

service "graylog2-web-interface" do
  supports :start => true
  action [:enable, :start]
  only_if "test -e /etc/init.d/graylog2-web-interface"
end


logrotate_app 'graylog2-web-interface' do
  cookbook  'logrotate'
  path      '/var/log/graylog2/web/*.log'
  options   ['missingok', 'delaycompress', 'notifempty', 'copytruncate']
  frequency 'daily'
  rotate    30
  create    '644 graylog2 graylog2'
end
