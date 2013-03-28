class hosts::dynamic {
  $magic_tag = get_magicvar($hosts::dynamic_magicvar)

  @@host { $::fqdn:
    ip           => $::ipaddress
    host_aliases => [ $::hostname ],
    tag          => "env-${::magic_tag}";
  }
  
  Host <<| tag == "env-${magic_tag}" |>> {
    ensure  => present,
    require => File['hosts.conf'],
  }

}
