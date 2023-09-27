#!/bin/sh

mkdir ./public
mkdir ./src

npm init -y

echo "

react_frontend/
|-- public/       # Static files
|   |-- index.html
|   |-- favicon.ico
|-- src/          # React source files
|   |-- components/  # React components
|   |-- App.js       # Main React component
|   |-- index.js     # Entry point
|-- package.json  # Dependencies and scripts
|-- Dockerfile.react

">Directory_map.txt