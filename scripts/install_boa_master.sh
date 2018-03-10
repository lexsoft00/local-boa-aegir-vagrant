#!/usr/bin/env bash
# Install BOA
su root
cd;wget -q -U iCab http://files.aegir.cc/BOA.sh.txt;bash BOA.sh.txt
boa in-stable local hostmaster@aegir.local mini php-7.0