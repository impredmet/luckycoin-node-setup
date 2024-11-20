#!/bin/bash

# Enable error handling
set -e

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
RESET='\033[0m'

# Clear screen and display welcome message
clear
echo -e "${CYAN}========================================================${RESET}"
echo -e "${GREEN}      Welcome to the Luckycoin Node Installation        ${RESET}"
echo -e "${CYAN}========================================================${RESET}"

# Prompt user for OS type
echo -e "${YELLOW}Please select your Linux version:${RESET}"
echo -e "1) General Linux (most distros)"
echo -e "2) Ubuntu 20.04"
read -rp "$(echo -e "${BLUE}Enter your choice (1 or 2): ${RESET}")" os_choice

# Validate input
if [[ "$os_choice" != "1" && "$os_choice" != "2" ]]; then
    echo -e "${RED}Invalid choice. Please run the script again and select 1 or 2.${RESET}"
    exit 1
fi

# Define the download URL based on user selection
if [ "$os_choice" -eq 1 ]; then
    NODE_URL="https://github.com/LuckyCoinProj/luckycoinV3/releases/download/v3.0.2/Node-v3.0.2-linux.zip"
    NODE_NAME="Node-v3.0.2-linux.zip"
    echo -e "${GREEN}You selected General Linux.${RESET}"
elif [ "$os_choice" -eq 2 ]; then
    NODE_URL="https://github.com/LuckyCoinProj/luckycoinV3/releases/download/v3.0.2/Node-v3.0.2-ubuntu20.04.zip"
    NODE_NAME="Node-v3.0.2-ubuntu20.04.zip"
    echo -e "${GREEN}You selected Ubuntu 20.04.${RESET}"
fi

# Check if Luckycoin Node is already running
if pgrep -x "luckycoind" > /dev/null; then
    echo -e "${YELLOW}Luckycoin Node is already running.${RESET}"
    echo -e "Use '${YELLOW}luckycoin-cli help${RESET}' for commands and management."
    echo -e "${YELLOW}Example:${RESET} To check the current block height of your node, run:"
    echo -e "${GREEN}luckycoin-cli getblockcount${RESET}"
    echo -e "This will display the current block height, helping you verify your node's synchronization status."
    exit 0
fi

# Update and install dependencies
echo -e "${CYAN}========================================================${RESET}"
echo -e "${BLUE}Step 1: Installing dependencies...${RESET}"
echo -e "${CYAN}========================================================${RESET}"
sudo apt-get update
sudo apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev libjpeg-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev libdb5.3++-dev libdb5.3++ libdb5.3-dev libzmq3-dev libminiupnpc-dev git curl zip unzip libzmq5

# Download and install the Luckycoin Node
echo -e "${CYAN}========================================================${RESET}"
echo -e "${BLUE}Step 2: Downloading Luckycoin Node...${RESET}"
echo -e "${CYAN}========================================================${RESET}"
wget $NODE_URL -O $NODE_NAME
unzip $NODE_NAME
rm $NODE_NAME

# Set execute permissions
chmod +x luckycoind luckycoin-cli luckycoin-tx

# Check for existing installation
if [ -f /usr/local/bin/luckycoind ]; then
    echo -e "${YELLOW}Luckycoin binaries already exist. Overwriting...${RESET}"
fi

# Move binaries to the system path
sudo mv luckycoind luckycoin-cli luckycoin-tx /usr/local/bin/

# Create the Luckycoin Node's data directory
echo -e "${CYAN}========================================================${RESET}"
echo -e "${BLUE}Step 3: Setting up data directory...${RESET}"
echo -e "${CYAN}========================================================${RESET}"
mkdir -p ~/.luckycoin
chmod 700 ~/.luckycoin

# Download the Luckycoin Node's configuration file
echo -e "${CYAN}========================================================${RESET}"
echo -e "${BLUE}Step 4: Downloading configuration file...${RESET}"
echo -e "${CYAN}========================================================${RESET}"
wget https://github.com/LuckyCoinProj/luckycoinV3/releases/download/v3.0.2/luckycoin.conf -O ~/.luckycoin/luckycoin.conf

# Run the Luckycoin Node
echo -e "${CYAN}========================================================${RESET}"
echo -e "${BLUE}Step 5: Starting Luckycoin Node...${RESET}"
echo -e "${CYAN}========================================================${RESET}"
luckycoind -daemon

# Completion message
echo -e "${CYAN}========================================================${RESET}"
echo -e "${GREEN}Luckycoin Node setup complete!${RESET}"
echo -e "${CYAN}========================================================${RESET}"
echo -e "Use '${YELLOW}luckycoin-cli help${RESET}' for commands and management."
echo -e "${YELLOW}Example:${RESET} To check the current block height of your node, run:"
echo -e "${GREEN}luckycoin-cli getblockcount${RESET}"
echo -e "This will display the current block height, helping you verify your node's synchronization status."