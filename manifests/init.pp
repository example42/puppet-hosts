# = Class: hosts
#
# This is the main hosts class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, hosts class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $hosts_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, hosts main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $hosts_source
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, hosts main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $hosts_template
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $hosts_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: false
#
# Default class params - As defined in hosts::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*config_file*]
#   Main configuration file path
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include hosts"
# - Call hosts as a parametrized class
#
# See README for details.
#
#
class hosts (
  $dynamic_mode        = params_lookup( 'dynamic_mode' ),
  $dynamic_magicvar    = params_lookup( 'dynamic_magicvar' ),
  $dynamic_template    = params_lookup( 'dynamic_template' ),
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $template            = params_lookup( 'template' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $noops               = params_lookup( 'noops' ),
  $config_file         = params_lookup( 'config_file' )
  ) inherits hosts::params {

  $config_file_mode=$hosts::params::config_file_mode
  $config_file_owner=$hosts::params::config_file_owner
  $config_file_group=$hosts::params::config_file_group

  $bool_dynamic_mode=any2bool($dynamic_mode)
  $bool_audit_only=any2bool($audit_only)
  $bool_noops=any2bool($noops)

  ### Definition of some variables used in the module
  $manage_audit = $hosts::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $hosts::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $hosts::source ? {
    ''        => undef,
    default   => $hosts::source,
  }

  $manage_file_content = $hosts::template ? {
    ''        => $hosts::dynamic_template ? {
      ''      => undef,
      default => $hosts::dynamic_template,
    },
    default   => template($hosts::template),
  }

  ### Managed resources
  file { 'hosts.conf':
    ensure  => present,
    path    => $hosts::config_file,
    mode    => $hosts::config_file_mode,
    owner   => $hosts::config_file_owner,
    group   => $hosts::config_file_group,
    source  => $hosts::manage_file_source,
    content => $hosts::manage_file_content,
    replace => $hosts::manage_file_replace,
    audit   => $hosts::manage_audit,
    noop    => $hosts::bool_noops,
  }

  ### Include custom class if $my_class is set
  if $hosts::my_class {
    include $hosts::my_class
  }

  ### Manage hosts dynamically
  if $bool_dynamic_mode == true {
    include hosts::dynamic
  }

}
