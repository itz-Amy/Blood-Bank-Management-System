from app.donors import donors_bp

@donors_bp.route('/donors')
def list_donors():
    return 'Donors module - coming soon'