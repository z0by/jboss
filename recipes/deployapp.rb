

remote_file "/tmp/testweb.zip" do
  source "http://www.cumulogic.com/download/Apps/testweb.zip"
  #checksum node[:program][:checksum]
  notifies :run, "bash[put_program]", :immediately
end

bash "put_program" do
  user "root"
  cwd "/tmp"
  code <<-EOH
    unzip testweb.zip
    chown -R jboss:jboss testweb
    mv /tmp/testweb/testweb.war /usr/local/share/jboss/standalone/deployments/testweb.war.deployed
    rm -rf testweb.zip
    #mv testweb /usr/local/share/jboss
    #chown -R jboss:jboss /usr/local/share/jboss
    #rm -f jboss-as-7.1.1.Final.tar.gz
  EOH
  action :nothing
end

#service "jboss" do
#  action :restart
#end