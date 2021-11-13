import os
from twilio.rest import Client


# Find your Account SID and Auth Token at twilio.com/console
# and set the environment variables. See http://twil.io/secure
def verify_sms(mobile,message):

    account_sid = "ACa4220a71ba87652275dc696cba0adfcf"
    auth_token = "baee61d4c4223a4a76ffaad1e3ebed01"
    client = Client(account_sid, auth_token)

    message = client.messages \
                    .create(
                        body="Your verification is completed.. You can now list EVs in shazam.com",
                        from_='+14439798152',
                        to='+918301868891'
                    )

    print("Message sent successfully")