#
# Cookbook Name:: learn_chef_apache2
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
package 'httpd'

package 'lynx'

#service 'httpd' do
#	action [:enable,:start]
#end

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

execute "mv /etc/httpd/conf.d/welcome.conf /etc/httpd/conf.d/welcome.conf.disabled" do

only_if do
  File.exist?("/etc/httpd/conf.d/welcome.conf")
	end

	notifies :restart, "service[httpd]"
end

node["apache"]["sites"].each do |site_name, site_data|
document_root = "/srv/apache/#{site_name}"

template "/etc/httpd/conf.d/#{site_name}.conf" do
	source "custom.erb"
	mode "0644"
	variables(
	   :document_root => document_root,
	   :port => site_data["port"]
          )
	notifies :restart, "service[httpd]"
end

directory document_root do
	mode "0755"
	recursive true
end


template "#{document_root}/index.html" do
	source "index.html.erb"
	mode	"0644"
	variables(
	:site_name => site_name,
	:port	=> site_data["port"]
	)
	end
end

service 'httpd' do
        action [:enable,:start]
end
