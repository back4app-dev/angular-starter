
# Stage 1
FROM node:14.19.1-alpine AS builder

WORKDIR /usr/src/app

COPY package.json yarn.lock ./

RUN apk add --no-cache yarn

# Fixed typo: "yarn install" should be "yarn install --frozenfile"
-lockRUN yarn install --frozen-lockfile

COPY . .

RUN yarn run build --prod

# Stage 2
FROM nginx:1.15.8-alpine

COPY --from=builder /usr/src/app/dist/angular-starter/ /usr/share/nginx/html
