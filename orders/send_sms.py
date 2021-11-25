import os
from twilio.rest import Client


# Find your Account SID and Auth Token at twilio.com/console
# and set the environment variables. See http://twil.io/secure
def send_sms(user,mobile,orderID,paid,pending):

    account_sid = "ACa4220a71ba87652275dc696cba0adfcf"
    auth_token = "ef4ae5f4891a5762bcc67619ba451a69"
    client = Client(account_sid, auth_token)

    message = client.messages \
                    .create(
                        body="Congratulations..."+user+",SHAZAM.com has just confirmed your bookings with payment of ₹"+paid+".Your order Number is "+orderID+ ",Our comapny excicutives will contact you soon for offline verification" ,
                        from_='+14439798152',
                        provide_feedback=True,
                        to='+91'+mobile
                    )

    print("Message sent to +91"+mobile+" successfully")