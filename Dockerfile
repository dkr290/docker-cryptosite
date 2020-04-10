ARG BaseImage
FROM $BaseImage
ENV PYTHONUNBUFFERED 1
WORKDIR /code
COPY . .
ARG GunicornVer
ARG DjangoVer
RUN pip install --no-cache-dir gunicorn==$GunicornVer && pip install --no-cache-dir Django==$DjangoVer \
    && pip install --no-cache-dir requests
EXPOSE 8000
RUN python manage.py makemigrations && \
    python manage.py migrate && \
    echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@example.com', 'admin')" | python manage.py shell
CMD ["gunicorn", "-c", "gunicorn.ini", "cryptosite.wsgi"]