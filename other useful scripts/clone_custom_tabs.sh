#!/bin/bash
#set -x
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# #   Script to run commands from custom tabs on an Unraid Server								 
# #   by - SpaceInvaderOne																		
# #																								 
# #   needs Andrew Zawadzki's aka Squid's awesome Custom Tab plugin								 
# #                                                           										                                                                            
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# --------------------------
# USER CONFIGURATION SECTION
# --------------------------
copy_from_other_server="yes"  # Set to "yes" to copy from remote server
remote_server_ip="IP_OF_SERVER_TO_CLONE_FROM"  # IP address of the remote server

####################################################################
# -------------------------------
# END USER CONFIGURATION SECTION  ##################################
# -------------------------------
####################################################################


IPV4_ADDRESS=$(hostname -I | awk '{print $1}')  #get server ip

# get path to the JSON file
JSON_FILE="/boot/config/plugins/customtab/customtab.json"
REMOTE_JSON_FILE="//${remote_server_ip}/flash/config/plugins/customtab/customtab.json"
REMOTE_MOUNT_DIR="/tmp/remote_flash"

# if set copy from remote server
if [ "$copy_from_other_server" == "yes" ]; then
    mkdir -p "$REMOTE_MOUNT_DIR"
    if mount -t cifs -o username=guest,password=guest "//${remote_server_ip}/flash" "$REMOTE_MOUNT_DIR"; then
        echo "Mounted remote server at $REMOTE_MOUNT_DIR"
        
        # copy the custom tabs json from the remote server
        if cp "$REMOTE_MOUNT_DIR/config/plugins/customtab/customtab.json" "$JSON_FILE"; then
            echo "File copied from remote server $remote_server_ip"
        else
            echo "Failed to copy the file from the remote server"
            umount "$REMOTE_MOUNT_DIR"
            rmdir "$REMOTE_MOUNT_DIR"
            exit 1
        fi
        
        # unmount the remote directory and remove the mount point
        umount "$REMOTE_MOUNT_DIR"
        rmdir "$REMOTE_MOUNT_DIR"
    else
        echo "Failed to mount the remote server"
        rmdir "$REMOTE_MOUNT_DIR"
        exit 1
    fi
fi

# update the ip address in json to match current server 
jq --arg ip "$IPV4_ADDRESS" '
  .[] |= (if .tabURL | contains("/mycustompages/") then
            .tabURL |= sub("http://[^/]+"; "http://\($ip)")
          else
            .
          end)
' "$JSON_FILE" > /tmp/updated_customtab.json

# Replace the original file with the updated one
mv /tmp/updated_customtab.json "$JSON_FILE"

echo "IP addresses updated successfully in $JSON_FILE"

