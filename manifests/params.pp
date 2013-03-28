# Class: hosts::params
#
# This class defines default parameters used by the main module class hosts
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to hosts class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class hosts::params {

  ### Class related parameters
  $dynamic_mode = false
  $dynamic_magicvar = ''
  $dynamic_template = ''

  ### Application related parameters

  $config_file = $::operatingsystem ? {
    default => '/etc/hosts',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  # General Settings
  $my_class = ''
  $source = ''
  $template = ''
  $absent = false
  $audit_only = false
  $noops = false

}
