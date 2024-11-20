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

# Fetch the latest release URL dynamically
echo -e "${BLUE}Fetching the latest release details...${RESET}"
LATEST_RELEASE=$(curl -s https://api.github.com/repos/LuckyCoinProj/luckycoinV3/releases/latest)
if [ -z "$LATEST_RELEASE" ]; then
    echo -e "${RED}Failed to fetch the latest release information. Please check your internet connection or GitHub API limits.${RESET}"
    exit 1
fi

# Extract tag name and assets
TAG_NAME=$(echo "$LATEST_RELEASE" | grep -oP '"tag_name": "\K(.*?)(?=")')
echo -e "${GREEN}Latest release found: ${TAG_NAME}${RESET}"

# Check if Luckycoin Node is already running and prompt user for update
if pgrep -x "luckycoind" > /dev/null; then
    echo -e "${YELLOW}Luckycoin Node is already running.${RESET}"
    CURRENT_VERSION=$(luckycoin-cli --version | grep -oP 'v[0-9]+\.[0-9]+\.[0-9]+')
    if [ "$CURRENT_VERSION" == "$TAG_NAME" ]; then
        echo -e "${GREEN}Your Luckycoin Node is already up-to-date (version ${CURRENT_VERSION}).${RESET}"
        echo -e "Use '${YELLOW}luckycoin-cli help${RESET}' for commands and management."
        echo -e "${YELLOW}Example:${RESET} To check the current block height of your node, run:"
        echo -e "${GREEN}luckycoin-cli getblockcount${RESET}"
        echo -e "This will display the current block height, helping you verify your node's synchronization status."
        exit 0
    else
        echo -e "${YELLOW}A new version (${TAG_NAME}) is available. Current version: ${CURRENT_VERSION}.${RESET}"
        echo -e "Do you want to update your Luckycoin Node? (y/n)"
        read -rp "$(echo -e "${BLUE}Enter your choice: ${RESET}")" update_choice
        if [[ "$update_choice" == "y" || "$update_choice" == "Y" ]]; then
            echo -e "${YELLOW}Stopping Luckycoin Node...${RESET}"
            luckycoin-cli stop
            sleep 5  # Allow time for the node to shut down
        else
            echo -e "${GREEN}No update performed. Node is still running.${RESET}"
            echo -e "Use '${YELLOW}luckycoin-cli help${RESET}' for commands and management."
            echo -e "${YELLOW}Example:${RESET} To check the current block height of your node, run:"
            echo -e "${GREEN}luckycoin-cli getblockcount${RESET}"
            echo -e "This will display the current block height, helping you verify your node's synchronization status."
            exit 0
        fi
    fi
fi

# Disable input on script execution via curl | bash
if [ -t 0 ]; then
    # This means the script is being run interactively, so ask for input
    echo -e "${YELLOW}Please select your Linux version:${RESET}"
    echo -e "1) General Linux (most distros)"
    echo -e "2) Ubuntu 20.04"
    read -rp "$(echo -e "${BLUE}Enter your choice (1 or 2): ${RESET}")" os_choice

    # Validate input
    if [[ "$os_choice" != "1" && "$os_choice" != "2" ]]; then
        echo -e "${RED}Invalid choice. Please run the script again and select 1 or 2.${RESET}"
        exit 1
    fi
else
    # If it's not interactive, set a default choice or skip the input
    os_choice="1"  # Default to "General Linux" if no input
fi

# Define the download URL dynamically based on user selection
if [ "$os_choice" -eq 1 ]; then
    ASSET_NAME="Node-${TAG_NAME}-linux.zip"
elif [ "$os_choice" -eq 2 ]; then
    ASSET_NAME="Node-${TAG_NAME}-ubuntu20.04.zip"
fi

ASSET_URL=$(echo "$LATEST_RELEASE" | grep -oP '"browser_download_url": "\K[^"]+('"$ASSET_NAME"')')
if [ -z "$ASSET_URL" ]; then
    echo -e "${RED}Failed to find the asset for your selection. Please check the release page manually.${RESET}"
    exit 1
fi

echo -e "${GREEN}Selected asset: ${ASSET_NAME}${RESET}"

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
wget $ASSET_URL -O $ASSET_NAME
unzip $ASSET_NAME
rm $ASSET_NAME

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
wget https://github.com/LuckyCoinProj/luckycoinV3/releases/download/${TAG_NAME}/luckycoin.conf -O ~/.luckycoin/luckycoin.conf

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