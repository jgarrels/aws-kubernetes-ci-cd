# Pull the NGINX Docker image
# hadolint ignore=DL3006
FROM nginx

# Remove the initial NGINX landing page
RUN rm /usr/share/nginx/html/index.html

# Copy my landing page to the nginx server
COPY index.html /usr/share/nginx/html