# Increases the amount of traffic an Nginx server can handle

# Increase the ULIMIT of the default file
exec { 'fix--for-nginx':
  command => 'sed -i "s/15/4096/" /etc/default/nginx',
  path    => '/bin', # Corrected path to sed command
}

# Restart Nginx using service resource
service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Exec['fix--for-nginx'], # Ensure fixing ulimit happens before service restart
  subscribe => Exec['fix--for-nginx'], # Restart if ulimit is fixed
}
