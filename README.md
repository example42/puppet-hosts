# Deprecation notice

This module was designed for Puppet versions 2 and 3. It should work also on Puppet 4 but doesn't use any of its features.

The current Puppet 3 compatible codebase is no longer actively maintained by example42.

Still, Pull Requests that fix bugs or introduce backwards compatible features will be accepted.


# Puppet module: hosts

This is a Puppet module to manage /etc/hosts

It allows its population in different ways, either static or dynamic

Written by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-hosts

Released under the terms of Apache 2 License.

This module requires the presence of Example42 Puppi module in your modulepath.


## USAGE

This module provide different options for managing /etc/hosts

1 -  Use custom static sources for hosts file (also an array)

        class { 'hosts':
          source => [ "puppet:///modules/example42/hosts/hosts.conf-${hostname}" ,
                      "puppet:///modules/example42/hosts/hosts.conf" ], 
        }


2 - Use custom template for hosts file. Note that template and source arguments are alternative. 

        class { 'hosts':
          template => 'example42/hosts/hosts.conf.erb',
        }

3 - Dynamically populate /etc/hosts with all the nodes of your Puppet infrastructure

        class { 'hosts':
          dynamic_mode => true,
        }


## DYNAMIC MODE USAGE

In dynamic mode you have various options that allows you to fine tune the automatic
collection of host entries in /etc/hosts:

* To add a common header to /etc/hosts (by default the existing entries are not modified):

        class { 'hosts':
          dynamic_mode     => true,
          dynamic_template => 'example42/hosts/header.erb',
        }

(The above adds an header taken from $MODULEPATH/example42/templates/hosts/header.erb)

* To collect on /etc/hosts only nodes that share the same value for a given variable:

        class { 'hosts':
          dynamic_mode     => true,
          dynamic_magicvar => 'environment',
        }

(Here you'll find in /etc/hosts only the nodes that share the same $environment)

* To exclude a specific host from automatic collection on other nodes

        class { 'hosts':
          dynamic_mode     => true,
          dynamic_exclude  => $::role ? {
            puppetmaster => true,
            default      => false,
          }
        }

(In the above example the puppetmaster's host entry won't be automatically added to the other nodes (you might force it in the header template). Note that the puppetmaster
itself will continue to populate its /etc/hosts dynamically as the other nodes.)

* To specify custom variables to use for IP or alias entries:

        class { 'hosts':
          dynamic_mode => true,
          dynamic_ip    => $::ec2_public_ipv4,
          dynamic_alias => [ $::hostname , $::ec2_hostname ],
        }

(By default $::ipaddress and [ $::hostname ] are used.


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-hosts.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-hosts]
