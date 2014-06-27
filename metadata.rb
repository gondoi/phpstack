# Encoding: utf-8

name 'phpstack'
maintainer 'Rackspace UK, Ltd.'
maintainer_email 'rackspace-cookbooks@rackspace.com'
license 'Apache 2.0'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
description 'Provides a full php stack'

version '0.0.3'

depends 'apache2', '~> 1.10'
depends 'application'
depends 'application_php'
depends 'apt'
depends 'build-essential'
depends 'chef-sugar'
depends 'database'
depends 'elasticsearch'
depends 'git'
depends 'java'
depends 'memcached'
depends 'mongodb'
depends 'mysql'
depends 'mysql-multi'
depends 'openssl'
depends 'php'
depends 'php-fpm'
depends 'platformstack'
depends 'postgresql'
depends 'rabbitmq'
depends 'redisio'
depends 'rackspace_gluster'
depends 'varnish'
depends 'yum'
