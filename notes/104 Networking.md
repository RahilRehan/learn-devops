### Basics
- LAN - connection of devices connected together
- Each device in LAN has an IP address
- IPv4 address is 32 bits: has group of 4 octets
- Switches enables connection within the LAN
- Router enables connection outside LAN
- Subnets are used to group devices on internet
- CIDR, used to denote fixed and variable part in IP addresses
- devices have increased, and we need more than 32 bits to represent all devices on internet
- we now propose to use IPV6 which is 128 bit
- NAT: Network address translation: Router acts as a NAT and has an IP(public IP). 
	- And all the devices requests route through this IP. 
	- Hence, we decrease usage of some addresses.
	- This is useful, so that we use up less IP addresses, security and protection, there are not many conflicts globally
- Firewall: set of rules that prevents unauthorized access and protects our network
	- you can define, inbound and outbound rules
	- allow port access
- DNS: Domain Name Service
	- Maps IP addresses to name
	- DNS follow hierarchical structure
	- top level domains (.com, .edu, .org …etc)
	- names are often cached
	- subdomains to split you domain across multiple names
	- `ifconfig` about our network
	- `netstat` active connections and port info
	- `ps aux` find port
	- `nslookup` to find IP of domains
	- `ping` checks if service is accessible
	- `netstat -lpnt` to list running applications and their ports

### SSH
- secure shell, access machines over internet
- ways to authenticate:	
	- username and password
		- `ssh username@ip-address`
	- ssh key pair(secure)
		- `ls ~/.ssh`
		- `ls ~/.ssh/known_hosts` → contains all knows hosts(servers)
		- `ssh-keygen -t rsa` → creates a public private key pair
		- copy `id_rsa.pub` into any remote server you want
			- paste public key into `~/ssh/authorized_keys` → you can add multiple public keys
		- run this after setup `ssh -i ~/.ssh/id_rsa username@ip-address`, `-i` flag to specify private key 
	- `scp` to copy from remote to host
- ssh key gen
	- client creates an ssh key pair(public + private)
	- public keys is used which we try to access
	- private key is for local box
- firewall and ports
	- ssh run on port 22
	- we also need to configure firewall