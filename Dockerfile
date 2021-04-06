FROM python:3.9

COPY . /app

WORKDIR /app

RUN pip install -r requirements.txt

ENTRYPOINT ['robot','-d','logs','tasks/tasks.robot']