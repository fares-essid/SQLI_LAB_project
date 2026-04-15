import mysql.connector
from flask import Flask, request, render_template

app = Flask(__name__)

def get_db_connection():
    return mysql.connector.connect(
        host="db",
        user="root",
        password="Fares",
        database="vuln_db"
    )

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/user')
def get_user():
    user_id = request.args.get('id')
    query = f"SELECT username, email FROM users WHERE id = {user_id}"
    
    results = []
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        cursor.close()
        conn.close()
    except Exception as e:
        results = [("Error", str(e))]

    return render_template('index.html', data=results, query=query)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)