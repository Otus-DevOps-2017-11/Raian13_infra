#!/bin/bash

# Install ruby
sudo -- sh -c '
apt-get update
apt-get install -y ruby-full ruby-bundler build-essential
'

echo "Installed:"
echo `ruby -v`
echo `bundle -v`

#Install MongoDB
sudo -- sh -c '
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list
apt-get update
apt-get install -y mongodb-org
systemctl start mongod
systemctl enable mongod
'

# Check MongoDB
# systemctl status doesn't require sudo privileges in Ubuntu
systemctl status mongod

# Check git and awk
sudo apt-get install git

# Clone and install app
git clone https://github.com/Otus-DevOps-2017-11/reddit.git
cd reddit && bundle install

# Start server
puma -d

# Check server and print PID and port
ps aux | grep [p]uma | awk '{print "Puma server PID",$2,"listens on",$13}'
