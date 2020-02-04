#!/bin/sh

echo "Building PassGen..."

echo "Building the libraries"
cd lib
./build.sh

cd ..

echo "Creating the whole thing..."
cat lib.big.lua main.lua > passgen.lua
luna passgen.lua passgen.tns

echo "Done building"

echo "Cleaning up"
rm *.big.lua

echo "Done. Enjoy !"
