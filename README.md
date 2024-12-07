# Race Condition Bug in Bash Script

This repository demonstrates a race condition bug in a bash script.  The script uses two background processes that concurrently modify files, leading to potential data corruption when copying one file to another. The bug is explained in detail in the `bug.sh` file, with a solution provided in `bugSolution.sh`.

## Bug Description

The `bug.sh` script creates two files and then launches two background processes that continuously write to these files.  A `cp` command attempts to copy one file to the other.  This leads to a race condition because the copy operation may be interrupted if the target file is concurrently being modified.

## Solution

The `bugSolution.sh` script addresses this race condition by using proper locking mechanisms to ensure exclusive access to the files during the copy operation.  This prevents data corruption.

## How to reproduce
1. Clone this repository.
2. Run `bug.sh`.
3. Observe the potential corruption or incomplete copy of the target file.
4. Run `bugSolution.sh` and observe how the issue is resolved using a proper locking mechanism.