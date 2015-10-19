#
# Cookbook Name:: jboss
# Recipe:: deployapp
#
# Copyright 2015, Nekhai Vova
#
# All rights reserved - Do Not Redistribute
#
app_url = node['testapp']['url']
app_zip = app_url.split('/')[-1]
app_unzip = app_zip.split('.')[0]
app_war = app_unzip + ".war"
app_file_deployment = node['jboss']['home'] + "/standalone/deployments/#{app_unzip}" + ".war"

remote_file "/tmp/#{app_zip}" do
  source app_url
  notifies :run, "bash[put_program]", :immediately
end

bash "put_program" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    unzip #{app_zip}
    chown -R #{node['jboss']['user']}:#{node['testapp']['url']} #{app_unzip}
    mv  #{app_unzip}/#{app_war} #{app_file_deployment}
    rm -f #{app_zip}
    rm -rf #{app_unzip}
  EOH
  action :nothing
end
puts "#{[app_file_deployment,app_war,app_unzip]}"

service "jboss" do
  action :restart
end