#!/usr/bin/env python
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

# => vms is a dictionary (basicaly json)
inv = {"_meta": {"hostvars":{}},
        "app":   {"hosts": []},
        "db":    {"hosts": []}
        }
vms = get_vms()
for vm in vms['instances']:
#        print(vm)
    if vm['labels']['tags'] == "reddit-app":
         inv['app']['hosts'].append(vm['networkInterfaces'][0]['primaryV4Address']['oneToOneNat']['address'])

    if vm['labels']['tags'] == "reddit-db":
         inv['db']['hosts'].append(vm['networkInterfaces'][0]['primaryV4Address']['oneToOneNat']['address'])

print(json.dumps(inv))

