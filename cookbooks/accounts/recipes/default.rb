# this is a place holder. Need too fingure out if we leave
# the password option off what it does when it creates the account

group "dev" do
    action :create
    system false
end

user "ryans" do
    comment "ryan@climatemonkeys.com"
    system false 
    shell "/bin/bash"
    gid "dev"
    supports :manage_home => true
    home "/home/ryans"  
end
