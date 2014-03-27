#!/bin/bash

LOGFILE="/root/bootstrap.log"
CHEFCONFIG="/etc/chef/"
CHEFFILES="/var/chef-solo/"
GITURL="git@github.com:ryanspaulding/chef.git"

function log {
        echo "[`date`] ${1}" | tee -a ${LOGFILE}
}

if [ ! -f "${LOGFILE}" ]
then
        touch ${LOGFILE} 
fi

# yum update 
log "Updating System"
yum check-update | tee -a ${LOGFILE}

log "Installing packages needed for Chef"
yum install -y git ruby ruby-devel rubygems rubygems-devel gcc | tee -a ${LOGFILE}

# to install chef we need to install ruby 1.9.2 the default version from RHEL is 1.8.7 so we will need to 
# install software collections: https://access.redhat.com/site/documentation/en-US/Red_Hat_Developer_Toolset/1/html/Software_Collections_Guide/sect-Enabling_Support_for_Software_Collections.html
log "Installing software collections"
yum install -y scl-utils scl-utils-build | tee -a ${LOGFILE}

log "Installing Ruby 1.9.2"
yum install -y ruby1.9.2 # TODO get correct package name

log "Installing Chef"
slc enaable ruby1.9.2 'gem install chef' | tee -a ${LOGFILE} # TODO get correct package name

# git checkout chef crap 
if [ ! -d "${CHEFFILES}" ]
then
    git clone ${GITURL} ${CHEFFILES} 
else
    cd "${CHEFFILES}" && git pull origin master
fi

# build chef-solo file 
if [ ! -d "${CHEFCONFIG}" ]
then
    mkdir -p "${CHEFCONFIG}"
fi

if [ ! -f "${CHEFCONFIG}solo.rb" ]
then
cat << 'SOLO' > "${CHEFCONFIG}solo.rb"
file_cache_path "${CHEFCONFIG}"
cookbook_path "${CHEFCONFIG}cookbooks"
role_path "${CHEFCONFIG}roles"
file_backup_path "${CHEFCONFIG}backups" 
cache_type "BasicFile"
cache_options({ :path => "${CHEFCONFIG}cache/checksums", :skip_expires => true })" 
SOLO
fi

# build runlist file 
if [ ! -f "${CHEFFILES}runlist.json" ]
then
cat << 'RUN' > "${CHEFFILES}runlist.json"
{ "run_list": "role[devbox]" }
RUN

# run chef 
chef-solo -j ${CHEFFILES}runlist.json
