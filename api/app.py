from flask import Flask
from flask import request

app = Flask(__name__)

import datetime
import jwt
def encode_auth_token(user_id, role='user'):
    iss = 'UYE4DtRFE3RVfVCz5KfNcfA4fSk5UrS3'
    secret = 'M8Yy3qLRwIKIuxC7Busyipn5Oh6VAMqY'
    if role == 'provider':
      iss = 'MZTW8Efs4MvPeuMoHgKK5rkOi9e5v5P9'
      secret = 'jiMw0TW3HgOK9um7Vp8ySlgtQfMfiGCy'
    if role == 'provider':
      iss = 'BVq0a5RtXgVRhpm7Jxkx44OTMXMOoRP0'
      secret = 'wSstEwZ6BFb6vLKkafnRmhufoOchhqe9'
    try:
        payload = {
            'exp': datetime.datetime.utcnow() + datetime.timedelta(days=1, seconds=600),
            'iat': datetime.datetime.utcnow(),
            'sub': user_id,
            'iss': iss,
            'role': role
        }
        return jwt.encode(
            payload,
            secret,
            algorithm='HS256'
        )
    except Exception as e:
        return e

def decode_auth_token(auth_token):
    try:
        payload = jwt.decode(auth_token, key)
        return payload['sub']
    except jwt.ExpiredSignatureError:
        return 'Signature expired. Please log in again.'
    except jwt.InvalidTokenError:
        return 'Invalid token. Please log in again.'
# eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MjE5MzQ3NTQsImlhdCI6MTYyMTg0Nzc1NCwic3ViIjoxMjMsImlzcyI6IlVZRTREdFJGRTNSVmZWQ3o1S2ZOY2ZBNGZTazVVclMzIiwicm9sZSI6InVzZXIifQ.nl4FSQ-BSb21sXrGpOZkNxJKMhcMOn__4EJdBEVPxec
@app.before_request
def before_request():
  print(request.headers)
        

@app.route('/api/jwt')
def jwt_test():
  role = request.args.get('role')
  jwt= encode_auth_token(123, role)
  return jwt

@app.route('/api/')
def hello_world():
  return 'User Hello from Docker within PyCharm!'

@app.route('/api/public_test')
def hello_public():
  return 'Hello guest from public!'

@app.route('/api/user_homepage')
def hello_user():
  return 'Hello User! You need logged in to access this page'
@app.route('/api/provider_homepage')
def hello_provider():
  return 'Hello Provider! You need logged in to access this page'

@app.route('/api/admin_homepage')
def hello_admin():
  return 'Hello Admin! You need logged in to access this page'

if __name__ == '__main__':
  app.run(host='0.0.0.0', port=5000)