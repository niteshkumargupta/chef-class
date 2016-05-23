search("node", "platform:centos").each do |server|
  log "The Centos server in your organization have the following FQDN/IP Addresses:- #{server["fqdn"]}/#{server["ipaddress"]}"
end
