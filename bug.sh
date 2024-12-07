#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files to simulate shared resources.
touch file1.txt
touch file2.txt

# Start two background processes that modify the files concurrently.
(while true; do echo "Process 1: Modifying file1.txt" >> file1.txt; sleep 0.1; done) &
(while true; do echo "Process 2: Modifying file2.txt" >> file2.txt; sleep 0.1; done) &

# Wait for a while to simulate some work
sleep 2

# Try to copy file1 to file2, which might fail if file2 is being modified
cp file1.txt file2.txt

# This part shows that the copy operation might fail because of a race condition 
# resulting in an incomplete copy or a corruption of file2

# Kill the background processes
kill %1
kill %2

echo "Script finished"