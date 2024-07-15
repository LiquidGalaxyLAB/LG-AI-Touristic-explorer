FROM ubuntu:22.04

WORKDIR /app

COPY setup.sh /app/setup.sh
# RUN chmod +x /app/setup.sh

RUN chmod +x /app/setup.sh && apt-get update && apt-get upgrade -y \
    && apt-get install -y \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

ENV DEBIAN_FRONTEND=noninteractive

COPY . . 

COPY requirements.txt /app/requirements.txt

RUN apt-get update && apt-get install -y nvidia-cudnn && pip3 install --no-cache-dir -r /app/requirements.txt

# RUN pip3 install --no-cache-dir -r /app/requirements.txt

COPY . /app

ENV FLASK_APP=app.py

EXPOSE 8107
# EXPOSE 11434

RUN /app/setup.sh

CMD ollama serve & flask run --host=0.0.0.0 --port=8107