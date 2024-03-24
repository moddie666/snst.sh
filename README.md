# Simple Network Speed Test

### Test network connection speeds with simple command line tools
depends on "nc" and "pv"

```
USAGE: snst.sh (-r|-s <host|ip>) [-p <port>]
-r|--recv   ... listener (must be started first)
-s|--send   ... sender mode
-p|--port   ... port to use
-h|--help   ... this text
```
### example usage
```
START THE LISTENER FIRST
user@listener:~$ snst.sh -r -p 8888
 135MiB 0:01:33 [1.44MiB/s] [                        <=>

THEN THE SENDER
user@sender:~$ snst.sh -s listener -p 8888 
 131MiB 0:00:07 [20.0MiB/s] [                     <=>
```
