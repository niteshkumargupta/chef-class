service "apache2" do
	action [:enable]
	supports :reload => true
end
