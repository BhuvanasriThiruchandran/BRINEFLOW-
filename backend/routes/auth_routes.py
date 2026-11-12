from flask import Blueprint, jsonify, request

bp = Blueprint("auth", __name__, url_prefix="/auth")


@bp.get("/health")
def auth_health():
    return jsonify({"status": "ok", "module": "auth"})


@bp.post("/login")
def login():
    payload = request.get_json(silent=True) or {}
    username = payload.get("username", "")
    password = payload.get("password", "")

    if username == "admin" and password == "admin123":
        return jsonify({
            "status": "success",
            "message": "Login successful",
            "user": {"username": username, "role": "operator"},
        }), 200

    return jsonify({"status": "error", "message": "Invalid credentials"}), 401


@bp.post("/register")
def register():
    payload = request.get_json(silent=True) or {}
    username = payload.get("username", "")
    email = payload.get("email", "")
    password = payload.get("password", "")

    if not username or not email or not password:
        return jsonify({"status": "error", "message": "Missing required fields"}), 400

    return jsonify({
        "status": "success",
        "message": "User registered successfully",
        "user": {"username": username, "email": email},
    }), 201
