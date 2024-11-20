# Luckycoin Node Setup

This guide explains how to install and update the **Luckycoin** node on Linux and Windows.

## Prerequisites

- **Linux**: Ensure that `curl` is installed on your machine.
- **Windows**: Simply download the `.exe` file from the releases page.

---

## Installation and Update on Linux

1. **Download and run the installation or update script**  
   Open a terminal and execute the following command to download and run the installation or update script:

   ```bash
   curl -s https://raw.githubusercontent.com/impredmet/luckycoin-node-setup/refs/heads/main/install.sh | bash
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

# Luckycoin Node Setup

This guide explains how to install and update the **Luckycoin** node on Linux and Windows.

## Prerequisites

- **Linux**: Ensure that `wget` is installed on your machine.
- **Windows**: Simply download the `.exe` file from the releases page.

---

## Installation and Update on Linux

1. **Download the installation or update script**  
   Open a terminal and execute the following command to download the installation or update script:

   ```bash
   wget https://raw.githubusercontent.com/impredmet/luckycoin-node-setup/refs/heads/main/install.sh
   ```

2. **Make the script executable**  
   After downloading, make the script executable by running the following command:

   ```bash
   chmod +x install.sh
   ```

3. **Run the script**  
   Execute the script to install or update the Luckycoin node:

   ```bash
   ./install.sh
   ```

4. **The script will handle everything**:

   - It will download the necessary files for the installation or update.
   - Install required dependencies (if needed).
   - Configure your node and start it in the background.

5. **Verify the installation or update**:  
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
