# Puppet module: hosts

This is a Puppet module for hosts
It provides only package installation and file configuration.

Based on Example42 layouts by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-hosts

Released under the terms of Apache 2 License.

This module requires the presence of Example42 Puppi module in your modulepath.


## USAGE - Overrides and Customizations
* Use custom sources for hosts file 

        class { 'hosts':
          source => [ "puppet:///modules/example42/hosts/hosts.conf-${hostname}" , "puppet:///modules/example42/hosts/hosts.conf" ], 
        }


* Use custom template for hosts file. Note that template and source arguments are alternative. 

        class { 'hosts':
          template => 'example42/hosts/hosts.conf.erb',
        }

* Automatically include a custom subclass

        class { 'hosts':
          my_class => 'example42::my_hosts',
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-hosts.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-hosts]
