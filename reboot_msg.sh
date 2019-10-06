#!/bin/bash
# Just throw a message out to the world if we're expecting to reboot soon.
if [[ -e /var/run/reboot-required ]]; then echo "Waiting on reboot."; fi
