#
# Cookbook Name:: graylog2
# Recipe:: elasticsearch
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'elasticsearch::default'


begin
  r = resources(:template => "/etc/init.d/elasticsearch")
  r.cookbook "graylog2"
rescue Chef::Exceptions::ResourceNotFound
  Chef::Log.warn "could not find template to override!"
end

file "/tmp/gather-elasticsearch-semaphore" do
  mode 00644
  owner "root"
  group "root"
  action :create
  content "must start elasticsearch"
  notifies :start, resources(:service => "elasticsearch"), :immediately
end

if node.graylog2.install.elasticsearch_monit
  monit_monitrc "elasticsearch" do
    notifies :reload, "service[monit]"
  end
end