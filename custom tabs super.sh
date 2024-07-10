#!/bin/bash
#set -x
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# #   Script to run commands from custom tabs on an Unraid Server								 
# #   by - SpaceInvaderOne																		
# #																								 
# #   needs Andrew Zawadzki's aka Squid's awesome Custom Tab plugin								 
# #                                                           										                                                                            
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

####################################################################
# -------------------------------
# START OF USER CONFIGURATION SECTION  #############################
# -------------------------------
####################################################################

# for each Custom Tab Super - add the commands to be executed in the execute case command section 
# between "# below is an example be sure to change to meet your needs"   and   "# and here -- dont delete the return below !!"
# as well as commands you can call other scripts by using bash then the location of the script. ie  bash "/path/to/your/other_script.sh" &
# each Custom Tab Super needs to be given a redirect URL to go to after executing the commands that should be put between the quotes  ie custom1_redirect="http://10.10.20.199"
# please note the first tab below is prefilled with dummy data as an example you will need to change this
#
#################################
## Custom Tab Super 1  ##########
#################################

execute_case_1_commands() {
	# commands between here  ...  below is an example be sure to change to meet your needs
    beep 
    etherwake C8:B1:92:78:42:44
	# and here -- dont delete the return below !!
    return
}

custom1_redirect="http://10.10.20.199" # this is an example be sure to change to meet your needs
custom_message_1="Waking BaseStar Server"   # this is an example be sure to change to meet your needs

#################################
## Custom Tab Super 2  ##########
#################################

execute_case_2_commands() {
    # commands between here 


    # and here -- dont delete the return below !!
    return
}

custom2_redirect=""   # put redirect url for custom tab 2 here between the quotes
custom_message_2=""   # you can put a message to be displayed when clicked here if wanted. otherwise leave as is.

#################################
## Custom Tab Super 3  ##########
#################################

execute_case_3_commands() {
    # commands between here 


    # and here -- dont delete the return below !!
    return
}

custom3_redirect=""   # put redirect url for custom tab 2 here between the quotes
custom_message_3=""   # you can put a message to be displayed when clicked here if wanted. otherwise leave as is.

#################################
## Custom Tab Super 4  ##########
#################################

execute_case_4_commands() {
    # commands between here 


    # and here -- dont delete the return below !!
    return
}

custom4_redirect=""   # put redirect url for custom tab 2 here between the quotes
custom_message_4=""   # you can put a message to be displayed when clicked here if wanted. otherwise leave as is.

#################################
## Custom Tab Super 5  ##########
#################################

execute_case_5_commands() {
    # commands between here 


    # and here -- dont delete the return below !!
    return
}

custom5_redirect=""   # put redirect url for custom tab 2 here between the quotes
custom_message_5=""   # you can put a message to be displayed when clicked here if wanted. otherwise leave as is.

#################################
## Custom Tab Super 6  ##########
#################################

execute_case_6_commands() {
    # commands between here 


    # and here -- dont delete the return below !!
    return
}

custom6_redirect=""   # put redirect url for custom tab 2 here between the quotes
custom_message_6=""   # you can put a message to be displayed when clicked here if wanted. otherwise leave as is.

#################################
## Custom Tab Super 7  ##########
#################################

execute_case_7_commands() {
    # commands between here 


    # and here -- dont delete the return below !!
    return
}

custom7_redirect=""   # put redirect url for custom tab 2 here between the quotes
custom_message_7=""   # you can put a message to be displayed when clicked here if wanted. otherwise leave as is.

#################################
## Custom Tab Super 8  ##########
#################################

execute_case_8_commands() {
    # commands between here 


    # and here -- dont delete the return below !!
    return
}

custom8_redirect=""   # put redirect url for custom tab 2 here between the quotes
custom_message_8=""   # you can put a message to be displayed when clicked here if wanted. otherwise leave as is.

#################################
## Custom Tab Super 9  ##########
#################################

execute_case_9_commands() {
    # commands between here 


    # and here -- dont delete the return below !!
    return
}

custom9_redirect=""   # put redirect url for custom tab 2 here between the quotes
custom_message_9=""   # you can put a message to be displayed when clicked here if wanted. otherwise leave as is.


####################################################################
# -------------------------------
# END USER CONFIGURATION SECTION  ##################################
# -------------------------------
####################################################################
#
#
#

DEBUG="no" # can be set to "yes" for debug logging
# path for the log file
LOGFILE="/mnt/user/system/custom_pages/script.log"

# get the script id from the argument passed by the php

SCRIPT_ID=$1

