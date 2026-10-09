#!/bin/bash
# ==============================================================================
# Script : attack_simulation.sh
# Description : Automation script for Purple Team lab attack simulation
# Target : Windows 10 Host (172.16.10.91)
# ==============================================================================

TARGET_IP="172.16.10.91"

echo -e "\e[1;34m[*] Starting Red Team Simulation against ${TARGET_IP}...\e[0m"

# Phase 1 : Network Enumeration (Nmap)
echo -e "\n\e[1;33m[1/2] Executing Nmap Port Scan & Service Enumeration...\e[0m"
sudo nmap -sV -sC -p 135,139,445,3389 ${TARGET_IP}

# Phase 2 : NTLM Password Spraying (NetExec)
echo -e "\n\e[1;33m[2/2] Generating consecutive failed SMB logons (NTLM Spraying)...\e[0m"
for i in {1..7}; do
    echo "[+] Attempt $i..."
    netexec smb ${TARGET_IP} -u "UserTest" -p "BadPassword$i" --continue-on-success
    sleep 1
done

echo -e "\n\e[1;32m[+] Simulation finished! Check Wazuh Dashboard for Rule 100100 alerts.\e[0m"