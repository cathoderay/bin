#!/bin/bash
#
# File: cc
# Description: [c]ommand [c]ounter
#

function cc() {
    history | 
      awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | 
      sort -rn | 
      head
}
