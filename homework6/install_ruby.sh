#!/bin/bash

# Install ruby
sudo -- -sh -c <<EOF
apt-get update
apt-get install -y ruby-full ruby-bundler build-essential
EOF

echo "Installed:"
echo `ruby -v`
echo `bundle -v`
