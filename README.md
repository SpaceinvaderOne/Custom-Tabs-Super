# Unraid Custom Tabs Super

This script enhances the functionality of the Unraid server GUI by integrating with Custom Tabs plugin to allow users to create custom tabs that execute specific commands or scripts when the tab is clicked. It supports both immediate execution and delayed execution with a countdown timer, providing a safety mechanism to prevent accidental execution.

## Features

- Run custom commands or scripts from each tab
- Immediate or delayed execution
- Customisable URLs for redirection after command execution
- Customisable message to display when tab clicked
- Easy setup with automated creation of all files. Readme generated with your custom links for the Custom Tabs plugin

## Prerequisites

1. Install the Custom Tab plugin from the Unraid Community Applications (CA).
2. Install the User Scripts plugin  from the Unraid Community Applications (CA).

## Installation

1. Open the User Scripts plugin in the Unraid GUI.
2. Create a new script and name it **"custom tabs super"**.
3. Copy the script from the GitHub repository and paste it into the newly created script in the User Scripts plugin.

## Configuration

Edit the script to configure custom commands and URLs.

### Custom Commands

Define your custom commands in the `execute_case_X_commands` functions.<br>
For example the command 'etherwake C8:B1:92:78:42:44'  is places as in example 1. <br>
For example to run a script you use bash then location of the script in quotes see example 2. <br>
#### Example 1: Waking Another Server

```bash
#################################
## Custom Tab Super 1  ##########
#################################

execute_case_1_commands() {
    # commands between here 
    etherwake C8:B1:92:78:42:44
	# and here -- dont delete the return below !!
    return
}

custom1_redirect="http://10.10.20.199" 
custom_message_1="Waking BaseStar Server"   
```

#### Example 2: Running a Backup script

```bash
execute_case_2_commands() {
    bash "/boot/config/plugins/user.scripts/scripts/backup/script" &
    return
}
custom2_redirect="http://10.10.20.199" 
custom_message_2="Waking BaseStar Server"   
```
### Redirection URLs and Custom Messages

After setting the commands you will see <br> 
1. variable customX_redirect  set that to the URL you want the tab to end up at <br>
2. variable custom_message_X  this can be set to display a message when the tab is clicked <br>
Example of this from 'Example 2' above <br>
URL points to the IP of an Unraid server <br>
Message says "Running backup script" <br>

```
custom2_redirect="http://10.10.20.199" 
custom_message_2="Running backup script"   
```

### Usage

After filling out the script, run the script from the User Scripts interface. This will generate a custom README file with your custom URLs for your server. The README file will be located in the `system` share at the following path:

    /mnt/user/system/custom_pages/README.txt

Follow these steps to create a new custom tab:

1. Open the Custom Tab plugin interface.
2. Add a new tab and name it as desired.
3. Copy the appropriate URL from the generated README file and paste it into the URL field for the custom tab.

- Use a plain URL to run the command instantly.
- Use a countdown URL for running commands that you do not want to risk executing accidentally.

The plain URLs will look like this:

    http://<YOUR_SERVER_IP>/mycustompages/custom1.html
    http://<YOUR_SERVER_IP>/mycustompages/custom2.html
    http://<YOUR_SERVER_IP>/mycustompages/custom3.html
    http://<YOUR_SERVER_IP>/mycustompages/custom4.html
    http://<YOUR_SERVER_IP>/mycustompages/custom5.html
    http://<YOUR_SERVER_IP>/mycustompages/custom6.html

The countdown URLs will look like this:

    http://<YOUR_SERVER_IP>/mycustompages/custom1_countdown.html
    http://<YOUR_SERVER_IP>/mycustompages/custom2_countdown.html
    http://<YOUR_SERVER_IP>/mycustompages/custom3_countdown.html
    http://<YOUR_SERVER_IP>/mycustompages/custom4_countdown.html
    http://<YOUR_SERVER_IP>/mycustompages/custom5_countdown.html
    http://<YOUR_SERVER_IP>/mycustompages/custom6_countdown.html

### Debugging

Enable debugging by setting DEBUG="yes" in the script. Logs will be saved to /mnt/user/system/custom_pages/script.log.

### License

This project is licensed under the MIT License. Feel free to contribute or open issues if you encounter any problems.

