from flask import Flask, jsonify, request
import requests

app = Flask(__name__)
API_TOKEN = "supersecrettoken123"

# Map of city names to WorldTimeAPI timezones
CITIES = {
    "London": "Europe/London",
    "New York": "America/New_York",
    "Tokyo": "Asia/Tokyo",
    "Canberra": "Australia/Sydney",
    "Ottawa": "America/Toronto",
    "Paris": "Europe/Paris",
    "New Delhi": "Asia/Kolkata",
    "Beijing": "Asia/Shanghai",
    "Brasília": "America/Sao_Paulo"
}

def token_required(f):
    def decorator(*args, **kwargs):
        auth_header = request.headers.get('Authorization')
        if auth_header and auth_header.startswith("Bearer "):
            token = auth_header.split(" ")[1]
            if token == API_TOKEN:
                return f(*args, **kwargs)
        return jsonify({"error": "Unauthorized. Provide a valid Bearer token."}), 401
    decorator.__name__ = f.__name__
    return decorator

@app.route('/api/time', methods=['GET'])
@token_required
def get_time():
    city = request.args.get('city')
    if not city or city not in CITIES:
        return jsonify({"message": f"City '{city}' not found in database."}), 404

    timezone = CITIES[city]
    try:
        response = requests.get(f'https://worldtimeapi.org/api/timezone/{timezone}')
        data = response.json()

        return jsonify({
            "city": city,
            "local_time": data['datetime'],
            "utc_offset": data['utc_offset']
        })

    except Exception as e:
        return jsonify({"message": "Can't access API", "error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
