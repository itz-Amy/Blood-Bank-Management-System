from app.hospital_requests import hospital_requests_bp

@hospital_requests_bp.route('/requests')
def send_request():
    return "Requests coming soon"