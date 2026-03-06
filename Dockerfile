FROM nginx:alpine

# Remove default nginx static files
RUN rm -rf /usr/share/nginx/html/*

# Copy built React files
COPY dist/ /usr/share/nginx/html/

# Expose container port
EXPOSE 80

# Start nginx in foreground 
CMD ["nginx", "-g", "daemon off;"]
