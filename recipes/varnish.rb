# Encoding: utf-8
#
# Cookbook Name:: phpstack
# Recipe:: application_php
#
# Copyright 2014, Rackspace Hosting
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'chef-sugar'
if platform_family?('debian')
  include_recipe 'apt'
end

add_iptables_rule('INPUT', "-p tcp --dport #{node['varnish']['listen_port']} -j ACCEPT", 9997, 'allow web browsers to connect')

# let us set up a more complicated vcl config if needed
node.default['varnish']['vcl_cookbook'] = 'phpstack' if node['phpstack']['varnish']['multi']
node.default['varnish']['vcl_source'] = 'varnish-default-vcl.erb' if node['phpstack']['varnish']['multi']
# set the default port to send things on to something that might be useful
node.default['varnish']['backend_port'] = node['apache']['listen_ports'].first

# pull a list of backend hosts to populate the template
# node.default['phpstack']['varnish']['backend_hosts'] = Hash.new
backend_hosts = {}
if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search.')
  backend_nodes = nil
else
  backend_nodes = search('node', 'tags:app_node' << " AND chef_environment:#{node.chef_environment}")
end

backend_nodes.each do |backend_node|
  if backend_node.deep_fetch('apache', 'sites').nil?
    errmsg = 'Did not find sites, default.vcl not configured'
    Chef::Log.warn(errmsg)
  else
    node['apache']['sites'].each do |site_name|
      site_name = site_name[0]
      site = node['apache']['sites'][site_name]
      backend_hosts.merge!(
        best_ip_for(backend_node) => {
          site['port'] => {
            site_name => site_name
          }
        }
      )
    end
  end
end

node.default['phpstack']['varnish']['backends'] = backend_hosts

include_recipe 'varnish::default'
