FROM ubuntu:22.04

WORKDIR /app

COPY setup.sh /app/setup.sh

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=noninteractive

COPY . . 

COPY requirements.txt /app/requirements.txt

RUN apt-get update && pip3 install --no-cache-dir -r /app/requirements.txt

RUN chmod +x /app/setup.sh 

RUN /app/setup.sh

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y nvidia-cudnn nvidia-cuda-toolkit

COPY . /app

ENV FLASK_APP=app.py

EXPOSE 8107

CMD ollama serve & flask run --host=0.0.0.0 --port=8107