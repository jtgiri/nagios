define :worker_conf, :variables => {}, :config_subdir => true, :source => nil do

  conf_dir = params[:config_subdir] ? node['gearman']['config_dir'] : node['gearman']['conf_dir']
  params[:source] ||= "#{params[:name]}.conf.erb"

  template "#{conf_dir}/#{params[:name]}.conf" do
    owner node['nagios']['user']
    group node['nagios']['group']
    source params[:source]
    mode 00644
    variables params[:variables]
    notifies :reload, 'service[mod-gearman-worker]'
    backup 0
  end
end

