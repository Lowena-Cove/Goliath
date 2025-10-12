#!/bin/bash
# Fix the empty if statement in configure script
sed -i '18274s/^$/    :/' /workspace/configure
echo "Fixed empty if statement in configure script"