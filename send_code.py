import os
from twilio.rest import Client


# Find your Account SID and Auth Token at twilio.com/console
# and set the environment variables. See http://twil.io/secure
def send_code(mobile):

    account_sid = "ACa4220a71ba87652275dc696cba0adfcf"
    auth_token ="ef4ae5f4891a5762bcc67619ba451a69"
    client = Client(account_sid, auth_token)

    verification = client.verify \
                        .services('VA757e9b70b41b455a6255601201c38ac8') \
                        .verifications \
                        .create(to='+91'+mobile, channel='sms')

    print(verification.status)
