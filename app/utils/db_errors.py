from sqlalchemy.exc import IntegrityError, OperationalError


def get_db_error_message(error):
    """
    Convert common database errors into user-friendly messages.
    """

    message = str(getattr(error, "orig", error))

    if isinstance(error, IntegrityError):

        if "Duplicate entry" in message:
            return "This record already exists. Duplicate values are not allowed."

        if "foreign key constraint" in message.lower():
            return (
                "This record cannot be saved because one of the "
                "referenced records does not exist."
            )

        return "This record could not be saved because it violates a database constraint."

    if isinstance(error, OperationalError):

        if "command denied" in message.lower():
            return "You do not have permission to perform this operation."

        if "execute command denied" in message.lower():
            return "You do not have permission to execute this database operation."

        return "A database error occurred while processing your request."

    return "An unexpected database error occurred."