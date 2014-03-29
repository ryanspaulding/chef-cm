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
    content 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClDuVmJ3xicacrKtYWniYdz4ycvVsKe9bOiuEg7BNUw7qFq4w0USOIZkPJMwzmtpnjXkpll8N832AxNhHdYO0ED6W3EIhkwjfrFKKtnYQcuAe2ibm+llY61vOd8BSDxOPgFBNXiF2ODgJ4tDvGhTApAXO/PaOLscFHKSq+N1D4YKQAZy2PB8JyX0prmKVsp0H08okFqpPkb6cAV/hcO2gsI3tWualUvwQz+hIJ5ClnGFzZdiQLFwDpHaTSP4WLWiyg8PE1fbL7ev75zsBvGJLElamntbYejCdTwh5cx20O3V0WQUCIWhVno0/3kgjCI++OeO+xYZ9m3eJODwzQdML5'
    action :create
end

user "christopher" do
    comment "christopher@climatemonkeys.com"
    system false 
    shell "/bin/bash"
    gid "dev"
    supports :manage_home => true
    home "/home/christopher"  
end

directory "/home/christopher/.ssh" do
    owner 'christopher'
    group 'dev'
    mode 0700
    action :create
end

file "/home/christopher/.ssh/authorized_keys" do
    owner 'christopher'
    group 'dev'
    mode 0600
    content 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCEIrNvCJBgxdfSOodLPnFcC60xhQRpux4XzDTakfr8eOygFl0+L0iRuyLHdwa0xs9DwgGhs0roR7NlJDobdhewTKQwXXiyckGO/hSCC2pE4ltKkNfUGaINihfWEBv0hFIz9qnFy5RA0nmfLkKg8ahEakJCNoTatRmJtY4Rp+gauuMCh/dBVcYhNTiQ/abJmqQtG2BpwyI8b4EKlVBywvzx8tg1ZcMG2mBQiDHHouLB6a48kt+0X9Bnt5kVE8DJdh3KlKLaR+7GUrEkxwe4HIRZrI/Vb/5WSsCNm57WPT6jwufpucnwwNn3IMcjRQBDRdUv8JCTv31fP4L1NvbQNlzr' 
    action :create
end
