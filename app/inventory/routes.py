from app.inventory import inventory_bp

@inventory_bp.route('/inventory')
def inventory():
    return "Not sure we need this"