#!/bin/sh
#deps: sed, printf, tac

norm() {
# this function indents the tags
# configure it as for your likings
	depth=0
	read x
	echo $x
	depth=1
	x=''
	while read x ; do
		echo $x | grep -q '^<[^/]' && {
			depth=$(expr "$depth" "+" "1")		
		}

		
		
		seq $depth | while read m ; do
			printf '  '
		done
		echo $x

		echo $x | grep -q '^<[/]' && {
			depth=$(expr "$depth" "-" "1")		
		}
	done | sed '$s/^[ ]*//'
}

buffer=$(mktemp)
tbuffer=$(mktemp)
tagstart=$(mktemp)
tagend=$(mktemp)
itr=0

cat - >$tbuffer & cod=$?
sleep 0.5s

# loading of the sed scripts
# either this or putting a goddamn big string...
cat >$tagstart <<EOF
s/\[\(.*\)=\(.*\)\]/ \1="\2" /g
s/\#\([[:alnum:]]*\)/ id="\1" /
s/\.\([[:alnum:]]*\)/ class="\1" /
s/^/</
s/$/>/
s/ >/>/
EOF
# I use one weird trick to create the end tag: examining the start tag
#cat >$tagend <<EOF
#s/<\([[:alnum:]]*\) .*>/<\/\1>/
#EOF

cat >$tagend <<EOF
s/^\([[:alnum:]]*\)\([\#.\[].*\)/\1/
s/^/<\//
s/$/>/
EOF
hierarchy=''
# break the symbols in extra lines
target=$(mktemp)
{ while [ $# -gt "0" ] ; do printf "%s" $1
  shift
  done
  echo '' ; } | sed 's/\(>\)/\n\1\n/g
s/[+]/\n+\n/g' | sed '/^$/d' | tac >$target

# the loop
cat $target | { while read a ; do
	{ [ $itr -eq "0" ] && {
			[ $a != '>' -a $a != '+' ] && {
				r=$(echo "$a" | sed -f $tagstart)
				echo $r >$buffer
				cat $tbuffer >>$buffer
				echo $a | sed -f $tagend >>$buffer
				:>$tbuffer
			}
		}
	} || {
			{ [ $a != '>' -a $a != '+' ] && {
						beg=$(echo "$a" | sed -f $tagstart)
						end=$(echo "$a" | sed -f $tagend)
						[ "z$hierarchy" != "z" ] && {
							[ $hierarchy = '+' ] && { echo "$beg$end"  >>$buffer ; }
							[ $hierarchy = '>' ] && { { echo $beg ; cat $buffer ; echo $end ; } >>$tbuffer ; mv $tbuffer $buffer ; }
						}

						hierarchy=''
					}
			} || hierarchy=$a 
		} 

	itr=$(expr "$itr" "+" "1")
	done 
}

cat $buffer | norm

rm $buffer $tbuffer $tagstart $tagend $target
