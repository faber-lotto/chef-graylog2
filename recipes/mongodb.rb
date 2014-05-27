#
# Cookbook Name:: graylog2
# Recipe:: mongodb
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#include_recipe 'mongodb::10gen_repo'

#node.override['mongodb']['template_cookbook'] = "graylog2"

include_recipe 'mongodb::default'

if node.graylog2.install.mongodb_monit
  monit_monitrc "mongodb" do
    notifies :reload, "service[monit]"
  end
end