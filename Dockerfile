# Start with a Python image.
FROM python:3.5-slim
MAINTAINER Bart Steverink <bart@in2systems.nl>

# Force stdin, stdout and stderr to be totally unbuffered
ENV PYTHONUNBUFFERED 1

# Install some necessary things.
RUN apt-get update && apt-get install -y \
    gcc \
    gettext \
    python3-dev \
    libmysqlclient-dev \
    --no-install-recommends && rm -rf /var/lib/apt/lists/*

# Create a directory for the code
RUN mkdir /code
WORKDIR /code

ADD requirements.txt /code/

# Install our requirements.
RUN pip install -U pip
RUN pip install -Ur requirements.txt

# Copy our app to the code directory
COPY . /code/

# Expose port 8000 out of the container
EXPOSE 8000

# Specify the command to run when the image is run.
CMD ["python", "app/manage.py", "runserver", "0.0.0.0:8000"]