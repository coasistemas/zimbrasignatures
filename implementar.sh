#!/bin/bash

path="/opt/zimbra/bin"

for i in `/opt/zimbra/bin/zmprov -l gaa`
do
	echo "======Empezando $i============"
	f=$(mktemp /tmp/ldata.XXXXXX)
	cp -f template.html $f
	zmprov ga $i | egrep "(^uid)"| cut -d : -f 2 | sed 's/^\ //g'|xargs -I@ sed -i 's/-UID-/@/g' $f
	zmprov ga $i | egrep "(^givenName)"| cut -d : -f 2 | sed 's/^\ //g'|xargs -I@ sed -i 's/-GIVENNAME-/@/g' $f
	zmprov ga $i | egrep "(^sn)"| cut -d : -f 2 | sed 's/^\ //g'|xargs -I@ sed -i 's/-SN-/@/g' $f
	zmprov ga $i | egrep "(^title)"| cut -d : -f 2 | sed 's/^\ //g'|xargs -I@ sed -i 's/-TITLE-/@/g' $f
	zmprov ga $i | egrep "(^telephoneNumber)"| cut -d : -f 2 | sed 's/^\ //g'|xargs -I@ sed -i 's/-TELEPHONENUMBER-/604 @/g' $f
	zmprov ga $i | egrep "(^mobile)"| cut -d : -f 2 | sed 's/^\ //g'|xargs -I@ sed -i 's/-MOBILE-/@/g' $f
	#zmprov ma $i zimbraPrefMailSignatureHTML "`cat $f`"
	zmprov csig $i firma-coassist1 zimbraPrefMailSignatureHTML "`cat $f`"
	echo "============Se modifico $i=============="
done