# logging of commands run
log_execution() {
    if [ "$DEBUG" == "yes" ]; then
        # log that a command is being run
        echo "$(date): Running command: $1" >> $LOGFILE
        # run the command and log its output and any error
        OUTPUT=$(eval $1 2>&1)
        # log the output of the command
        echo "$(date): Output: $OUTPUT" >> $LOGFILE
    else
        # run the command without logging
        eval $1 >/dev/null 2>&1
    fi
}


# create directories and symlinks
create_directory_and_symlinks() {
    DIR="/mnt/user/system/custom_pages"

    # check if the directory exists and delete it if it does
    [ -d "$DIR" ] && rm -r "$DIR"

    # create the directory
    mkdir -p "$DIR"

    # check and create symlink to userscripts location
    [ -e "$DIR/scripts" ] || { [ "$DEBUG" == "yes" ] && echo "$(date): Making symlink to scripts" >> $LOGFILE; ln -s /boot/config/plugins/user.scripts/scripts "$DIR/scripts"; }
    
    # check mycustompages symlink if exists if not make it
    [ -e "/usr/local/emhttp/mycustompages" ] || { [ "$DEBUG" == "yes" ] && echo "$(date): Creating symlink to mycustompages" >> $LOGFILE; ln -s "$DIR" /usr/local/emhttp/mycustompages; }
}


#create readme with links for ease of use
create_readme() {
    # get the IPv4 address of the server
    IPOFSERVER=$(hostname -I | awk '{print $1}')

    # path to the readme file
    README_FILE="$DIR/README.txt"

    # create the readme file
    cat <<EOF > "$README_FILE"
To use custom tabs super please do the following:

1. Install Andrew Zawadzki's aka Squid's Custom Tab plugin.

2. In the plugin add a new tab and name the Tab what you want it to be called.

3. For the URL, add the following for each case setup that you want to use (e.g., case 1 is http://$IPOFSERVER/mycustompages/custom1.html) 

For normal URL without safety countdown, please copy these urls into the custom tabs plugin

http://$IPOFSERVER/mycustompages/custom1.html
http://$IPOFSERVER/mycustompages/custom2.html
http://$IPOFSERVER/mycustompages/custom3.html
http://$IPOFSERVER/mycustompages/custom4.html
http://$IPOFSERVER/mycustompages/custom5.html
http://$IPOFSERVER/mycustompages/custom6.html
http://$IPOFSERVER/mycustompages/custom7.html
http://$IPOFSERVER/mycustompages/custom8.html
http://$IPOFSERVER/mycustompages/custom9.html

If you want to have a safety countdown before the script runs, please copy these urls into the custom tabs plugin

http://$IPOFSERVER/mycustompages/custom1_countdown.html
http://$IPOFSERVER/mycustompages/custom2_countdown.html
http://$IPOFSERVER/mycustompages/custom3_countdown.html
http://$IPOFSERVER/mycustompages/custom4_countdown.html
http://$IPOFSERVER/mycustompages/custom5_countdown.html
http://$IPOFSERVER/mycustompages/custom6_countdown.html
http://$IPOFSERVER/mycustompages/custom7_countdown.html
http://$IPOFSERVER/mycustompages/custom8_countdown.html
http://$IPOFSERVER/mycustompages/custom9_countdown.html
EOF

    [ "$DEBUG" == "yes" ] && echo "$(date): Created README file at $README_FILE" >> $LOGFILE
}


# create the html files for use with custom tabs
create_html_files() {
    for i in {1..9}
    do
        HTML_FILE="$DIR/custom${i}.html"
        redirect_var="custom${i}_redirect"
        redirect_url=${!redirect_var}
        message_var="custom_message_${i}"
        message=${!message_var}

        # check then make html file
        if [ ! -f "$HTML_FILE" ]; then
            [ "$DEBUG" == "yes" ] && echo "$(date): Creating HTML file $HTML_FILE" >> $LOGFILE
            cat <<EOF > "$HTML_FILE"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Custom Page</title>
<script>
function runScriptAndRedirect() {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/mycustompages/runscript${i}.php", true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            window.location.href = "$redirect_url";
        }
    };
    xhr.send();
}
</script>
</head>
<body onload="runScriptAndRedirect()">
<p>${message}</p>
</body>
</html>
EOF
        fi
    done
}

# create the html files for use with custom tabs with countdown so user can stop if accidentally clicked on tab

