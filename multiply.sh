#!/bin/sh
addendum=$(mktemp)
cat - >$addendum
[ $# -gt "0" ] && { it=$(expr "$1" '-' '2') ;  cat $addendum ; echo '+' ; seq "$it" | { while read r ; do cat $addendum ; echo '+' ; done ; } ; cat $addendum ; }

rm $addendum
