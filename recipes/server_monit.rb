#
# Cookbook Name:: server_monit
# Recipe:: server
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

monit_monitrc "graylog2-server" do
  notifies :reload, "service[monit]"
end