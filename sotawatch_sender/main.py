from datetime import datetime
import time
import firebase_admin
from firebase_admin import credentials
from firebase_admin import messaging
import requests



def send_push_notification(message):
    response = messaging.send_multicast(message)

    print("Successfully sent notification:", response)
    
def get_last_h_spots():
    res = requests.get("https://api2.sota.org.uk/api/spots/-1/all")
    
    if res.status_code == 200:
        return res.json()
    else: return None

# Replace with the path to your service account key JSON file
server_key = 'serviceAccountKey.json'

# Replace with your device tokens
device_tokens = [
    'fzIlo93CS1iuGpKzqwHMAX:APA91bEhcWI_MgP_vgsjByVInDO0RxvM1XIwlQs9IFw73iGguDoPvjj7Xf1_hnPvQzYOjYLQdCtvpTGoSNdcBpXiUAc5vB1DLil25EJgzdL1SMw4bkNzZXEGNloolNFKFKZmWIwLWAiA',
]

cred = credentials.Certificate(server_key)
firebase_admin.initialize_app(cred)

last_time_reported = None
while True:
    # Notifications
    for i in get_last_h_spots():
        t = datetime.strptime(i["timeStamp"].split(".")[0], "%Y-%m-%dT%H:%M:%S")
        if last_time_reported == None or max(t, last_time_reported) == last_time_reported:
            last_time_reported = t
            send_push_notification(messaging.MulticastMessage(
                data={
                    "callsign": i["callsign"],
                    "summit": i["summitCode"],
                    "association": i["associationCode"],
                    "frequency": i["frequency"]
                },
                tokens=device_tokens
            ))

            
    time.sleep(120)
