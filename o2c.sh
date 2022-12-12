#!/bin/bash
#######################################################################
#
# NAME  o2c.sh - exercise Chamilo API 
#
# DESCRIPTION Call each endpoint with test data
#
  USAGE="o2c.sh [-d] [-r|-s|-t] [-u] all|op
  Where 
    -d means debug mode
    -r raw mode (default)
    -s sample mode (save output for test)
    -t test mode
    -u means perform updates as well as GETs
    op is substring of operation to execute"
#
#######################################################################

function ex { # execute a command from o2c
  isEx=yes
  op=$1
  dir="/tmp/test"
  mkdir -p "$dir"
  tmp="$dir/tmpFile"
  
  case $* in
    *TBD*) return ;;
  esac
  
  if [ ${1:0:3} = add -o ${1:0:3} = del ] ; then
    if [ "x$ad" != "x-u" ] ; then
      isEx=no
    fi
  fi
  
  if [ "$isEx" = "yes" ] ; then
    case $num in
      all) ;;
      $op*) ;;
      *) return ;;
    esac
    
    #echo "--- $1 '$2' '$3' '$4' ---"
    echo -n "--- $1"
    case $# in
      0) sh $bug 02c                   > "$tmp" ;;
      1) sh $bug o2c $1                > "$tmp" ;;
      2) sh $bug o2c $1 "$2"           > "$tmp" ; echo -n " '$2'" ;;
      3) sh $bug o2c $1 "$2" "$3"      > "$tmp" ; echo -n " '$2' '$3'" ;;
      4) sh $bug o2c $1 "$2" "$3" "$4" > "$tmp" ; echo -n " '$2' '$3' '$4'" ;;
    esac
    
    echo " ---"
  fi
  
  case $test in
    sample) mv $tmp $tmp-$1-$# ;;
    test) diff -s $tmp $tmp-$1-$# ;;
    *) cat $tmp
  esac
}

# Default Test Data
  major="GL Translator" 
  course="Alignment Training" 
  lp="Introduction to Aligning" 
  category="GL Translator" 
  lpCat="Alignment Training"
  doc="What is an Open Bible Story?"
  cc="GLT"
  code="BMSALN" 
  user=testuser1
  res=JOELREALIGNMENT
  res=ALN
  cid=16
  
# current Test Data
  course="Practice Course"
  code="PRACTICECOURSE"
  title=""
  cId=46
  tId=80
  qId=297
  
# state
  ad="x" 
  num=all
  bug=
  test=raw

while [ $# -gt 0 ] ; do # decode o2c cli options
  case $1 in
    -d)   bug="-x"   ;;
    -u)    ad="-u"   ;;
    -s)  test=sample ;;
    -t)  test=test   ;;
    -r)              ;;
    all)  num=all    ;;
    *)    num=$1  
           ad="-u"   ;;
  esac
  
  shift
done

# exercize the Chamilo API using test data above
#ex edit-con 
#ex edit-course-config "$major" "$course"

# any api endpoint
ex gettr courses
ex gettr courses/categories
ex gettr course/$cc/documents
ex gettr course/$cc/learningpaths
ex gettr course/$cc/learningpath/$lpId/documents
ex gettr course/$cc/learningpaths/categories
ex gettr course/$cc/resources
ex gettr course/$cc/learningpath/$lpId/sections
ex gettr course/$cc/tests
ex gettr course/$cc/test/$tId/questions
ex gettr course/$cc/test/$tId/question/$qId/answers
ex gettr users

ex get-sco "$course"
ex add-sco

ex get-course-doc
ex get-course-doc "$course"
ex get-course-doc "$cc" "$doc"

ex get-co
ex get-co "$course"
ex get-co "$major" "$course"
ex add-co "$major" "$course"
ex del-co "$major" "$course" TBD

ex get-cat
ex add-cat "$cc" "$category"
ex del-cat "$cc" "$category" TBD

ex get-reso
ex get-res "$course"
ex add-res "$res" TBD
ex del-res "$res" TBD

ex get-docu
ex get-doc "$major" "$course"
ex get-doc "$major" "$course" "$lp"
ex add-doc "$course" "$lp" "title" pid prevId createId prereq "content"
ex del-doc "$course" "doc"   TBD

ex get-lp
ex get-lp "$major" "$course" "$lp"
ex add-lp "$major" "$course" "$lp" TBD
ex del-lp "$major" "$course" "$lp" TBD

ex get-lp-cate
ex get-lp-cat "$lpCat"
ex add-lp-cat "$lpCat" TBD
ex del-lp-cat "$lpCat" TBD

ex get-lp-sect
ex get-lp-sec "$course"
ex get-lp-sec "$course" "$lp"
ex add-lp-sec "$course" "$lp" TBD
ex del-lp-sec TBD

ex get-tests
ex get-tests all
ex get-tests "$course"
ex get-tests "$major" "$course"
ex get-tests "$major" "$course" all
ex add-tests "$major" "$course" TBD
ex del-tests TBD

ex get-q "$course" "$test"
ex add-q "$course" "$test" TBD

ex get-a "$course" "$test" "$qId"
ex add-a "$course" "$test" "$question" "$answer"

ex get-users
ex get-users "$user"
