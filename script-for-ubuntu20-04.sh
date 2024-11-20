#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Install dependencies
echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libjpeg-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev libdb5.3++-dev libdb5.3++ libdb5.3-dev libzmq3-dev libminiupnpc-dev git curl zip unzip

# Download and install the Luckycoin Node
echo "Downloading Luckycoin Node..."
wget https://github.com/LuckyCoinProj/luckycoinV3/releases/download/v3.0.2/Node-v3.0.2-ubuntu20.04.zip -O Node-v3.0.2-ubuntu20.04.zip
unzip Node-v3.0.2-ubuntu20.04.zip
rm Node-v3.0.2-ubuntu20.04.zip

# Set execute permissions
chmod +x luckycoind luckycoin-cli luckycoin-tx

# Check for existing installation
if [ -f /usr/local/bin/luckycoind ]; then
    echo "Luckycoin binaries already exist. Overwriting..."
fi

# Move binaries to the system path
sudo mv luckycoind luckycoin-cli luckycoin-tx /usr/local/bin/

# Create the Luckycoin Node's data directory
echo "Creating data directory..."
mkdir -p ~/.luckycoin
chmod 700 ~/.luckycoin

# Download the Luckycoin Node's configuration file
echo "Downloading configuration file..."
wget https://github.com/LuckyCoinProj/luckycoinV3/releases/download/v3.0.2/luckycoin.conf -O ~/.luckycoin/luckycoin.conf

# Run the Luckycoin Node
echo "Starting Luckycoin Node..."
luckycoind

echo "Luckycoin Node setup complete. Run 'luckycoin-cli help' for commands."