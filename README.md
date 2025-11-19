# DockerCelery

This is a simple Docker setup for running Celery workers with Python 3.12.

## Files

* `Dockerfile` – defines a Python 3.12 image with Celery installed.
* `requirements.txt` – Python dependencies.
* `WORKDIR /app` – working directory in the container.

## Build the Docker image

```bash
docker build -t docker-celery .
```

## Run the Celery worker

```bash
docker run -it -v $(pwd):/app docker-celery
```

The container will start a Celery worker using the `tasks.py` file in `/app`.

## Adding your tasks

Create a `tasks.py` file in the project directory:

```python
from celery import Celery

app = Celery('tasks', broker='redis://redis:6379/0')

@app.task
def add(x, y):
    return x + y
```

> Make sure to have a running broker (like Redis) to connect Celery to.

## Notes

* You can override the default CMD to run different commands in the container.
* Non-root user `celeryuser` is used for security.
