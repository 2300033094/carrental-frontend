# Step 1: Build stage
FROM node:18 AS build
WORKDIR /app

# Install git
RUN apt-get update && apt-get install -y git

# Clone your GitHub repo
RUN git clone https://github.com/2300033094/carrental-frontend.git .

# Install dependencies and build
RUN npm install
RUN npm run build

# Step 2: Serve using Nginx
FROM nginx:stable-alpine
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
