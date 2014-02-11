include_recipe "apt"

%w{gearman-job-server gearman-tools mod-gearman-module mod-gearman-tools mod-gearman-worker}.each do |pkg|
  package pkg do
  action :install
  end
end

template "/etc/mod-gearman/mod_gearman.cfg" do
  source "mod_gearman.cfg.erb"
  action :create_if_missing
end

template "/etc/mod-gearman/module.conf" do
  source "module.conf.erb"
  action :create_if_missing
end

template "/etc/mod-gearman/worker.conf" do
  source "worker.conf.erb"
  action :create
end

template "/etc/default/gearman-job-server" do
  source "gearman-job-server.erb"
  action :create
end

service "gearman-job-server" do
  action [:enable, :restart]
end

service "mod-gearman-worker" do
  action [:enable, :restart]
end
