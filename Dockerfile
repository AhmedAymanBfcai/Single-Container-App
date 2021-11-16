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
COPY --from=builder /app/build /usr/share/nginx/html