create_countdown_html() {
    for i in {1..9}; do
        local HTML_FILE_COUNTDOWN="$DIR/custom${i}_countdown.html"
        local redirect_var="custom${i}_redirect"
        local redirect_url=${!redirect_var}
        message_var="custom_message_${i}"
        message=${!message_var}

        if [ ! -f "$HTML_FILE_COUNTDOWN" ]; then
            [ "$DEBUG" == "yes" ] && echo "$(date): Creating countdown HTML file $HTML_FILE_COUNTDOWN" >> $LOGFILE
            cat <<EOF > "$HTML_FILE_COUNTDOWN"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Custom Page</title>
<style>
    .button {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .cancelButton {
        background-color: red;
        color: white;
    }

    .continueButton {
        background-color: green;
        color: white;
    }
</style>
<script>
var countdown;

function startCountdown() {
    document.getElementById('countdownSection').style.display = 'block';
    var timeLeft = 5;
    countdown = setInterval(function() {
        document.getElementById('countdownTimer').innerText = timeLeft + ' seconds remaining';
        timeLeft--;
        if (timeLeft < 0) {
            clearInterval(countdown);
            runScriptAndRedirect();
        }
    }, 1000);
}

function cancelRedirect() {
    clearInterval(countdown);
    document.getElementById('countdownSection').style.display = 'none';
}

function continueRedirect() {
    clearInterval(countdown);
    runScriptAndRedirect();
}

function runScriptAndRedirect() {
    var xhr = new XMLHttpRequest();
    xhr.open("GET", "/mycustompages/runscript${i}.php", true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            window.location.href = "$redirect_url";
        }
    };
    xhr.send();
}
</script>
</head>
<body onload="startCountdown()">
<div id="countdownSection" style="display:none;">
    <p id="countdownTimer">5 seconds remaining</p>
    <button class="button cancelButton" onclick="cancelRedirect()">Cancel</button>
    <button class="button continueButton" onclick="continueRedirect()">Continue</button>
</div>
<p>${message}</p>
</body>
</html>
EOF
        fi
    done
}

# make the php files for the html
create_php_files() {
    for i in {1..9}
    do
        PHP_FILE="$DIR/runscript${i}.php"

        # check and make file
        if [ ! -f "$PHP_FILE" ]; then
            [ "$DEBUG" == "yes" ] && echo "$(date): Creating PHP file $PHP_FILE" >> $LOGFILE
            cat <<EOF > "$PHP_FILE"
<?php
// Path to the script
\$scriptPath = "/mnt/user/system/custom_pages/scripts/custom tabs super/script";
// Script identifier
\$scriptId = "$i";
// Run the script and capture the output
\$scriptOutput = shell_exec("bash " . escapeshellarg(\$scriptPath) . " " . escapeshellarg(\$scriptId));
// Optionally log the script output, for debugging or audit
file_put_contents('/mnt/user/system/custom_pages/script.log', \$scriptOutput, FILE_APPEND);
// Respond to the client
echo "Script executed: " . htmlspecialchars(\$scriptOutput);
?>
EOF
        fi
    done
}

# initial setup
initial_setup() {
    create_directory_and_symlinks
    create_html_files
    create_countdown_html
    create_php_files
    create_readme
}

##############################################################################################################
##############################################################################################################

# check whether to run setup or just run the custom super tab
if [[ -z "$SCRIPT_ID" ]]; then
    initial_setup
else
    # run according to script id passed
    case $SCRIPT_ID in
        1)
            [ "$DEBUG" == "yes" ] && echo "$(date): Run by PHP Script 1" >> $LOGFILE
            log_execution "execute_case_1_commands"
            ;;
        2)
            [ "$DEBUG" == "yes" ] && echo "$(date): Run by PHP Script 2" >> $LOGFILE
            log_execution "execute_case_2_commands"
            ;;
        3)
            [ "$DEBUG" == "yes" ] && echo "$(date): Run by PHP Script 3" >> $LOGFILE
            log_execution "execute_case_3_commands"
            ;;
        4)
            [ "$DEBUG" == "yes" ] && echo "$(date): Run by PHP Script 4" >> $LOGFILE
            log_execution "execute_case_4_commands"
            ;;
        5)
            [ "$DEBUG" == "yes" ] && echo "$(date): Run by PHP Script 5" >> $LOGFILE
            log_execution "execute_case_5_commands"
            ;;
        6)
            [ "$DEBUG" == "yes" ] && echo "$(date): Run by PHP Script 6" >> $LOGFILE
            log_execution "execute_case_6_commands"
            ;;
        7)
            [ "$DEBUG" == "yes" ] && echo "$(date): Run by PHP Script 7" >> $LOGFILE
            log_execution "execute_case_7_commands"
            ;;
        8)
            [ "$DEBUG" == "yes" ] && echo "$(date): Run by PHP Script 8" >> $LOGFILE
            log_execution "execute_case_8_commands"
            ;;
        9)
            [ "$DEBUG" == "yes" ] && echo "$(date): Run by PHP Script 9" >> $LOGFILE
            log_execution "execute_case_9_commands"
            ;;
        *)
            [ "$DEBUG" == "yes" ] && echo "$(date): Error: Unknown script ID ($SCRIPT_ID)" >> $LOGFILE
            ;;
    esac
fi
