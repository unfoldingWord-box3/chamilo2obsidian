#!/bin/bash
########################################################################
#
# NAME  inc - expand included files inline
#
# DESCRIPTION expands include files as it processes standard in
#      It is recursive so that includes can include includes.
#
  USAGE="... | $0 | ..."
#
########################################################################

while [ $# -gt 0 ] ; do
  case $1 in
    -h) 
      cat $0 | helper 
      exit
      ;;

    *)
      echo "Unexpected argument."
      echo "$USAGE" 
      exit
      ;;
  esac

  shift
done

while read -r line ; do
  case "$line" in
    *'include('*) 
      file=`echo -n "$line" | sed -e 's/.*include(\(.*\)).*/\1/'`
      virt=${file:6}
      niced=${virt// /_}
      echo "<!-- transclude: $niced -->"
      cat "$file" | $0
      echo "<!-- end transclude: $niced -->"
      ;; 

    *)
      echo "$line"
      ;;
  esac
done

