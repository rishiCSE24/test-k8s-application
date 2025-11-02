FROM python:slim
LABEL maintainer="Saptarshi Ghosh <rishi.cse.24@gmail.com>"

COPY ./app /app
WORKDIR /app
RUN python3 -m pip install --upgrade pip 
RUN pip3 install -r requirements.txt

EXPOSE 80

CMD [ "python3","server.py" ]
