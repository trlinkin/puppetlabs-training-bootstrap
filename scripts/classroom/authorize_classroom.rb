#! /usr/bin/env ruby
require 'yaml'

hosts = {}
`puppet cert list --all`.split("\n").each do |line|
  if line =~ /^\+\s"(\S*.puppetlabs.vm)"\s.*$/
    hosts[$1] = { 'role' => 'read-only' }
  end
end
hosts['classroom.puppetlabs.vm'] = { 'role' => 'read-write' }

File.open('/etc/puppetlabs/console-auth/certificate_authorization.yml', 'w') do |f|
  f.write hosts.to_yaml
end

system('service pe-httpd restart')
