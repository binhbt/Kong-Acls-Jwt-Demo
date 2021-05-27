BASE_URL=http://localhost
# Register auth service API
curl -i -X POST \
  --url $BASE_URL:8001/services/ \
  --data 'name=api-service' \
  --data 'host=api'\
  --data 'path=/api'\
  --data 'port=5000'

curl -i -X POST \
  --url $BASE_URL:8001/services/api-service/routes \
  --data 'paths[]=/public'\
  --data 'name=public-route'\
  --data 'strip_path=true'

curl -i -X POST \
  --url $BASE_URL:8001/services/api-service/routes \
  --data 'paths[]=/user'\
  --data 'name=user-route'\
  --data 'strip_path=true'

curl -i -X POST \
  --url $BASE_URL:8001/services/api-service/routes \
  --data 'paths[]=/provider'\
  --data 'name=provider-route'\
  --data 'strip_path=true'
curl -i -X POST \
  --url $BASE_URL:8001/services/api-service/routes \
  --data 'paths[]=/admin'\
  --data 'name=admin-route'\
  --data 'strip_path=true'

# curl http://localhost:8000/user/homepage
# curl http://localhost:8000/provider/homepage
# curl http://localhost:8000/admin/homepage



#Create consumer
curl -d "username=admin1&custom_id=admin1_id" $BASE_URL:8001/consumers/
curl -X POST $BASE_URL:8001/consumers/admin1/acls \
    --data "group=admins"

curl -d "username=user1&custom_id=user1_id" $BASE_URL:8001/consumers/
curl -X POST $BASE_URL:8001/consumers/user1/acls \
    --data "group=users"

curl -d "username=provider1&custom_id=provider1_id" $BASE_URL:8001/consumers/
curl -X POST $BASE_URL:8001/consumers/provider1/acls \
    --data "group=providers"

#Enable jwt
curl -X POST $BASE_URL:8001/consumers/admin1/jwt -H "Content-Type: application/x-www-form-urlencoded"\
    --data "key=BVq0a5RtXgVRhpm7Jxkx44OTMXMOoRP0"\
    --data "secret=wSstEwZ6BFb6vLKkafnRmhufoOchhqe9"
curl -X POST $BASE_URL:8001/consumers/user1/jwt -H "Content-Type: application/x-www-form-urlencoded"\
    --data "key=UYE4DtRFE3RVfVCz5KfNcfA4fSk5UrS3"\
    --data "secret=M8Yy3qLRwIKIuxC7Busyipn5Oh6VAMqY"
curl -X POST $BASE_URL:8001/consumers/provider1/jwt -H "Content-Type: application/x-www-form-urlencoded"\
    --data "key=MZTW8Efs4MvPeuMoHgKK5rkOi9e5v5P9"\
    --data "secret=jiMw0TW3HgOK9um7Vp8ySlgtQfMfiGCy"
#-------GLOBAL PLUGIN-----------------------
curl -X POST $BASE_URL:8001/routes/plugins \
  --data "name=jwt-claims-headers" \
  --data "config.uri_param_names=jwt" \
  --data "config.claims_to_include=.*" \
  --data "config.continue_on_error=true"
#-----------User---------------------
#Enable jwt-header-claim
# curl -X POST $BASE_URL:8001/routes/user-route/plugins \
#   --data "name=jwt-claims-headers" \
#   --data "config.uri_param_names=jwt" \
#   --data "config.claims_to_include=.*" \
#   --data "config.continue_on_error=true"
#Enable CORS
curl -X POST $BASE_URL:8001/routes/user-route/plugins \
    --data "name=cors"  \
    --data "config.origins=*" \
    --data "config.methods=GET" \
    --data "config.methods=POST" \
    --data "config.methods=PUT" \
    --data "config.methods=PATCH" \
    --data "config.methods=DELETE" \
    --data "config.methods=OPTIONS" \
    --data "config.headers=Accept" \
    --data "config.headers=Accept-Version" \
    --data "config.headers=Cache-Control" \
    --data "config.headers=Content-Length" \
    --data "config.headers=Content-MD5" \
    --data "config.headers=Content-Type" \
    --data "config.headers=Date" \
    --data "config.headers=X-Auth-Token" \
    --data "config.exposed_headers=X-Auth-Token" \
    --data "config.headers=Authorization" \
    --data "config.credentials=true" \
    --data "config.max_age=3600"
#Add ACL for /user route
curl -X POST $BASE_URL:8001/routes/user-route/plugins \
    --data "name=acl"  \
    --data "config.whitelist=users" \
    --data "config.hide_groups_header=true"

