# Luckycoin Node Setup

This guide explains how to install the **Luckycoin** node on Linux and Windows.

## Prerequisites

- **Linux**: Ensure that `curl` is installed on your machine.
- **Windows**: Simply download the `.exe` file from the releases page.

---

## Installation on Linux

1. **Download and run the installation script**  
   Open a terminal and execute the following command to download and run the installation script:

   ```bash
   curl -s https://raw.githubusercontent.com/impredmet/luckycoin-node-setup/refs/heads/main/install.sh | bash
   ```

2. **The script will handle everything**:

   - It will download the necessary files for the installation.
   - Install required dependencies.
   - Configure your node and start it in the background.

3. **Verify the installation**:  
   Once the installation is complete, you can check if the node is running by using the following command:

   ```bash
   luckycoin-cli getblockcount
   ```

---

## Installation on Windows

1. **Download the executable**  
   Simply go to the [Luckycoin V3 releases page](https://github.com/LuckyCoinProj/luckycoinV3/releases) and download the latest `.exe` file for Windows.

2. **Run the `.exe` file**  
   After downloading, run the `.exe` file to start the Luckycoin Node on your Windows machine.

3. **Verify the installation**:  
   Once the node is running, you can check its status by running the following command in the `cmd` or PowerShell:

   ```cmd
   luckycoin-cli getblockcount
   ```
