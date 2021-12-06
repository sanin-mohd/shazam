import os
from twilio.rest import Client
from django.conf import settings

# Find your Account SID and Auth Token at twilio.com/console
# and set the environment variables. See http://twil.io/secure
def check_code(mobile,entered_code):

    account_sid = settings.TWILIO_ACCOUNT_SID
    auth_token =settings.TWILIO_AUTH_TOKEN
    client = Client(account_sid, auth_token)

    verification_check = client.verify \
                            .services(settings.VERIFICATION_SID) \
                            .verification_checks \
                            .create(to='+91'+mobile, code=entered_code)

    print(verification_check.status)
    if(verification_check.status=="approved"):
        print("OTP verified")
        return True
    else:
        return False
