 %w{ mod-gearman-tools mod-gearman-worker}.each do |pkg|
   package pkg do
    action :install
   end
  end
 
 srv_node = search(:node, "role:monitoring")
 node.default[:gearman][:server] = srv_node.first[:ipaddress]
  
  worker_conf 'worker' do
  end
   
 directory "/var/log/mod-gearman" do
   owner 'nagios'
   group 'nagios'
   action :create
 end

 service "mod-gearman-worker" do
   action [:enable, :restart]
 end


