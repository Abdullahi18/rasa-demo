from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

RASA_URL = "http://localhost:5005/webhooks/rest/webhook"

@app.route("/chat", methods=["POST"])
def chat():
    data = request.json
    user_message = data.get("message", "")
    sender_id = data.get("sender", "user1")
    response = requests.post(
        RASA_URL,
        json={"sender": sender_id, "message": user_message}
    )
    bot_reply = response.json()
    if bot_reply and "text" in bot_reply[0]:
        return jsonify({"reply": bot_reply[0]["text"]})
    return jsonify({"reply": "Sorry, I didn't understand that."})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
