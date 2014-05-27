#
# Cookbook Name:: web_monit
# Recipe:: server
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

monit_monitrc "graylog2-web-interface" do
  notifies :reload, "service[monit]"
end