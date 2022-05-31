#!/bin/bash

name=$1

cat << EOF > $1.py
#!/usr/bin/env python

def main():
      pass

if __name__ == '__main__':  
      main()
EOF

chmod u+x $1.py #
echo "$1.py has been created"
cat $1.py



#
#name=$1
#
#echo :wq | vim $1.py
#
#echo "#!/usr/bin/env python" > $1.py
#
#chmod u+x $1.py #
#echo "$1.py has been created"
#cat $1.py
#
##to make this file work from anywhere I did the following the shell
##export PATH="<path_to_script>:$PATH"
