#!/bin/bash
#
# Simple Network Speed Test

ME=$(basename $0)
USAGE="#- Simple Network Speed Test -#
USAGE: $ME (-r|-s <host|ip>) [-p <port>]
-r|--recv   ... listener (must be started first)
-s|--send   ... sender mode
-p|--port   ... port to use
-h|--help   ... this text"

DEPS="nc pv"
for d in $DEPS
do which $d 1>/dev/null || { echo "missing executable: $d" ; exit 1 ; }
done

snst_send(){
   pv /dev/zero | nc $TARGET $PORT
}
snst_recv(){
   nc -l -p $PORT | pv > /dev/null
}

while [ $# -ne 0 ]
do case $1 in
     -s|--send) SEND=1
                shift
                TARGET=$1
                shift;;
     -r|--recv) RECV=1
                shift;;
     -h|--help) echo "$USAGE";;
     -p|--port) shift
                PORT=$1
                shift;;
             *) echo -e "Unrecognized Argument: '$1'\n$USAGE"
                exit 1;;
   esac
done
if [ "x$PORT" = "x" ]
then PORT=12345
fi
if [ "$SEND" = "1" ] && [ "$RECV" = "1" ]
then echo -e "Send and Recv cannot be combined!\n$USAGE"
     exit 1
elif [ "$SEND" = "1" ]
then snst_send
elif [ "$RECV" = "1" ]
then snst_recv
else echo -e "Incomplete Command!\n$USAGE"
     exit 1
fi
