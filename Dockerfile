# Step 1
## base image for Step 1: Node 10
FROM node:18-alpine AS builder
WORKDIR /app
## 프로젝트의 모든 파일을 WORKDIR(/app)로 복사한다
COPY . .
## Nest.js project를 build 한다
RUN apk add --no-cache python3 make g++
RUN npm install
RUN npm rebuild bcrypt --build-from-source
RUN npm run build


# Step 2
## base image for Step 2: Node 10-alpine(light weight)
FROM node:18-alpine
WORKDIR /app
## Step 1의 builder에서 build된 프로젝트를 가져온다
COPY --from=builder /app ./
## application 실행
CMD ["npm", "run", "start:prod"]