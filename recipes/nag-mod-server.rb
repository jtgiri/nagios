case node["platform"]
when "debian", "ubuntu"
include_recipe "apt"
include_recipe "nagios::server"
include_recipe "nagios::mod-gearman"
else
Chef::Log.fatal('Platform is not debian or ubuntu')
fail
end
