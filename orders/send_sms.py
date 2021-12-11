import os
from twilio.rest import Client
from django.conf import settings

# Find your Account SID and Auth Token at twilio.com/console
# and set the environment variables. See http://twil.io/secure
def send_sms(user,mobile,orderID,paid,pending):

    account_sid = settings.TWILIO_ACCOUNT_SID
    auth_token =settings.TWILIO_AUTH_TOKEN
    client = Client(account_sid, auth_token)

    message = client.messages \
                    .create(
                        body="Congratulations..."+user+",shazam.com has just confirmed your bookings with payment of ₹"+paid+".Your order Number is "+orderID+ ",Our comapny excicutives will contact you soon for offline verification" ,
                        from_='+13093286606',
                        provide_feedback=True,
                        to='+91'+mobile
                    )

    print("Message sent to +91"+mobile+" successfully")