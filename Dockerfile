from flask import Flask, jsonify
import subprocess
import os

app = Flask(__name__)

@app.route("/")
def hello():
    return "API Python qui appelle OCaml !"

@app.route("/run_ocaml")
def run_ocaml():
    # Chemin vers le binaire OCaml compilé
    ocaml_bin = os.path.abspath("../marina/_build/default/main")

    if not os.path.exists(ocaml_bin):
        return jsonify({"error": "Le binaire OCaml n'existe pas."}), 500

    try:
        # Appel du binaire OCaml (sans argument ici, adapte si besoin)
        result = subprocess.run([ocaml_bin], capture_output=True, text=True, timeout=5)
        output = result.stdout.strip()
        return jsonify({"output": output})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    # API écoute sur 0.0.0.0:8000 (port exposé dans Docker)
    app.run(host="0.0.0.0", port=8000)
