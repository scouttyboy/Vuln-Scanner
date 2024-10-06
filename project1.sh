#!/bin/bash

echo "Note : You Should Have Root Privilage TO Run These Tool...."

read -p "Enter The Traget ip Address : " ip

#for basic vulnerability scan 
function basic_scan(){
        echo "Basic  SCAN : "
        echo "- - - - - - - - - - - - - - - - - - - - - - -"
        nmap --script vuln $ip
        echo "- - - - - - - - - - - - - - - - - - - - - - - "
        echo
}
#function for specific scan
function specific_scan(){
        echo "SPECIFIC SCAN : "
        echo " "
        echo " "
        echo "--->      Scan for SMB Vulnerabilities (EternalBlue, etc.)"
        nmap --script smb-vuln* -p445 $ip
        echo " "
        echo " "
        echo "--->     Scan for Heartbleed Vulnerability (SSL)"
        nmap --script ssl-heartbleed -p 443 $ip
        echo " "
        echo " "
        echo "--->    Scan for HTTP-related Vulnerabilities"
        nmap --script http-vuln-cve2017-5638 -p 80,443 $ip
        echo                                                                                                                                                                                                                               
}                                                                                                                                                                                                                                          
#function for OS and service version Detection                                                                                                                                                                                             
function OS(){
        echo "--->   Operating System and Service Version Detection "
        echo " "
        echo "--->   OS and Version Detection "
        nmap -A $ip
        echo "                                                                       "
        echo
}
#function for CVE
function cve(){
        echo "--->   Comprehensive Vulnerability scanning with CVE"
        echo " "
        echo "--->   CVE Vulnerability Scanning"
        nmap --script vuln --script-args vulns.showall -sv $ip
        echo "                                                                      "
        echo
}
#function for Default Creds
function cred(){
        echo "--->   Scanning for Default Credentials"
        echo " "
        echo "--->   Scan for Default HTTP credentials"
        nmap --script http-default-accounts -p 80,443 $ip
        echo " "
        echo
}
#main menu fucntion 
function menu(){
        echo "1)  Vuln Scan"
        echo "2) Specific Vulnerability Scan"
        echo "3) OS and Service Version Detection"
        echo "4) Comprehensive Vulnerability scanning with CVE"
        echo "5) Scanning for Default Credentials"
        echo "6) Exit ..."
        echo
        read -p " select [1-7] :  "  choice

        case $choice in 

                1)
                        basic_scan
                        ;;
                2)
                        specific_scan
                        ;;
                3)
                        OS
                        ;;
                4)
                        cve
                        ;;
                5)
                        cred
                        ;;
                6)
                        echo "exiting...."
                        exit 0
                        ;;
                *)
                        echo "invalid option"
                        ;;
        esac
}
# loop for function m enu 
 while true; do
         menu
 done
