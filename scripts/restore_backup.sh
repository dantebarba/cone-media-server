#!/bin/bash

set -e

# Check if the correct number of arguments were supplied
if [ $# -ne 2 ]; then
  echo "Usage: $0 <backup_file> <target_directory>"
  exit 1
fi

# Get the backup file and target directory
backup_file="$1"
tgtdir="$2"

# Create a temporary directory for the backup
tmpdir=$(mktemp -d)

# Extract the backup file to the temporary directory
tar --extract --gzip --file="$backup_file" --directory="$tmpdir"

# Restore the source directory
srcdir_basename=$(basename "$srcdir")
srcdir_tmpdir="${tmpdir}/${srcdir_basename}"
mv "$srcdir_tmpdir" "$tgtdir"

# Remove the temporary directory
rm -rf "$tmpdir"

# Print a message indicating that the restore was successful
echo "Backup restored to $tgtdir"
