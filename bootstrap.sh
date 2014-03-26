#!/bin/bash

LOGFILE="/root/bootstrap.log"

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
gem install chef | tee -a ${LOGFILE}

# git checkout chef crap 

# build chef-solo file 

# build runlist file 
