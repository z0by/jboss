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

jboss_tar = jboss_url.split('/')[-1] + ".tar.gz"

remote_file "/tmp/#{jboss_tar}" do
  source jboss_url
  notifies :run, "bash[install_program]", :immediately
end

bash "install_program" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    tar -zxf #{jboss_tar}
    mv #{jboss_tar} #{jboss_home}
    rm -f jboss-as-7.1.1.Final.tar.gz    
  EOH
  action :nothing
end

directory jboss_home do
  group jboss_user
  owner jboss_user
  mode "0755"
end
