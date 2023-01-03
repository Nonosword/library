#!/usr/bin/env python3
from flask import Flask, jsonify
from flask import abort
from flask import make_response
from flask import request
from flask import url_for
from flask_httpauth import HTTPBasicAuth
from flaskext.mysql import MySQL

app = Flask(__name__)
auth=HTTPBasicAuth()
mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'replace_USER'
app.config['MYSQL_DATABASE_PASSWORD'] = 'replace_PASSWORD!' 
app.config['MYSQL_DATABASE_DB'] = 'replace_DB' 
app.config['MYSQL_DATABASE_HOST'] = 'replace_HOST' 
mysql.init_app(app)

users = {
    "replace_api_user_1": "replace_api_pass_1",
    "replace_api_pass_2": "replace_api_pass_2"
}

ALLOWED_IPS = ['replace_IP1','replace_IP2']
@app.before_request
def limit_remote_addr():
    client_ip = str(request.remote_addr)
    valid = False
    for ip in ALLOWED_IPS:
        if client_ip.startswith(ip) or client_ip == ip:
            valid = True
            break
    if not valid:
        abort(403)

@app.errorhandler(403)
def forbidden(error):
    return make_response(jsonify({'error 403': 'Access Forbidden'}), 403)

@auth.get_password
def get_pw(username):
    if username in users:
        return users.get(username)
    return None

@auth.error_handler
def unauthorized():
    return make_response(jsonify({'error 401':'Unauthorized Access'}), 401)

@app.route('/api/v1/replace_path_1', methods=['GET'])
@auth.login_required
def get_result_recent():
    conn = mysql.connect()
    cursor = conn.cursor()
    sql_action_1 = "replace_mysql_query_1"
    cursor.execute(sql_action_1)
    result = cursor.fetchall()
    fields = cursor.description
    cursor.close()
    conn.close()
    res = format_data(fields, result)
    return jsonify({'pool_recent': res})

@app.route('/api/v1/replace_path_2', methods=['GET'])
@auth.login_required
def get_result_act():
    conn = mysql.connect()
    cursor = conn.cursor()
    sql_action_2 = "replace_mysql_query_2"
    cursor.execute(sql_action_2)
    result = cursor.fetchall()
    fields = cursor.description
    cursor.close()
    conn.close()
    res = format_data(fields, result)
    return jsonify({'pool_act': res})

# Data format: fields, result
def format_data(fields, result):
    field = []   # Field Array ['id', 'name', 'password']
    for i in fields:
        field.append(i[0])    
    res = []   # Returned array collection [{'id': 1, 'name': 'admin', 'password': '123456'}]
    for iter in result:
        line_data = {
    }
        for index in range(0, len(field)):
            line_data[field[index]] = iter[index]
        res.append(line_data)
    return res

@app.errorhandler(404)
@auth.login_required
def not_found(error):
    return make_response(jsonify({'error 404': 'Not Found'}), 404)

@app.errorhandler(500)
def forbidden(error):
    return make_response(jsonify({'error 500': 'Internal Server Error'}), 500)

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=9909, ssl_context=('replace_path_fullchain.cer', 'replace_path_key'))

cursor.close()
conn.close()
