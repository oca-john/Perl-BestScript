#!/usr/bin/sh
# you can insert perl code blocks into shell script,
# and mix perl & bash to extend their ability.

echo "Welcome to bash with perl!"

perl <<_EOF_PERL_SCRIPT
print "This is print by perl in bash\n"
_EOF_PERL_SCRIPT

echo "Back to bash now!"
