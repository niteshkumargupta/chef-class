#
# Cookbook Name:: learn_chef_apache2
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
package 'apache2'

package 'lynx'

service 'apache2' do
	action [:enable,:start]
end

#file '/var/www/html/index.html' do
#    content '<html> 
#    <body>
#	<h1> Hello World </h1>
#    </body> 
#   </html>'
#end

#template '/var/www/html/index.html' do
# source 'index.html.erb'
#end

#cookbook_file "/var/www/html/index.html" do
#	source node["apache"]["indexfile"]
#	mode "0644"
#end

execute "mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.disabled" do
only_id do
  File.exist?("/etc/apahce2/sites-available/000-default.conf")
  end
notifies :restart, "service[apache2]"
end