#Enable jwt
curl -X POST $BASE_URL:8001/routes/user-route/plugins \
 --data "name=jwt"\
 --data "config.claims_to_verify=exp"

 #-------Provider-----------
#  #Enable jwt-header-claim
# curl -X POST $BASE_URL:8001/routes/provider-route/plugins \
#   --data "name=jwt-claims-headers" \
#   --data "config.uri_param_names=jwt" \
#   --data "config.claims_to_include=.*" \
#   --data "config.continue_on_error=true"
#Enable CORS
curl -X POST $BASE_URL:8001/routes/provider-route/plugins \
    --data "name=cors"  \
    --data "config.origins=*" \
    --data "config.methods=GET" \
    --data "config.methods=POST" \
    --data "config.methods=PUT" \
    --data "config.methods=PATCH" \
    --data "config.methods=DELETE" \
    --data "config.methods=OPTIONS" \
    --data "config.headers=Accept" \
    --data "config.headers=Accept-Version" \
    --data "config.headers=Cache-Control" \
    --data "config.headers=Content-Length" \
    --data "config.headers=Content-MD5" \
    --data "config.headers=Content-Type" \
    --data "config.headers=Date" \
    --data "config.headers=X-Auth-Token" \
    --data "config.exposed_headers=X-Auth-Token" \
    --data "config.headers=Authorization" \
    --data "config.credentials=true" \
    --data "config.max_age=3600"
#Add ACL for /user route
curl -X POST $BASE_URL:8001/routes/provider-route/plugins \
    --data "name=acl"  \
    --data "config.whitelist=providers" \
    --data "config.hide_groups_header=true"

#Enable jwt
curl -X POST $BASE_URL:8001/routes/provider-route/plugins \
 --data "name=jwt"\
 --data "config.claims_to_verify=exp"

 #-------------------Admin-------------
 #Enable jwt-header-claim
# curl -X POST $BASE_URL:8001/routes/admin-route/plugins \
#   --data "name=jwt-claims-headers" \
#   --data "config.uri_param_names=jwt" \
#   --data "config.claims_to_include=.*" \
#   --data "config.continue_on_error=true"
#Enable CORS
curl -X POST $BASE_URL:8001/routes/admin-route/plugins \
    --data "name=cors"  \
    --data "config.origins=*" \
    --data "config.methods=GET" \
    --data "config.methods=POST" \
    --data "config.methods=PUT" \
    --data "config.methods=PATCH" \
    --data "config.methods=DELETE" \
    --data "config.methods=OPTIONS" \
    --data "config.headers=Accept" \
    --data "config.headers=Accept-Version" \
    --data "config.headers=Cache-Control" \
    --data "config.headers=Content-Length" \
    --data "config.headers=Content-MD5" \
    --data "config.headers=Content-Type" \
    --data "config.headers=Date" \
    --data "config.headers=X-Auth-Token" \
    --data "config.exposed_headers=X-Auth-Token" \
    --data "config.headers=Authorization" \
    --data "config.credentials=true" \
    --data "config.max_age=3600"
#Add ACL for /user route
curl -X POST $BASE_URL:8001/routes/admin-route/plugins \
    --data "name=acl"  \
    --data "config.whitelist=admins" \
    --data "config.hide_groups_header=true"

#Enable jwt
curl -X POST $BASE_URL:8001/routes/admin-route/plugins \
 --data "name=jwt"\
 --data "config.claims_to_verify=exp"

 #-------------------Public-------------
 #Enable jwt-header-claim
# curl -X POST $BASE_URL:8001/routes/admin-route/plugins \
#   --data "name=jwt-claims-headers" \
#   --data "config.uri_param_names=jwt" \
#   --data "config.claims_to_include=.*" \
#   --data "config.continue_on_error=true"
#Enable CORS
curl -X POST $BASE_URL:8001/routes/public-route/plugins \
    --data "name=cors"  \
    --data "config.origins=*" \
    --data "config.methods=GET" \
    --data "config.methods=POST" \
    --data "config.methods=PUT" \
    --data "config.methods=PATCH" \
    --data "config.methods=DELETE" \
    --data "config.methods=OPTIONS" \
    --data "config.headers=Accept" \
    --data "config.headers=Accept-Version" \
    --data "config.headers=Cache-Control" \
    --data "config.headers=Content-Length" \
    --data "config.headers=Content-MD5" \
    --data "config.headers=Content-Type" \
    --data "config.headers=Date" \
    --data "config.headers=X-Auth-Token" \
    --data "config.exposed_headers=X-Auth-Token" \
    --data "config.headers=Authorization" \
    --data "config.credentials=true" \
    --data "config.max_age=3600"