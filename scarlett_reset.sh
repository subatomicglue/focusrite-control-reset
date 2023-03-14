#!/bin/bash

# Usage:
#
# Start a Terminal in MacOS
# If not running bash, run bash:
#     $ bash
#
# Source this script into your bash shell, like this:
#     $ source scarlett_reset.sh
#
# Run the script:
#     $ scarlett_restart
#

function focusrite {
  echo ""
  echo "Resetting your SCARLETT Driver!   (For MacOS command line)"
  echo " Use any time \"Focusrite Control\" says \"No Hardware Connected\", even though Scarlett USB cables are all correctly connected"
  echo " This typical when you've got multiple Scarlett devices, \"Focusrite Control\" can get confused after some days/weeks/months of MacOS up-time."
  echo " (Also known as a bug, but this is a workaround)"
  echo ""
  echo "===================================="
  echo "Learn some things about your driver, where it is, how it runs:"
  echo "  ls ~/Library/*/*ocus*"
  echo "  ps -ef | grep ocusrite"
  echo "  sudo launchctl list | grep com.focusrite.ControlServer"
  echo "===================================="
  echo ""
  echo ""

  echo "Seeing if the FocusriteControlServer is running, if it is, we'll kill it so it auto-restarts"
  echo "(may need to enter your MacOS account password here)"
  echo ""
  sudo launchctl list | grep com.focusrite.ControlServer
  retval=$?
  if [ "$retval" == "0" ]; then
    local PID=`sudo launchctl list | grep com.focusrite.ControlServer | awk {'print $1'}`
    echo "Killing $PID"
    sudo launchctl kickstart -k -p system/com.focusrite.ControlServer
    #sudo kill -9 "$PID"   # a more abrupt way to do it :)
    echo ""

    echo "Waiting for it to restart..."
    sleep 3
    echo ""
    sudo launchctl list | grep com.focusrite.ControlServer
    retval=$?
    if [ "$retval" == "0" ]; then
      PID=`sudo launchctl list | grep com.focusrite.ControlServer | awk {'print $1'}`
      echo "[SUCCESS] Looks like it's now running on PID=$PID"
    else
      echo "[ERROR] It hasnt (yet) restarted...  hmm, you can wait and then look with:"
      echo "   sudo launchctl list | grep com.focusrite.ControlServer"
      echo ""
    fi
  else
    echo "Looks like the FocusriteControlServer isn't running, you may need to install the driver!"
  fi
}
alias scarlett=focusrite
alias restart_scarlett=scarlett
alias restart_focusrite=scarlett
alias reset_scarlett=scarlett
alias reset_focusrite=scarlett
alias scarlett_restart=scarlett
alias focusrite_restart=scarlett
alias scarlett_restart=scarlett
alias focusrite_restart=scarlett

# Run:
# scarlett_restart

