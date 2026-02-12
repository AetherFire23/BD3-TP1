import oracledb

def run_sql_file(connection, file_path):
    cursor = connection.cursor()

    with open(file_path, "r", encoding="utf-8") as f:
        sql_script = f.read()

    # Split by semicolon
    statements = sql_script.split(";")

    for statement in statements:
        statement = statement.strip()
        if not statement:
            continue

        try:
            cursor.execute(statement)
            print("✅ Executed")
        except Exception as e:
            print("❌ Error but continuing:")
            print(e)

    connection.commit()
    cursor.close()


if __name__ == "__main__":
    connection = oracledb.connect(
        user="my_user",
        password="my_password",
        dsn="localhost/XEPDB1"
    )

    run_sql_file(connection, "myscript.sql")

    connection.close()
