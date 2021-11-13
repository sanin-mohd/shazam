import os
from twilio.rest import Client


# Find your Account SID and Auth Token at twilio.com/console
# and set the environment variables. See http://twil.io/secure
def send_code(mobile):

    account_sid = "ACa4220a71ba87652275dc696cba0adfcf"
    auth_token ="baee61d4c4223a4a76ffaad1e3ebed01"
    client = Client(account_sid, auth_token)

    verification = client.verify \
                        .services('VA26ec3dd3979faf82183100a7cb9e7efa') \
                        .verifications \
                        .create(to='+91'+mobile, channel='sms')

    print(verification.status)