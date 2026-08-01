from flask import Flask, jsonify
import socket
import os

app = Flask(__name__)

APP_VERSION = os.environ.get("APP_VERSION", "1.0.0")

@app.route("/")
def index():
    return jsonify({
        "message": "Capstone2 Infrastructure Automation Platform",
        "hostname": socket.gethostname(),
        "version": APP_VERSION
    })

@app.route("/health")
def health():
    return jsonify({"status": "healthy"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
