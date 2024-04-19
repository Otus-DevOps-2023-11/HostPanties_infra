# check in MongoDB is enabled & running
def test_mongo_running_and_enabled(host):
    mongo = host.service("mongodb")
    assert mongo.is_running
    assert mongo.is_enabled

# check if config contains required line
def test_config_file(host):
    conf = host.file('/etc/mongodb.conf')
    assert conf.contains('bindIp: 0.0.0.0')
    assert conf.is_file

def test_mongo_port_available(host):
    db_port = host.socket('tcp://0.0.0.0:27017')
    assert db_port.is_listening

