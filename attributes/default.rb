node.override[:java][:openjdk_packages] = ["openjdk-7-jdk"]

default['jboss']['user'] = "jboss"
default['jboss']['home'] = "/usr/local/share/jboss"
default['jboss']['version'] = "7.1.1"
default['jboss']['url'] = "http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz"

default['testapp']['url'] = "http://www.cumulogic.com/download/Apps/testweb.zip"