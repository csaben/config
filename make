#!/bin/bash

name=$1

echo :wq | vim $1.py

echo "#!/usr/bin/env python" > $1.py

chmod u+x $1.py

echo "$1.py has been created"
cat $1.py
