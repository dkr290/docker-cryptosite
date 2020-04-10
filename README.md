docker run -d --name web --network crypto_net crypto:gunicorn
docker run -d --name mynginx1 --network crypto_net -p 8080:8080 nginx:crypto