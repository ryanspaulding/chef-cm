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

directory "/home/ryans/.ssh" do
    owner 'ryans'
    group 'dev'
    mode 0700
    action :create
end

file "/home/ryans/.ssh/authorized_keys" do
    owner 'ryans'
    group 'dev'
    mode 0600
    content 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClDuVmJ3xicacrKtYWniYdz4ycvVsKe9bOiuEg7BNUw7qFq4w0USOIZkPJMwzmtpnjXkpll8N832AxNhHdYO0ED6W3EIhkwjfrFKKtnYQcuAe2ibm+llY61vOd8BSDxOPgFBNF2ODgJ4tDvGhTApAXO/PaOLscFHKSq+N1D4YKQAZy2PB8JyX0prmKVsp0H08okFqpPkb6cAV/hcO2gsI3tWualUvwQz+hIJ5ClnGFzZdiQLFwDpHaTSP4WLWiyg8PE1fbL7ev75zsBvGJLElamntbYejCdTwh5cx20O3V0WQUCIWhVno0/3kgjCI++OeO+xYZ9m3eJODwzQdML5'
    action :create
end
