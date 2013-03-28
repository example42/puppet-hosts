class hosts::dynamic {
  $magic_tag = get_magicvar($hosts::dynamic_magicvar)

  $real_tag = $hosts::bool_dynamic_exclude ? {
    true    => "Excluded",
    default => "env-${magic_tag}",
  }

  @@host { $::fqdn:
    ip           => $hosts::dynamic_ip,
    host_aliases => $hosts::dynamic_alias,
    tag          => $real_tag,
  }
  
  Host <<| tag == "env-${magic_tag}" |>> {
    ensure  => present,
    require => File['hosts.conf'],
  }

}
