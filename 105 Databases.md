# Databases
## Why do they exist?
Databases are very important in applications to store and retrieve data in efficient way. 

## Types
### 1. Relational databses:
##### Why do they exist
- used to store data which is related together.
- we split and organize this data into tables, and there are relations between these tables as the data is related together.
- Abides by the ACID rules (Atomicity, Consistency, Isolation, Durability)

##### more info
- Widely used
- They have a structure(schema)
- schema defines structure, datatypes and limits
- SQL (Structured Query Language) to query the database

##### examples
- postgresql, mysql, oracle
- coucheDB, when you want to horizontally scale your database

### 2. Key Value databases
##### Why do they exist
- simple, they just store key and value pair efficiently.
- GET, PUT, DELETE

##### more info
- very fast!!!
- limited by memory, as data increases they suffer
- often used in caching
- sometimes used as message queue

##### examples
- redis, memcached, etcd

### 3. Wide column databases
##### why do they exist
- if we want a key value store but the value needs to have multiple columns 
- schema less

##### more info
- scalable
- no joins
- can handle unstructured data. for example, can be used in time series analysis

##### examples
- cassandra, hbase

### 4. Document databases
##### why do they exist
- unstructured databses, can be almost used for anything.
- so if you are starting out without any schema and have no idea what schema might become in future, use this. i.e if data is related together, move away from this

##### more info
- documents -> containers for key value pairs
- collection -> set of documents together
- unstructured/schemaless, so no schema
- no joins
- nested data
- updates and writes are slow but reads are fast

##### Examples:
- mongoDB, dynamoDB, couchDB

### Graph databases
##### why do they exist
- correletd data
- relationship between data, ex: users, comments, friends etc.
- use this if you can visualize the application database structure as graph

##### examples:
- Neo4g

### Search databases
##### why do they exist
- given some data and query, you should be able to search in it(asap)
- they create a posting list internally to return answers to the queries.
##### examples:
- elasticsearch

- You can always have a combination of different databases😊.