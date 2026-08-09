from app.distribution import distribution_bp

@distribution_bp.route('/distribution')
def distribute():
    return 'Distribution page - coming soon'