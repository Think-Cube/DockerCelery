FROM python:3.12-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

RUN useradd -ms /bin/bash celeryuser
USER celeryuser

CMD ["celery", "-A", "tasks", "worker", "--loglevel=info"]
