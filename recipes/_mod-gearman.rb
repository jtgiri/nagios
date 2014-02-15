case node["platform"]
when "debian", "ubuntu"
include_recipe "apt"
# Installing packges
%w{gearman-job-server gearman-tools mod-gearman-module mod-gearman-tools mod-gearman-worker}.each do |pkg|
  package pkg do
  action :install
  end
end

# Creating Mod-gearman Config files

template "/etc/mod-gearman/mod_gearman.cfg" do
  source "mod_gearman.cfg.erb"
  action :create_if_missing
end

template "/etc/mod-gearman/module.conf" do
  source "module.conf.erb"
  action :create
end

worker_conf 'worker' do
  variables(:hostgroups => node.hostgroups)
end


template "/etc/default/gearman-job-server" do
  source "gearman-job-server.erb"
  action :create
end

# Creating Log dir
directory "/var/log/mod-gearman" do
  owner 'nagios'
  group 'nagios'
  action :create
end

# Restarting services
service "nagios3" do
 action [:enable, :restart]
end

service "gearman-job-server" do
  action [:enable, :restart]
end

service "mod-gearman-worker" do
  action [:enable, :restart]
end

else
Chef::Log.error('Platform is not debian or ubuntu')
end

