#!/bin/bash
# Check for empty if statements in configure script
grep -n -A2 -B1 "^then$" /workspace/configure | grep -A3 -B1 "^[0-9]*-$" || echo "No empty if statements found"