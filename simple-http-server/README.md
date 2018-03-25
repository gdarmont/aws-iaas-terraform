Start container with inside VM :
docker run -p 80:8000 -d --restart=unless-stopped gdarmont/aws-iaas-simple-http-server:v2

This will allow container to start at docker daemon startup.