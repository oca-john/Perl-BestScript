#!/usr/bin/sh
echo "Welcome to bash with perl!"

perl <<_EOF_PERL_SCRIPT
print "This is print by perl in bash\n"
_EOF_PERL_SCRIPT

echo "Back to bash now!"
