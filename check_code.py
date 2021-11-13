import os
from twilio.rest import Client


# Find your Account SID and Auth Token at twilio.com/console
# and set the environment variables. See http://twil.io/secure
def check_code(mobile,entered_code):

    account_sid = "ACa4220a71ba87652275dc696cba0adfcf"
    auth_token = "baee61d4c4223a4a76ffaad1e3ebed01"
    client = Client(account_sid, auth_token)

    verification_check = client.verify \
                            .services('VA26ec3dd3979faf82183100a7cb9e7efa') \
                            .verification_checks \
                            .create(to='+91'+mobile, code=entered_code)

    print(verification_check.status)
    if(verification_check.status=="approved"):
        print("OTP verified")
        return True
    else:
        return False
