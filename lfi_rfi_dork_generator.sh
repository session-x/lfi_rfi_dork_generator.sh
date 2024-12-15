#!/bin/bash

# Filename: lfi_rfi_dork_generator.sh
# Description: Generates Google Dork search URLs for File Inclusion Vulnerabilities (LFI/RFI) for a given domain

# Predefined dorks for Local File Inclusion (LFI) and Remote File Inclusion (RFI)
lfi_rfi_dorks=(
  # Local File Inclusion (LFI) Dorks
  'site:{DOMAIN} inurl:"?page="'
  'site:{DOMAIN} inurl:"?file="'
  'site:{DOMAIN} inurl:"?include="'
  'site:{DOMAIN} inurl:"?view="'
  'site:{DOMAIN} inurl:"?tpl="'
  'site:{DOMAIN} inurl:"?template="'
  'site:{DOMAIN} inurl:"?action="'
  'site:{DOMAIN} inurl:"?file=../"'
  'site:{DOMAIN} inurl:"?page=../../../../etc/passwd"'
  'site:{DOMAIN} inurl:"?file=../../../../etc/passwd"'
  'site:{DOMAIN} inurl:"?view=../../../../etc/passwd"'
  'site:{DOMAIN} inurl:"?include=../../../../etc/passwd"'
  'site:{DOMAIN} inurl:"?file=php://input"'
  'site:{DOMAIN} inurl:"?file=php://filter"'
  'site:{DOMAIN} inurl:"?file=php://stderr"'
  'site:{DOMAIN} inurl:"?page=php://filter/convert.base64-encode/resource="'
  'site:{DOMAIN} inurl:"?page=php://input"'
  'site:{DOMAIN} inurl:"?file=php://output"'
  'site:{DOMAIN} inurl:"?include=php://filter"'
  'site:{DOMAIN} inurl:"?file=php://temp"'
  'site:{DOMAIN} intitle:"index of" "passwd"'
  'site:{DOMAIN} intitle:"index of" "config"'
  'site:{DOMAIN} intitle:"index of" "etc"'
  'site:{DOMAIN} intitle:"index of" "wp-config.php"'

  # Remote File Inclusion (RFI) Dorks
  'site:{DOMAIN} inurl:"?url="'
  'site:{DOMAIN} inurl:"?file="'
  'site:{DOMAIN} inurl:"?page="'
  'site:{DOMAIN} inurl:"?include="'
  'site:{DOMAIN} inurl:"?source="'
  'site:{DOMAIN} inurl:"?link="'
  'site:{DOMAIN} inurl:"?target="'
  'site:{DOMAIN} inurl:"?redir="'
  'site:{DOMAIN} inurl:"?remote="'
  'site:{DOMAIN} inurl:"?url=http"'
  'site:{DOMAIN} inurl:"?url=https"'
  'site:{DOMAIN} inurl:"?file=http"'
  'site:{DOMAIN} inurl:"?file=https"'
  'site:{DOMAIN} inurl:"?page=http"'
  'site:{DOMAIN} inurl:"?page=https"'
  'site:{DOMAIN} inurl:"?include=http"'
  'site:{DOMAIN} inurl:"?include=https"'
  'site:{DOMAIN} inurl:"?link=http"'
  'site:{DOMAIN} inurl:"?link=https"'
  'site:{DOMAIN} inurl:"?target=http"'
  'site:{DOMAIN} inurl:"?target=https"'
  'site:{DOMAIN} inurl:"?redir=http"'
  'site:{DOMAIN} inurl:"?redir=https"'
  'site:{DOMAIN} inurl:"?source=http"'
  'site:{DOMAIN} inurl:"?source=https"'

  # Additional potential file inclusion
  'site:{DOMAIN} inurl:"?file=log.php"'
  'site:{DOMAIN} inurl:"?file=error.log"'
  'site:{DOMAIN} inurl:"?file=access.log"'
  'site:{DOMAIN} inurl:"?file=debug.php"'
  'site:{DOMAIN} inurl:"?file=readme.txt"'
  'site:{DOMAIN} inurl:"?file=config.php"'
  'site:{DOMAIN} inurl:"?file=admin.php"'
  'site:{DOMAIN} inurl:"?file=ftp.php"'
  'site:{DOMAIN} inurl:"?file=setup.php"'
  'site:{DOMAIN} inurl:"?file=database.php"'
  'site:{DOMAIN} inurl:"?file=index.php"'
  'site:{DOMAIN} inurl:"?file=login.php"'
)

# Ask for the domain
read -p "Enter the domain (e.g., example.com): " domain

# Validate input
if [[ -z "$domain" ]]; then
  echo "Domain cannot be empty. Exiting."
  exit 1
fi

# Generate links
output_file="lfi_rfi_dork_links_${domain}.txt"
echo "Generating dork search links for File Inclusion Vulnerabilities (LFI/RFI) for domain: $domain"
echo "Links saved to $output_file"
echo "-----------------------------" > "$output_file"

# Loop through all the predefined dorks
for dork in "${lfi_rfi_dorks[@]}"; do
  # Replace {DOMAIN} with the user's input
  dork_query=${dork//\{DOMAIN\}/$domain}
  # Encode the dork for a Google search URL
  encoded_dork=$(echo "$dork_query" | jq -sRr @uri)
  # Generate the full Google search URL
  google_link="https://www.google.com/search?q=$encoded_dork"
  # Save to file
  echo "$google_link" >> "$output_file"
  echo "$google_link"
done

echo "Done! All dork links are saved in $output_file."
