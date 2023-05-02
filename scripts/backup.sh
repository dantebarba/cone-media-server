#!/bin/bash

set -e

# Check if the correct number of arguments were supplied
if [ $# -ne 2 ]; then
  echo "Usage: $0 <source_directory> <target_directory>"
  exit 1
fi

# Get the source and target directories
srcdir="$1"
tgtdir="$2"

# Create a temporary directory for the backup
tmpdir=$(mktemp -d)

# Get the hostname
hostname=$(hostname)

# Create the backup filename using the hostname and current date
backup_filename="${hostname}_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

# Create a dump of /etc/environment
etc_env_dump="${tmpdir}/etc_environment_dump.txt"
cat /etc/environment > "${etc_env_dump}"

# Backup the crontab to a file in the temporary directory
crontab_file="${tmpdir}/crontab.txt"
crontab -l > "${crontab_file}"

# Create the backup file in the temporary directory
tar cf - -C "${srcdir}" "." -P | pv -s $(du -sb "${srcdir}" | awk '{print $1}') | gzip > "${tmpdir}/${backup_filename}"

tar -C "${tmpdir}" -rvzf "${tmpdir}/${backup_filename}" ${crontab_file} ${etc_env_dump}

# Move the backup file to the target directory
mv "${tmpdir}/${backup_filename}" "${tgtdir}/"

# Remove the temporary directory
rm -rf "${tmpdir}"

# Print a message indicating that the backup was successful
echo "Backup created at ${tgtdir}/${backup_filename}"