#!/bin/bash
input="./asn-blacklist.txt"
while IFS= read -r asn_w_name
do
  echo ${asn_w_name} | cut -d "@" -f 2
  asn=`echo ${asn_w_name} | cut -d "@" -f 1`
  whois -h whois.radb.net -- "-i origin ${asn}" | awk '/^route:/ {print $2;}' | sort | uniq >> ips_v4.txt
  whois -h whois.radb.net -- "-i origin ${asn}" | awk '/^route6:/ {print $2;}' | sort | uniq >> ips_v6.txt
done < "$input"
