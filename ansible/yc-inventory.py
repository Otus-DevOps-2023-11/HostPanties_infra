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
dbs = []
for vm in vms['instances']:
#        print(vm)
    if vm['labels']['tags'] == "reddit-app":
        app = vm['networkInterfaces'][0]['primaryV4Address']['oneToOneNat']['address']
        inv['app']['hosts'].append(app)
    if vm['labels']['tags'] == "reddit-db":
        db = vm['networkInterfaces'][0]['primaryV4Address']['oneToOneNat']['address']
        inv['db']['hosts'].append(db)
        dbs.append(vm['networkInterfaces'][0]['primaryV4Address']['address'])

inv['app']['vars'] = {'dbs': dbs}
print(json.dumps(inv))

