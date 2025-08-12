FROM python:3.8-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# RUN rasa train
#COPY models /app/models
RUN wget -O /app/models/latest.tar.gz "https://drive.google.com/file/d/1C7rm_gbkvdUDOf_6Ww-glm9UkYiW-IZP/view?usp=drive_link"
EXPOSE 8000 5005
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug"]
