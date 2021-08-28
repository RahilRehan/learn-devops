## Shell programming language
- writing cli commands, but on steroids
- reeduces repetitive work
- bourne shell (/bin/sh) - All old unix systems used them
- bourne again shell (/bin/bash) - improved sh
- file extension is .sh
- to specify a specific shell, use shebang line as your first line
- shebang line -> #!/bin/bash
- `chmod u+x file.sh` to make files executable.
- `./file.sh` to run the file
```bash
#!/bin/bash

echo "Demo"

# variables
file_name=temp.txt
file_content=$(cat temp.txt)

echo "selected file is $file_name"
echo "content of file is $file_content"

# conditions
if [ -d "devops" ]
then
	echo "devops folder exists"
else
	echo "devops folder does not exist"
	mkdir devops
	echo "devops folder created"
fi
			
```
- similarly, use -f to check if file exists or if file, -z for env variables, learn more of the flags as required

- number comparisions
	- if [ some_number -lt 10 ]
- other checks like -gt(greater than), -ne(not equal)
- use "=" for checking equality (POSIX aligned)
- parameters:	
	- $1, first parameter
	- exist from 1-9
	- $*  -> all the parameters
	- $#  -> number of parameters 
```bash
param=$1  
for param in $*
	do
		echo $param
	done
```
- read user input
	- `read -p "please enter your username"` username, -p is prompt
	
```bash
#while loop

sum=0
while true
	do
		read -p "enter something" temp
		if [ "$temp" = "q" ]
			then
				break
		fi
		sum=$(($sum+temp))
		echo "total $sum"
	done

```

```bash
# functions
function print_user_with_message() {
	echo "Hi $(whoami), $1"
}

function return_text() {
	return "meow"
}

print_name welcome

#result=$(return_text)
#or
return_text
result=$?
```
- booleans in sh are true and false literals, case sensitive

### environment variables
- key value pairs
- avaiable for a session 
- a session can be cli instance, login instance, boot instance etc
- `printenv` to echo out all current env variables
- used for api keys, passwords and anything which you dont want to put in code
- `NEW_ENV=value`
- `uset NEW_ENV` to delete env variable
- setting up permanent env variables
	- put the env variable in rc file, ex: .zshrc or .bashrc
	- dont forget to source it
	- /etc/environment is file where systemwide env variables are set
	- use launctl for mac

