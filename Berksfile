source "https://supermarket.getchef.com"

metadata

cookbook 'rackops_rolebook', git: 'https://github.com/rackops/rackops_rolebook.git'
cookbook 'cron', git: 'https://github.com/rackspace-cookbooks/cron.git'

group :integration do
  cookbook 'disable_ipv6', path: 'test/fixtures/cookbooks/disable_ipv6'
  cookbook 'wrapper', path: 'test/fixtures/cookbooks/wrapper'
  cookbook 'apt'
  cookbook 'yum'
end
