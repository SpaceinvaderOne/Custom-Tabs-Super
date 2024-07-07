#!/bin/bash
#set -x
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# #   Script to run a vm making sure server is in performance mode							 
# #   by - SpaceInvaderOne																																																 
# #                                                           										                                                                            
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# ----------------------------
# USER CONFIGURATION SECTION
# ----------------------------

# set vm name to start in the quotes below  ie vmname="Windows 11"

vmname=""

####################################################################
# -------------------------------
# END USER CONFIGURATION SECTION  ##################################
# -------------------------------
####################################################################

# set to performance
set_performance_governor() {
    for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
        echo performance | tee $cpu
    done
}

# start the vm
start_vm() {
    virsh start "$vmname"
}

############

set_performance_governor
start_vm
