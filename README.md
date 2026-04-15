Project Sentinel: SQL Injection & Container Security Lab
Overview
This project is a containerized "Vulnerable by Design" web application used to demonstrate SQL Injection (SQLi) attacks and defenses. It uses a Flask frontend and a MySQL backend, orchestrated via Docker Compose.

Architecture
Web App: Python/Flask (Port 5000)
Database: MySQL 5.7 (Internal Port 3306)
Network: Isolated Docker bridge network

Getting Started
Clone the repo.

Run docker-compose up --build.

Access the app at http://localhost:5000/user?id=1.

Security Deep Dive: SQL Injection
The Vulnerability
The application is vulnerable because it uses f-strings to build SQL queries instead of prepared statements.

Python
# VULNERABLE CODE
query = f"SELECT username, email FROM users WHERE id = {user_id}"
Attack Examples
1. Basic Authentication Bypass (OR logic)
If the input is not sanitized, an attacker can change the logic of the query.

Payload: 1 OR 1=1
Resulting Query: SELECT username, email FROM users WHERE id = 1 OR 1=1
Effect: The database returns the first user in the table (usually the admin) because 1=1 is always true.

2. UNION-Based Injection (Data Exfiltration)
This allows an attacker to "glue" results from other tables to the original query.

Payload: 1 UNION SELECT service_name, api_key FROM system_config

Resulting Query: SELECT username, email FROM users WHERE id = 1 UNION SELECT service_name, api_key FROM system_config

Effect: The web page will display sensitive API keys from a completely different table.

3. Blind SQLi (Time-Based)
If the app doesn't show errors or data, attackers can use "sleep" commands to infer data.

Payload: 1 AND (SELECT 1 FROM (SELECT(SLEEP(5)))a)

Effect: If the server takes 5 seconds to respond, the attacker knows the query was successful.

Remediation
To fix this, we must use Parameterized Queries. This treats user input as "data" rather than "executable code."

Python
# SECURE CODE
cursor.execute("SELECT username, email FROM users WHERE id = %s", (user_id,))
Disclaimer
This project is for educational purposes only. Do not use these techniques on systems you do not own.

