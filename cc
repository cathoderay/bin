#
# File: cc
# Description: [c]ommand [c]ounter
#

history | 
  awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | 
  sort -rn | 
  head