#!/bin/bash

# This script burns an ISO image to a USB drive on macOS.
# WARNING: This script will erase the contents of the USB drive.

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <ISO file path> <Disk Identifier>"
    echo "Example: $0 /path/to/image.iso disk2"
    exit 1
fi

ISOFILE="$1"
DISKIDENTIFIER="/dev/$2"
DISKIDENTIFIERRAW="/dev/r$2"

if [ ! -f "$ISOFILE" ]; then
    echo "Error: The specified ISO file does not exist."
    exit 1
fi

echo "Unmounting $DISKIDENTIFIER..."
diskutil unmountDisk $DISKIDENTIFIER

if [ $? -ne 0 ]; then
    echo "Error: Failed to unmount $DISKIDENTIFIER. Please check the disk identifier."
    exit 1
fi

echo "Burning $ISOFILE to $DISKIDENTIFIERRAW. This may take a while..."
sudo dd if="$ISOFILE" of="$DISKIDENTIFIERRAW" bs=1m

echo "Ejecting $DISKIDENTIFIER..."
diskutil eject $DISKIDENTIFIER

echo "The ISO was successfully burned to $DISKIDENTIFIER."
