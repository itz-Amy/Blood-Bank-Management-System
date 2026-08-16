from io import BytesIO

import pandas as pd
from flask import render_template, send_file
from flask_login import login_required, current_user
from sqlalchemy import text

from app.reports import reports_bp
from app.extensions import db
from app.auth.decorators import staff_required


@reports_bp.route("/reports")
@login_required
@staff_required
def index():
    return render_template("reports/index.html")


# inventory report

@reports_bp.route("/reports/inventory/excel")
@login_required
@staff_required
def export_inventory():

    query = """
        SELECT
            bu.bloodUnit_id,
            bt.abo_group,
            bt.rh_factor,
            bu.blood_vol,
            bu.expiry_date,
            br.branchName,
            inv.status
        FROM BloodUnit bu
        JOIN BloodType bt
            ON bu.blood_type_id = bt.blood_type_id
        JOIN Inventory inv
            ON bu.bloodUnit_id = inv.bloodUnit_id
        JOIN Branch br
            ON inv.branch_id = br.branch_id
        ORDER BY bu.expiry_date
    """

    df = pd.read_sql(text(query), db.engine)

    output = BytesIO()

    with pd.ExcelWriter(output, engine="openpyxl") as writer:
        df.to_excel(
            writer,
            index=False,
            sheet_name="Inventory Report"
        )

    output.seek(0)

    return send_file(
        output,
        as_attachment=True,
        download_name="inventory_report.xlsx",
        mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    )


# request report

@reports_bp.route("/reports/requests/excel")
@login_required
@staff_required
def export_requests():

    query = """
        SELECT
            r.Request_id,
            h.HospitalName,
            bt.abo_group,
            bt.rh_factor,
            r.Quantity,
            r.Status,
            r.RequestDate
        FROM Request r
        JOIN Hospital h
            ON r.Hospital_id = h.Hospital_id
        JOIN BloodType bt
            ON r.BloodType = bt.blood_type_id
        ORDER BY r.RequestDate DESC
    """

    df = pd.read_sql(text(query), db.engine)

    output = BytesIO()

    with pd.ExcelWriter(output, engine="openpyxl") as writer:
        df.to_excel(
            writer,
            index=False,
            sheet_name="Request Report"
        )

    output.seek(0)

    return send_file(
        output,
        as_attachment=True,
        download_name="request_report.xlsx",
        mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    )


# issuance report

@reports_bp.route("/reports/issuances/excel")
@login_required
@staff_required
def export_issuances():

    query = """
        SELECT
            i.Issuance_id,
            i.Request_id,
            h.HospitalName,
            i.IssuedUnits,
            i.IssueDate,
            i.StaffID
        FROM Issuance i
        JOIN Request r
            ON i.Request_id = r.Request_id
        JOIN Hospital h
            ON r.Hospital_id = h.Hospital_id
        ORDER BY i.IssueDate DESC
    """

    df = pd.read_sql(text(query), db.engine)

    output = BytesIO()

    with pd.ExcelWriter(output, engine="openpyxl") as writer:
        df.to_excel(
            writer,
            index=False,
            sheet_name="Issuance Report"
        )

    output.seek(0)

    return send_file(
        output,
        as_attachment=True,
        download_name="issuance_report.xlsx",
        mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    )