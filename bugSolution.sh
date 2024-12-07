#!/bin/bash

# Create two files to simulate shared resources.
touch file1.txt
touch file2.txt

# Function to acquire exclusive lock on a file
lock_file() {
  flock -n "$1" || exit 1
}

# Function to release the lock
unlock_file() {
  flock -u "$1"
}

# Start two background processes that modify the files concurrently.
(while true; do echo "Process 1: Modifying file1.txt" >> file1.txt; sleep 0.1; done) &
(while true; do echo "Process 2: Modifying file2.txt" >> file2.txt; sleep 0.1; done) &

# Wait for a while to simulate some work
sleep 2

#Use a lock file to prevent race condition during file copy
lock_file <(exec 9>&1; echo file2.txt>&9; exec 9>&-) 

#Now we can safely copy file1.txt to file2.txt
cp file1.txt file2.txt

unlock_file <(exec 9>&1; echo file2.txt>&9; exec 9>&-)

#Kill the background processes
kill %1
kill %2

echo "Script finished"