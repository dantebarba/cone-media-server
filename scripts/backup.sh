#!/bin/bash

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
backup_filename="backup_${hostname}_$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

# Create the backup file in the temporary directory
tar cf - "${srcdir}" -P | pv -s $(du -sb "${srcdir}" | awk '{print $1}') | gzip > "${tmpdir}/${backup_filename}"

# Move the backup file to the target directory
mv "${tmpdir}/${backup_filename}" "${tgtdir}/"

# Remove the temporary directory
rm -rf "${tmpdir}"

# Print a message indicating that the backup was successful
echo "Backup created at ${tgtdir}/${backup_filename}"