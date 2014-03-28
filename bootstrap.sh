#!/bin/bash

LOGFILE="/root/bootstrap.log"
CHEFCONFIG="/etc/chef/"
CHEFFILES="/var/chef-solo/"
GITURL="https://github.com/ryanspaulding/chef-cm.git"

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

log "Installing Chef"
if [ ! -f /usr/bin/chef-solo ]
then
	curl -L https://www.opscode.com/chef/install.sh | bash
fi

log "Getting Chef files from GitHub"
if [ ! -d "${CHEFFILES}" ]
then
    git clone ${GITURL} ${CHEFFILES} | tee -a ${LOGFILE}
else
    cd "${CHEFFILES}" && git pull origin master tee -a ${LOGFILE}
fi

# build chef-solo file 
log "Setting up Chef solo config"
if [ ! -d "${CHEFCONFIG}" ]
then
    mkdir -p "${CHEFCONFIG}"
fi

if [ ! -f "${CHEFCONFIG}solo.rb" ]
then
cat > "${CHEFCONFIG}solo.rb" <<SOLO
file_cache_path "${CHEFFILES}"
cookbook_path "${CHEFFILES}cookbooks"
role_path "${CHEFFILES}roles"
file_backup_path "${CHEFFILES}backups" 
cache_type "BasicFile"
cache_options({ :path => "${CHEFFILES}cache/checksums", :skip_expires => true })
SOLO
fi

log "Creating runlist.json"
if [ ! -f "${CHEFFILES}runlist.json" ]
then
cat > "${CHEFFILES}runlist.json" <<RUN
{ "run_list": "role[devbox]" }
RUN
fi

log "Cheffing!!!!!"
chef-solo -j ${CHEFFILES}runlist.json | tee -a ${LOGFILE}
