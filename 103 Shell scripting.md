## Shell programming language
- writing CLI commands, but on steroids
- reduces repetitive work
- Bourne shell (/bin/sh) - All old Unix systems used them
- Bourne again shell (/bin/bash) - improved sh
- file extension is .sh
- to specify a specific shell, use shebang line as your first line
- shebang line → #!/bin/bash
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
- similarly, use -f to check if file exists not, -z for env variables, learn more of the flags as required

- number comparisons
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
- booleans in sh are true and false literals, case-sensitive

### environment variables
- key value pairs
- available for a session can be CLI instance, login instance, boot instance etc.
- `printenv` to echo out all current env variables
- used for API keys, passwords and anything which you don't want to put in code
- `NEW_ENV=value`
- `uset NEW_ENV` to delete env variable
- setting up permanent env variables
	- put the env variable in rc file, ex: .zshrc or .bashrc
	- don't forget to source it
	- /etc/environment is file where system wide env variables are set
	- use launctl for mac

