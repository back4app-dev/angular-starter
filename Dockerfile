# Stage 1: Builder
FROM node:14.19.1-alpine AS builder

WORKDIR /usr/src/app

COPY package.json yarn.lock ./

# Install dependencies using Yarn
RUN yarn install --frozen-lockfile --non-interactive

# Build the application
COPY . .
RUN yarn build --prod

# Stage 2: Production
FROM nginx:1.21.3-alpine

# Copy built artifacts from the builder stage
COPY --from=builder /usr/src/app/dist/angular-starter/ /usr/share/nginx/html

