#!/bin/bash

# Check git and awk
sudo apt-get install git

# Clone and install app
git clone https://github.com/Otus-DevOps-2017-11/reddit.git
cd reddit && bundle install

# Start server
puma -d

# Check server and print PID and port
ps aux | grep [p]uma | awk '{print "Puma server PID",$2,"listens on",$13}'
