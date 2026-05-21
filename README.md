# Bash Interactive File Manager

A simple, menu-driven bash script for managing files and directories directly from the terminal. 

## Features

* **Create**: Generate new empty files or directories at any specified path.
* **Read**: View file contents directly in the terminal.
* **Edit**: 
  * **Files**: Append text, overwrite content, or open the file in the `nano` text editor. (If the specified file doesn't exist, the script creates it automatically).
  * **Folders**: Create new sub-files, sub-folders, or list detailed directory contents (`ls -la`).
* **Delete**: Remove files or entire directories recursively, protected by a y/N confirmation prompt to prevent accidental data loss.

## Prerequisites

This script runs in standard Unix-like environments. It relies on:
* `bash`
* Standard core utilities (`touch`, `mkdir`, `cat`, `rm`, `ls`, `chmod`)
* `nano` (Required for the interactive text editor option)

## Usage

1. Save the script to a file on your system, for example, `file_manager.sh`.
2. Make the script executable by running:
   ```bash
   chmod +x file_manager.sh
