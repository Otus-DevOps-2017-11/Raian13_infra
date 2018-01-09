#!/bin/bash

# Install ruby
apt-get update
apt-get install -y ruby-full ruby-bundler build-essential

echo "Installed:"
echo `ruby -v`
echo `bundle -v`
