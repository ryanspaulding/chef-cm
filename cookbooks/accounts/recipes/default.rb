# this is a place holder. Need too fingure out if we leave
# the password option off what it does when it creates the account

group "dev" do
    action :create
    system false
end

user "systemguy" do
  comment "system guy"
  system true
  shell "/bin/false"
end
