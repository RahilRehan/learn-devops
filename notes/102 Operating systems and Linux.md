### Operating System
- Operating system acts like a translator between the software layer(applications) and hardware components
- It manages and allocates resources
- It does memory management(RAM)
- It does store management(ROM)
- manages file system
	- NTFS, fat, exFAT …etc
- manages I/O devices
- manages security and permissions : manage users and permissions
- manages networking aspects
- Operating system components (4 main components in top to bottom order)
	- user applications (very abstract)
	- underlying operating system (android, Linux, windows, macOS)
	- kernel: is the component which actually interacts with hardware
	- hardware components

### History
- UNIX was developed by bell labs
- many kernels branched out of UNIX
- one of them is BSD
- macOS(kernel) is based on BSD(NextStep to be exact), based on means literally the same code
- Linux was built with same design philosophy as UNIX, but was written from scratch(plan was to make it work on low-cost hardware)
- to keep them compatible, standards were introduced → (POSIX)
- both Linux and macOS are POSIX compliant

### virtualization
- running another operating system on top the other
- can be done using hypervisor(virtual box, VMware, vagrant)
- hypervisor creates virtual resources on top of existing hardware
- hypervisors type1 - do not need OS, they directly run on hardware(used on servers)
- hypervisors type2 - runs on OS as an application
- snapshots/images are copy of OS at a particular time, including all files and configs.
- These snapshots/images are very useful when the real running instances face issues. 
- You can just run this image which was an exact copy of the running instance
- these are very similar to images in docker
- virtual machines have their own network → virtual network

### Linux file system
- has hierarchical tree structure
- "/" root directory, everything is placed here
- "/home" contains home directories of all non-root users
- "/root" root user's home directory
- "/bin" binaries, basic commands, can be used by normal users directly
- "sbin" system binaries, advanced commands, needs superuser permissions to run
- "/lib" essential shared libraries that /bin and /sbin executables use
- "/lib" is similar to "/Library" in macOS
- "/usr" user location before "/home" folder was added to Linux
- "/usr/bin" and "/usr/sbin" ..etc have more commands than "/bin" "/sbin". This split was made due to storage limitations and to split root binary folders and user binary folders
- usually commands we run are run from "/usr/bin" and "/usr/sbin"
- "/usr/local" is place where programs you install on computer reside, third party applications.
- if you install anything on "/usr/local", they will be available for all users!
- "/opt", third party application installations, stay here. Will be available system wide
- if the application that you install is split into multiple components like libs, configs etc. then use "*/bin". If the application is just packaged into one then use "/opt"(ex: IDEs, browsers)
- "/boot", files for booting the OS
- "/etc", main configuration location of all the application and utilities, Linux user data and password ..etc
- "/dev" location of device files. All files that the system need to interact with any device are stored here.
- "/var" store logs of your operating system or any application, 
- "/var/cache" contains cache data from application programs
- "/tmp" temporary resources required for some processes are kept here temporarily
- "/media" contains subdirectories, where removable media devices inserted into computer are mounted, happen automatically
- "/mnt" if you want to mount temporary file systems, you should mount manually, sysadmins historically use this location to mount
- hidden files in linux start with.
- all the dot files can be configurations files, temp files created by operating systems

### package managers Linux
- every software package has dependencies(depends on other software)
- and software package is split across multiple files(libs, config …etc)
- package manager helps in resolving deps and split files accordingly to folders
- it also cleans the leftover dependencies and files when you purge a package.

### apt
- `sudo apt install package-name`
- `sudo apt remove package-name`
- Apt vs apt-get
	- apt is more user-friendly, has fewer commands compared to apt-get has been there since beginning
- where are packages stored? Repositories
- always index and update repos on latest OS installation
	- `sudo apt update`
	- list all repositories: `cat /etc/apy/sources.list`
- snap package manager that has packages(snaps) which work across multiple distros
	- larger because app is bundled with its deps
	- snap store: acts as a repository for snap
	- Snapcraft: command and framework used to build and publish snaps
- `sudo add-apt-repository "link"`
- PPA: personal package archive, private repositories to distribute software
	- usually used by devs, but be careful as they are not verified by any distribution

### vi / vim
- ESC to switch between insert and command mode
- :wq to save and exit in command mode
- :q! to quit without saving the changes
- my preference is to use `micro`

### User accounts and groups
- root user: unrestricted permissions (only 1 per computer)
- user accounts: regular user we create to log in
- service user: relevant for Linux server distros (best practice)
	- ex: MySQL user will start MySQL application
	- ex: run docker app with specific user
- `sudo adduser tom` → adds tom as a new user
- `sudo passwd tom` → to set password of new user
- `cat /etc/passwd` → file which has list of users
- `su - tom` → to switch to tom user
- `su -` → will log you in as root user
- `sudo addgroup devops` → add a new group DevOps
- by default when a new user is added a group with same username is created.
- `sudo /etc/group` → list all groups
- `deluser` and `delgroup`
- above commands are interactive
- there are also `useradd` and `groupadd` `userdel` `groupdel` commands which are very similar but are low level, and you need to provide information yourself. Use them when writing shell scripts, else use the above commands.
- `sudo usermod -g devops tom` makes devops the primary group of user tom,
- user has one primary group and multiple secondary groups
- `sudo usermod -aG group1 group2 .. tom` → appends new groups to user toms previous groups list. Use `-G` to override the group list.
- `groups` to list groups of current user or `groups user` to list groups of specified user.
- `sudo gpasswd -d nicole devops` → removes Nicole from devops groups

### file ownership and permissions
- `ls -lsah`
- `sudo chown username:groupname filename` → to change permissions of file
- `drwxrwxr-x` user:group:others(everyone-else)
- d - directory
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

### piping and redirects in Linux CLI
- pass output of one command to another
- `cat /var/log/syslog | less`
- less, show things one page at a time and allows moving backward and forward
- `history | grep sudo | less`
- grep is a search tool
- `history | grep "sudo chmod" > temp.txt` redirects outputs to file
- `history | grep "sudo rm" > temp.txt` redirects outputs and appends to file