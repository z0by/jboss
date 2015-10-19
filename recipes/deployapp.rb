#
# Cookbook Name:: jboss
# Recipe:: deployapp
#
# Copyright 2015, Nekhai Vova
#
# All rights reserved - Do Not Redistribute
#
app_url = node['testapp']['url']
app_zip = app_url.split('/')[-1] + ".zip"
app_unzip = app_url.split('/')[-1]

remote_file "/tmp/#{app_zip}" do
  source app_url
  notifies :run, "bash[put_program]", :immediately
end

bash "put_program" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    unzip app_zip
    chown -R node['jboss']['user']:node['testapp']['url'] app_unzip
    mv  app_unzip/app_unzip+".war"node['jboss']['home'] + "/standalone/deployments/#{app_unzip}" + ".war.deployed"
    rm -f app_zip
    rm -rf app_unzip    
  EOH
  action :nothing
end


file node['jboss']['home'] + "/standalone/deployments/#{app_unzip}" + ".war.deployed" do
  action :touch
end

service "jboss" do
  action :restart
end