#!/bin/sh

mkdir -p express_root/{controllers,models,routes,middlewares,utils}

cd ./express_root

echo "const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
    res.send('Hello, world!');
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});">index.js

npm init -y

# package.jsonの内容を変数に格納
PACKAGE_JSON_CONTENT=$(cat package.json | jq '
    .scripts += {
        "start": "node index.js"
    }
    | .dependencies += {
        "express": "^4.17.1"
    }
')

# 変数の内容をpackage.jsonに書き込み
echo "$PACKAGE_JSON_CONTENT" > package.json

npm install express

cd ..

pwd

echo "
node_backend/
|
express_root/
|
|-- controllers/  # Controller functions
|-- models/       # Database models
|-- routes/       # API routes
|-- middlewares/  # Middleware functions
|-- utils/        # Utility functions and constants
|-- app.js        # Main application file
|-- package.json  # Dependencies and scripts
|-- Dockerfile.nodejs
" > Directory_map.txt
