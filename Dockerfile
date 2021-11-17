# This is a file for production environment.

# You tagged your image as a builder for this stage. And every command under the FROM scipt will be refferied to the builder stage which will be responsible for install dependencies and build our app.
# Build Phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run Phase
FROM nginx

# The expose instruction to tell Elastic Beanstalk the port it should use to map for incoming traffic.  
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html