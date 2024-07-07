# Unraid Custom Tabs Super - Helper scripts


## Clone_custom_tabs.sh

- Will copy the custom tabs settings from one server to another
- Any references to the Custom Tabs Super locations will be updated to reflect IP of server running the script

### Usage

1. Open the User Scripts plugin in the Unraid GUI.
2. Create a new script and name it 
3. Copy the script from the GitHub repository and paste it into the newly created script in the User Scripts plugin.
4. If you want to copy from remote server set copy_from_other_server="yes"  set to "no" and current custom tabs file will be checked for correct ips
5. If cloning from remote server set ip  example  remote_server_ip="10.10.20.199"
6. Run script
7. Open custom tabs in settings.  Click apply for new config to be used. (you will have to make a change in gui then change back)


##  start_vm_performance.sh

- Will start a VM and set server into performance mode
- Should be called from a case in Custom Tabs Super script

### Usage

1. Open the User Scripts plugin in the Unraid GUI.
2. Create a new script and name it 
3. Copy the script from the GitHub repository and paste it into the newly created script in the User Scripts plugin.
4. set name of vm to start in variable vmname  ie vmname="Windows 11"
5. Get location of script
6. Add to a case in Custom Tabs Super scipt - 
example
```bash
execute_case_2_commands() {
    echo "starting vm and setting server to performance mode"
    bash "/boot/config/plugins/user.scripts/scripts/Start_windows_11/script" &
    return
}

```

### License

This project is licensed under the MIT License. Feel free to contribute or open issues if you encounter any problems.

