import json
import requests
from get_token import get_token
def get_vms():
    session = requests.Session()
    token = get_token()
    vms = session.get("https://compute.api.cloud.yandex.net/compute/v1/instances",
                      headers={"Authorization": "Bearer " + token}, 
                      params={'folderId': 'b1gu9td5uk8ohab1ecp8'}
                      )
    return json.loads(vms.text)

print(get_vms())
