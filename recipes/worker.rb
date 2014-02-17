%w{ mod-gearman-tools mod-gearman-worker}.each do |pkg|
   package pkg do
    action :install
   end
 end

  worker_conf 'worker' do
   variables(:hostgroups => hostgroups)
  end
   

 directory "/var/log/mod-gearman" do
   owner 'nagios'
   group 'nagios'
   action :create
 end

 service "mod-gearman-worker" do
   action [:enable, :restart]
 end


