FROM python:3.15-rc-alpine3.22

RUN apk add --no-cache \
    build-base \
    libffi-dev

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN adduser -D celeryuser
USER celeryuser

CMD ["celery", "-A", "tasks", "worker", "--loglevel=info"]
