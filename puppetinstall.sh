#!/bin/bash
#
#
#Install Puppet source list and Puppet.

#Install a specific version of puppet. (Ex: 3.8.3-1puppetlabs1)
VERSION=3.8.1-1puppetlabs1

#Linux release
RELEASE=`lsb_release -c | awk '{print $2}'`;

cat<<'__EOF__'>>/etc/apt/sources.list.d/puppetlabs.list
# Puppetlabs products
deb http://apt.puppetlabs.com DIST main
deb-src http://apt.puppetlabs.com DIST main

# Puppetlabs dependencies
deb http://apt.puppetlabs.com DIST dependencies
deb-src http://apt.puppetlabs.com DIST dependencies

# Puppetlabs devel (uncomment to activate)
# deb http://apt.puppetlabs.com DIST devel
# deb-src http://apt.puppetlabs.com DIST devel
__EOF__

sed -i 's/DIST/$RELEASE/g' /etc/apt/sources.list.d/puppetlabs.list

#Install Puppet & Puppet-common.

apt-get install puppet=$VERSION puppet-common=$VERSION;



#Set hold on puppet and puppet-common.
apt-mark hold puppet puppet-common;


#Run puppet once after install 
puppet agent -t;
