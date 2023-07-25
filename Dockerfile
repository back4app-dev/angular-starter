
# Stage 1
FROM node:14.19.1-alpine AS builder
# Switch to a lightweight Node.js image that includes npm

WORKDIR /usr/src/app

COPY package.json yarn.lock ./
# Package.json and yarn.lock are copied to the working directory

RUN apk add --no-cache yarn
# Install yarn to handle dependencies in the Alpine Linux-based image

# Installing dependencies
RUN yarn install --frozen-lockfile
# Install project dependencies using the yarn.lock file

COPY . .
# Copy all the files and directories from the current directory to the working directory

# Building the application
RUN yarn run build --prod
# Build the Angular application using the production flag

# Stage 2
FROM nginx:1.15.8-alpine
# Switch to a lightweight Nginx image

# Copying the built application to Nginx's default HTML directory
COPY --from=builder /usr/src/app/dist/angular-starter/ /usr/share/nginx/html
# Copy the built Angular application from the builder stage to the Nginx HTML directory
# will This serve the application through the Nginx web server
