#!/bin/bash

name=$1

cat << EOF > $1.py
#!/usr/bin/env python

def main():
      pass




if name_ == '__main__':  
      main()
EOF

chmod u+x $1.py
echo "$1.py has been created"
