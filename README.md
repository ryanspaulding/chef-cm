Bootstrap
----------
The bootstrap script is designed to be run as root one time during the systems creation. Note if you run it multiple times it will not break anything. The script will patch the system and install enough of the packages to run Chef Solo. Once Chef Solo is setup it will git clone this repo to `/var/chef-solo` and then run Chef Solo. Chef Solo will do the rest of the system setup. Once Chef Solo is run the first time it will then reboot the box. 

To run bootstrap in one command use the following. Note you must be root to run this:

`curl -L https://raw.githubusercontent.com/ryanspaulding/chef-cm/master/bootstrap.sh | bash`

Note you could also download the file to the system and run it. If you want to run this during the EC2 spinup process you will need to go to https://raw.githubusercontent.com/ryanspaulding/chef-cm/master/bootstrap.sh and copy the contents of the page. Then paste this into the user data field on step 3 of the setup process. Once the system is spinning up you can tail the log file under /tmp/bootstap.log. 

Chef
-----------
Since we are not running our own Chef server or having Chef hosted we are using GitHub to manage our Chef recipes. What this means is that on each host has a copy of this Git repo under `/var/chef-solo`. If you want to make changes and ensure that they get propagated to hosts you want managed you will need to make the changes locally and push these changes to GitHub. Once on the system you can get the latest Chef files by running 'runchef'. The `runchef` command is a wrapper for updating the Git reop (under `/var/chef-solo`) and then running the chef-solo command with the correct options. 


