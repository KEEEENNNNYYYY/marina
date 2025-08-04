from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

@app.route('/run_marina', methods=['GET'])
def run_marina():
    args = request.json.get('args', [])
    try:
        # Appeler le binaire OCaml avec arguments passés
        result = subprocess.run(['./marina'] + args, capture_output=True, text=True, check=True)
        return jsonify({'output': result.stdout})
    except subprocess.CalledProcessError as e:
        return jsonify({'error': e.stderr}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
