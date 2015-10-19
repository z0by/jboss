#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright 2015, Nekhai Vova
#
# All rights reserved - Do Not Redistribute
#

include_recipe "java"

jboss_user = node['jboss']['user']
jboss_home = node['jboss']['home']
jboss_version = node['jboss']['version']
jboss_url = node['jboss']['url']


user jboss_user do
  comment 'jboss_user user'
end

jboss_tar = jboss_url.split('/')[-1]
jboss_dir = jboss_tar.split('.tar')[0]

remote_file "/tmp/#{jboss_tar}" do
  source jboss_url
  notifies :run, "bash[install_program]", :immediately
end

bash "install_program" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxf #{jboss_tar}
    mv #{jboss_dir}/* #{jboss_home}/
    chown -R #{jboss_user}:#{jboss_user} #{jboss_home}/
    rm -f  #{jboss_tar}
    rm -rf #{jboss_dir}
  EOH
  action :nothing
end

# template init file
template "/etc/init.d/jboss" do
  source "init.erb"
  mode "0755"
  owner "root"
  group "root"
  variables(
    :jboss_user => jboss_user,
    :jboss_home => jboss_home, 
)
end

service "jboss" do
  action :restart
end
