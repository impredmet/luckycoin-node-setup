# Luckycoin Node Setup

This guide explains how to install and update the **Luckycoin** node on Linux and Windows.

## Prerequisites

- **Linux**: Ensure that `curl` is installed on your machine.
- **Windows**: Simply download the `.exe` file from the releases page.

---

## Installation and Update on Linux

1. **Download and execute the installation or update script**  
   Open a terminal and execute the following command:

   ```bash
   curl https://raw.githubusercontent.com/impredmet/luckycoin-node-setup/refs/heads/main/install.sh > install.sh && chmod +x install.sh && ./install.sh && rm install.sh
   ```

2. **The script will handle everything**:

   - It will download the necessary files for the installation or update.
   - Install required dependencies (if needed).
   - Configure your node and start it in the background.

3. **Verify the installation or update**:  
   Once the installation or update is complete, you can check if the node is running by using the following command:

   ```bash
   luckycoin-cli getblockcount
   ```

---

## Installation and Update on Windows

1. **Download the executable**  
   Simply go to the [Luckycoin V3 releases page](https://github.com/LuckyCoinProj/luckycoinV3/releases) and download the latest `.exe` file for Windows.

2. **Run the `.exe` file**  
   After downloading, run the `.exe` file to start the Luckycoin Node on your Windows machine.

3. **Verify the installation or update**:  
   Once the node is running, you can check its status by running the following command in the `cmd` or PowerShell:

   ```cmd
   luckycoin-cli getblockcount
   ```

---

This script also works for updating an already installed Luckycoin node, ensuring that you’re always running the latest version.

## Video Example

Here is a video example showing how to install and update the **Luckycoin** node on Ubuntu 20.04:

![](example.gif)

---

This video demonstrates the installation process and how to run the `luckycoin-cli getblockcount` command to verify the node's status on Ubuntu 20.04.
