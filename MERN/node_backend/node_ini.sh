#!/bin/sh

mkdir ./controllers
mkdir ./models
mkdir ./routes
mkdir ./middlewares
mkdir ./utils

npm init -y


echo "
node_backend/
|-- controllers/  # Controller functions
|-- models/       # Database models
|-- routes/       # API routes
|-- middleware/   # Middleware functions
|-- utils/        # Utility functions and constants
|-- app.js        # Main application file
|-- package.json  # Dependencies and scripts
|-- Dockerfile.nodejs


">>./Directory