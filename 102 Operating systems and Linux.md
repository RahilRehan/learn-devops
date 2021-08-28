### Operating System
- Operating system is a translator between the software layer(applications) and hardware components
- Manage and allocate resources
- Memory management(RAM)
- Store Management(ROM)
- Manage file system
	- ntfs, fat, exfat ..etc
- Manage I/O devices
- Security and permissions : manage users and permissions
- Networking
- Operating system components (top to bottom)
	- user applications
	- underlying operating system (android, linux, windows, macos)
	- kernel: is the component which actually interacts with applications and hardware
	- hardware components

### History
- unix was developed by bell labs
- many kernels branched out of unix
- one of them is BSD
- macOS(kernel) is based on BSD(NextStep to be exact), based on means literally the same code
- linux was built with same design philosophy as unix, but was written from sratch(plan was to make it work on low cost hardware)
- to keep them compatible, standards were introduced => (POSIX)
- both linux and macOS are POSIX compliant

### virtualization
- running another operating system on top the other
- can be done using hypervisor(vbox, vmware, vagrant)
- hypervisor creates virtual resources on top of existing hardware
- hypervisors type1 - do not need os, they directly run on hardware(used on servers)
- hypervisors type2 - runs on os as an application
- snapshots/images are copy of os at a particular time, including all files and configs.
- these snapshots/images are very useful when the real running instance face issues. 
- you can just run this image which was an exact copy of the running instance
- similar to images in docker
- virtual machines have their own network, virtual network

### Linux file system
- has hierarchical tree structure
- "/" root directory, everything is placed here
- "/home" contains home directories of all non root users
- "/root" root users home directory
- "/bin" binaries, basic commands, can be used by normal users directly
- "sbin" system binaries, advanced commands, needs superuser permissions to run
- "/lib" essential shared libraries that /bin and /sbin executables use
- "/lib" is simlar to "/Library" in macOs
- "/usr" user location before "/home" folder was added to linux
- "/usr/bin" and "/usr/sbin" ..etc have more commands than "/bin" "/sbin". This split was made due to storage limitations and to split root binary folders and user binary folders
- usually commands we run are run from "/usr/bin" and "/usr/sbin"
- "/usr/local" is place where programs you install on computer reside, third party applications.
- if you install anything on "/usr/local", they will be available for all users!
- "/opt", third party application installations stay here. Will be available systemwide
- if the application that you install is split into multiple components like libs, configs etc then use "*/bin". If the application is just packaged into one then use "/opt"(ex: IDEs, browsers)
- "/boot", files for booting the OS
- "/etc", main configuration location of all the application and utilities, linux user data and password ..etc
- "/dev" location of device files. All files that the system need to interact with any device are stored here.
- "/var" store logs of your operating system or any application, 
- "/var/cache" contains cache data from application programs
- "/tmp" temporary resources required for some process are kept here temporarily
- "/media" contains subdirectories, where removable media devices inserted into computer are mounted, happend automatically
- "/mnt" if you want to mount temporary file systems, you should mount manually, sys admins historically use this location to mount
- hidden files in linux start with .
- all the dotfiles can be configurations files, temp files created by operating systems

### package managers linux
- every software package has dependecies(depends on other software)
- and software package is split across multiple files(libs, config ..etc)
- package manager helps in resolving deps and split files accordingly to folders
- it also cleans the leftover deps and files when you purge a package.

### apt
- `sudo apt install package-name`
- `sudo apt remove package-name`
- apt vs apt-get
	- apt is more user friendly, has less commands compared to apt-get
	- apt-get has been there since beginning
- where are packages stored? repositories
- always index and update repos on latest os installation
	- `sudo apt update`
	- list all repositories: `cat /etc/apy/sources.list`
- snap package manager
	- package manager that has packages(snaps) which work accross multiple distros
	- larger in size because app is bundled with its deps
	- snap store: acts as a repository for snap
	- snapcraft: command and framework used to build and publish snaps
- `sudo add-apt-repository "link"`
- ppa: personal package archive, private repositories to distribute software
	- usually used by devs, but be careful as they are not verified by any distribution

### vi / vim
- esc to switch between insert and command mode
- :wq to save and exit in command mode
- :q! to quit without saving the changes

### user accounts and groups
- root user: unrestricted permissions (only 1 per computer)
- user accounts: regular user we create to login
- service user: relavant for linux server distros (best practice)
	- ex: mysql user will start mysql application
	- ex: run docker app with specific user
- `sudo adduser tom` -> adds tom as a new user
- `sudo passwd tom` -> to set password of new user
- `cat /etc/passwd` -> file which has list of users
- `su - tom` -> to switch to tom user
- `su -` -> will log you in as root user
- `sudo addgroup devops` -> add a new group devops
- by default when a new user is added a group with same username is created.
- `sudo /etc/group` -> list all groups
- `deluser` and `delgroup`
- above commands are interactive
- there are alo `useradd` and `groupadd` `userdel` `groupdel` commands which are very similar but are low level and you need to provide information yourself. Use them when writing shell scripts else use the above commands.
- `sudo usermod -g devops tom` makes devops the primary group of user tom
- user has one primary group and multiple secondary groups
- `sudo usermod -aG group1 group2 .. tom` -> appends new groups to user toms previos groups list. use `-G` to override the group list.
- `groups` to list groups of current user or `groups user` to list groups of specified user.
- `sudo gpasswd -d nicole devops` -> removes nicole from devops groups

### file ownership and permissions
- `ls -lsah`
- `sudo chown username:groupname filename` -> to change permissions of file
- `drwxrwxr-x` user:group:others(everyone-else)
- d - directoru
- - regular file
- l symbolic link
- rwx, read write execute and `-` for no permission
- `chmod -x file` to remove execute permissions
- `chmod g-w file ` to remove write permission from group
- `chmod o+x file ` to make executable for others
- `chmod +x file ` to make executable for all users
- `chmod u+x file ` to make executable for current user
- `chmod g=r-x file ` to give specific access
- you can also use binary numbers for permissions
- 4: read, 2: write, 1: execute, 0: no permission
- example: 777 to give rwx to everyone (similar to rwxrwxrwx)

### piping and redirects in linux cli
- pass output of one command to another
- `cat /var/log/syslog | less`
- less, show things one page at a time and allows to move backward and forward
- `history | grep sudo | less`
- grep is a search tool
- `history | grep "sudo chmod" > temp.txt` redirects outputs to file
- `history | grep "sudo rm" > temp.txt` redirects outputs and appends to file