# Stage 1: Build Angular application
FROM node AS builder 

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Build the Angular app
RUN npm run build-minikube

# Stage 2: Serve the app with nginx
FROM nginx:alpine 

# Copy built files from the previous stage
COPY --from=builder /app/dist/poc-angular/browser /usr/share/nginx/html 

# Expose the port nginx is running on
EXPOSE 80

# Command to run the nginx server
CMD ["nginx", "-g", "daemon off;"]