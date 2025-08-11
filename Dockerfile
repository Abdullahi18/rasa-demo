FROM python:3.8-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN rasa train

EXPOSE 8000 5005
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug"]
