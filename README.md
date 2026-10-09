# 🛡️ Purple Team Lab: SOC Monitoring, Sysmon Telemetry & NTLM Detection

## 📌 Executive Summary
This project demonstrates a hands-on **Purple Team** workflow built on an isolated virtual network. It bridges offensive simulation (**Red Team**) with telemetry ingestion, log analysis, and detection engineering (**Blue Team**).

The primary objective is to simulate NTLM password spraying/bruteforce attacks against a Windows 10 host and construct custom, time-correlated detection rules in **Wazuh SIEM** mapped to the **MITRE ATT&CK** framework.

---

## 📐 Network Architecture & Topology

- **Network Mode:** VirtualBox Host-Only Adapter (`172.16.0.0/16`)
- **Attacker Host (Red Team):** Kali Linux (`172.16.14.36`)
- **Target Endpoint (Victim):** Windows 10 (`172.16.10.91`) with Wazuh Agent & Sysmon
- **SIEM Server (Blue Team / SOC):** Ubuntu Server running Wazuh Manager & Dashboard

---

## 🛠️ Components & Configuration

### 1. Endpoint Telemetry (Windows 10)
- **Sysmon Integration:** Configured to record process creation (Event ID 1), network connections (Event ID 3), and process access (Event ID 10).
- **Wazuh Agent (`ossec.conf`):** Configured to ingest the `Microsoft-Windows-Sysmon/Operational` channel alongside standard Windows Security Event logs.

### 2. Offensive Simulation (Kali Linux)
Network enumeration and authentication attacks executed using **NetExec (`nexec`)** and **Nmap**:
```bash
# Network & Service Enumeration
sudo nmap -sV -sC -A -p 135,139,445,3389 172.16.10.91

# NTLM Password Spraying / SMB Authentication Attempts
nexec smb 172.16.10.91 -u "Administrator" -p "WrongPassword123!"