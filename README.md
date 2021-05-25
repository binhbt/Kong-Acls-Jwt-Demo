# Kong-JWT-ACL demo  

Use Kong gateway and acls + jwt plugin for Authorization  

## Usage  

    docker-compose up --build  


## Script setup service and route  
./script.sh  
### Test    
#Get TOKEN  
curl http://localhost:8000/public/jwt?role=user  
curl http://localhost:8000/public/jwt?role=provider  
curl http://localhost:8000/public/jwt?role=admin  

#Public route  
curl http://localhost:8000/public/public_test

#User route 
curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://localhost:8000/user/user_homepage -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MjIwMTYzMDgsImlhdCI6MTYyMTkyOTMwOCwic3ViIjoxMjMsImlzcyI6IlVZRTREdFJGRTNSVmZWQ3o1S2ZOY2ZBNGZTazVVclMzIiwicm9sZSI6InVzZXIifQ.1RknU7xslobj9ADntYFuPSHQRxBKOdC8kU4587o7VCI"

#Provider route  
curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://localhost:8000/user/provider_homepage -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MjIwMTY1NzIsImlhdCI6MTYyMTkyOTU3Miwic3ViIjoxMjMsImlzcyI6IlVZRTREdFJGRTNSVmZWQ3o1S2ZOY2ZBNGZTazVVclMzIiwicm9sZSI6InByb3ZpZGVyIn0.Z2-Xpr_GkYbF53F4CEJGP5MbndsTcBGJjppf-5KZ5Gg"

#Admin route  
curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://localhost:8000/user/admin_homepage -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE2MjIwMTY2MjQsImlhdCI6MTYyMTkyOTYyNCwic3ViIjoxMjMsImlzcyI6IlVZRTREdFJGRTNSVmZWQ3o1S2ZOY2ZBNGZTazVVclMzIiwicm9sZSI6ImFkbWluIn0.X09Ec9eUdJheqPnctxXRzjeTzRRPD_Uk1HiovdnkmpE"