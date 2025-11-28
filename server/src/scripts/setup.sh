#!/bin/bash

echo "Creating project structure..."

mkdir -p server/src/{config,routes,controllers,models,middlewares,services,utils,workers,queues,integrations,scripts}
mkdir -p server/tests/{unit,integration}

touch server/.env
touch server/docker-compose.yml
touch server/Dockerfile
touch server/README.md

# Core TS files
touch server/src/app.ts
touch server/src/server.ts
touch server/tsconfig.json

cd server

echo "Initializing Node + TS environment..."
npm init -y

echo "Installing TypeScript + types..."
npm install --save-dev typescript ts-node ts-node-dev @types/node @types/express @types/cors @types/bcrypt @types/jsonwebtoken @types/multer @types/uuid @types/ws jest ts-jest @types/jest supertest @types/supertest

echo "Installing production dependencies..."
npm install express pg sequelize reflect-metadata redis ioredis dotenv aws-sdk multer cors helmet morgan bcrypt jsonwebtoken joi bullmq elasticsearch winston stripe razorpay uuid axios

echo "Generating route/controller/service boilerplate files..."

declare -a MODULES=("auth" "user" "resource" "version" "upload" "purchase" "entitlement" "search" "admin")

for module in "${MODULES[@]}"
do
  touch src/routes/$module.routes.ts
  touch src/controllers/$module.controller.ts
  touch src/services/$(echo $module | sed 's/.*/\u&/')Service.ts
done

echo "Generating config files..."
touch src/config/{database.ts,redis.ts,logger.ts,s3.ts,elastic.ts,payments.ts,env.ts}

echo "Generating utils..."
touch src/utils/{jwt.ts,email.ts,pagination.ts,hashing.ts,fileHelpers.ts,presign.ts,validator.ts,uploader.ts,constants.ts}

echo "Generating workers & queues..."
touch src/workers/{index.ts,malwareScan.worker.ts,compression.worker.ts,indexing.worker.ts,email.worker.ts}
touch src/queues/{indexing.queue.ts,scan.queue.ts,mail.queue.ts,queueConfig.ts}

echo "Generating integrations..."
touch src/integrations/{stripe.ts,razorpay.ts,github.ts,dockerRegistry.ts,webhook.handlers.ts}

echo "Done. Full TypeScript backend environment created."
