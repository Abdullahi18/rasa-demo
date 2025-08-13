FROM python:3.8-slim

# Install wget
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Download the model from Google Drive
# Replace with your Google Drive file ID
ENV GDRIVE_FILE_ID=1bwgzKi6c0VYXaEAxwyiq7F44sNFkTwXy
ENV MODEL_PATH=/app/models/latest.tar.gz

# Download large file from Google Drive
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/* && \
    wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate \
    "https://docs.google.com/uc?export=download&id=${GDRIVE_FILE_ID}" -O- \
    | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1/p' > /tmp/confirm.txt && \
    wget --load-cookies /tmp/cookies.txt \
    "https://docs.google.com/uc?export=download&confirm=$(cat /tmp/confirm.txt)&id=${GDRIVE_FILE_ID}" \
    -O ${MODEL_PATH} && rm -rf /tmp/cookies.txt /tmp/confirm.txt


EXPOSE 8000 5005
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--debug"]
