template "/usr/local/bin/runchef" do
    source "runchef.erb"
    mode 0755
    owner "root"
    group "root"
    variables(:chefhome => "/var/chef-solo")
end
