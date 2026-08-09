from app.donations import donations_bp

@donations_bp.route('/donations')
def donations():
    return "Donations coming soon"