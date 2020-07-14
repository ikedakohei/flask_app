FROM python:3.8.3

WORKDIR /flask_app
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
