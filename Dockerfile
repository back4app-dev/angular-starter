
# Stage 1
FROM node:14.19.1-alpine AS builder
# Update the base image to the latest version of Node.js 14.19.1, running on Alpine Linux

WORKDIR /usr/src/app

COPY package.json yarn.lock ./
# Copy package.json and yarn.lock to the working directory

RUN apk add --no-cache yarn
# Install the yarn package manager in the Alpine Linux-based image

# Installing dependencies
RUN yarn install --frozen-lockfile
# Install project dependencies using the yarn.lock file

COPY . .
# Copy all files and directories from the current directory to the working directory

# Building the application
RUN yarn build --prod
# Build the Angular application using the production flag
# Fixed typo: changed "yarn run build" to "yarn build"

# Stage 2
FROM nginx:1.15.8-alpine
# Switch to a lightweight Nginx image running on Alpine Linux

# Copying the built application to Nginx's default HTML directory
COPY --from=builder /usr/src/app/dist/angular-starter/ /usr/share/nginx/html
# Copy the built Angular application from the builder stage to the Nginx HTML directory
# This will the serve application through the Nginx web server
