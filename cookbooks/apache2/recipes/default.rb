#
# Cookbook Name:: apache2
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
pakage "apache2"
template "/etc/apache2/apache2.conf" do
	source "apache2.conf.erb"
	owner "root"
	mode  "0644"
	variables(:allow_overide => "All")
	notifies :reload, "service[apache2]"
end 
include_recipe "service.rb"
