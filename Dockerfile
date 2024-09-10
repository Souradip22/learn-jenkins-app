FROM nginx:1.27-alpine
# List files in the root directory of the build context
RUN ls -la
COPY build /usr/share/nginx/html