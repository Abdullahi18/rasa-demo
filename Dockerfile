FROM python:3.8-slim

# Install wget
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Download the model from Google Drive
RUN wget -O /app/models/latest.tar.gz "https://drive.google.com/uc?id=1C7rm_gbkvdUDOf_6Ww-glm9UkYiW-IZP"

EXPOSE 8000 5005
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug"]
