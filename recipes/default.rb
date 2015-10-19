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
