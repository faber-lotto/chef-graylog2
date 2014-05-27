#
# Cookbook Name:: graylog2
# Recipe:: server
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
require 'digest'

include_recipe "ark"

attributes = node["graylog2"]

["server_name",
 "password_secret",
 "root_password"].each do |attr|

  if attributes[attr].nil?
    Chef::Application.fatal! "Fix your value! ['graylog2']['#{attr}'] is not set"
  end

end

node.default["graylog2"]['root_password_sha2']= Digest::SHA256.hexdigest(attributes['root_password'])
node.default['graylog2']['transport_uri'] = "http://#{node.graylog2.server_name}:12900"
node.default['graylog2']['server']['config']['rest_listen_uri'] = "http://#{node.graylog2.server_name}:12900"

ark "graylog2_server" do
  url format(node.graylog2['server']['url_pattern'], version: node.graylog2['server']['version'])
  group node.graylog2[:group]
  version node.graylog2['server']['version']
end


directory '/etc/graylog2' do
  owner "root"
  group node.graylog2[:group]
end

directory '/var/log/graylog2' do
  owner "root"
  group node.graylog2[:group]
  mode 0770
end

directory '/usr/local/graylog2_server/log' do
  action :delete
  recursive true
  not_if "test -L /usr/local/graylog2_server/log"
end

link "/usr/local/graylog2_server/log" do
  to '/var/log/graylog2'
end

directory '/var/run/graylog2' do
  owner "root"
  group node.graylog2[:group]
  mode 0770
end

template "/etc/init.d/graylog2-server" do
  action :delete
  source "graylog2-server-init.erb"
  owner "root"
  group node.graylog2[:group]
  mode 0755
end

template "/etc/init/graylog2-server.conf" do
  source "graylog2-server-init.erb"
  owner "root"
  group node.graylog2[:group]
  mode 0644
end

template "/etc/graylog2/graylog2.conf" do
  source "graylog2-server.conf.erb"
  group node.graylog2[:group]
  variables(additional_config: node.graylog2.server.additional_config,
            config: node.graylog2.server.config
  )
  mode 0640

  notifies :restart, 'service[graylog2-server]'
end

template "/etc/graylog2/graylog2.drl" do
  source "graylog2.drl.erb"
  group node.graylog2[:group]

  mode 0640

  notifies :restart, 'service[graylog2-server]', :immediately
end

service "graylog2-server" do
  supports :start => true, :stop => true, :restart => true
  provider Chef::Provider::Service::Upstart
  action [:enable, :start]
end


graylog2_input "syslog"

logrotate_app 'graylog2-server' do
  cookbook  'logrotate'
  path      '/var/log/graylog2/*.log'
  options   ['missingok', 'delaycompress', 'notifempty', 'copytruncate']
  frequency 'daily'
  rotate    30
  create    '644 root graylog2'
end


