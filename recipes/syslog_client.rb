#
# Cookbook Name:: syslog_client
# Recipe:: server
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node['platform'] == 'ubuntu'
  service_provider = Chef::Provider::Service::Upstart
else
  service_provider = nil
end

service 'rsyslog' do
  supports :restart => true, :reload => true, :status => true
  action [:enable, :start]
  provider service_provider
end

template "/etc/rsyslog.d/20-graylog-client.conf" do
  source "20-graylog-client.conf.erb"
  mode 0644
  notifies :restart, "service[rsyslog]"
end

