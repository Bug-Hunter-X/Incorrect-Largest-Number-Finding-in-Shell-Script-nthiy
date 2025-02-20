#!/bin/bash

# Improved script to find the largest number in a file, handling errors.

input_file="numbers.txt"

largest_number=0

# Check if the file exists and is readable
if [ ! -r "$input_file" ]; then
  echo "Error: Input file '$input_file' does not exist or is not readable." >&2
  exit 1
fi

while IFS= read -r number;
do
  # Check if the number is a valid integer
  if [[ ! "$number" =~ ^-?[0-9]+$ ]]; then
    echo "Warning: Skipping non-numeric value: $number"
    continue
  fi
  if (( number > largest_number )); then
    largest_number=$number
  fi
done < "$input_file"

# Check if any numbers were processed
if (( largest_number == 0 )) && (( $(wc -l < "$input_file") == 0 )); then
  echo "Error: Input file is empty." >&2
  exit 1
fi

if (( largest_number == 0 )); then
  echo "Error: No valid numbers found in the file." >&2
  exit 1
fi

echo "The largest number is: $largest_number"