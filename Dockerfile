FROM python:3.10

# Install system dependencies
RUN apt-get update && apt-get install -y git

# Install Rasa
RUN pip install rasa

# Copy your Rasa project and Flask app
WORKDIR /app
COPY . /app

# Install Flask and requests
RUN pip install flask requests

# Train the Rasa model
RUN rasa train

# Expose ports
EXPOSE 5005 8000

# Start both Rasa and Flask (use a process manager)
CMD rasa run --enable-api --cors "*" & python app.py
