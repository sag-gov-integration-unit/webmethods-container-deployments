# Docker Sample Deployments - webMethods Managed File Transfer

container-based deployment of webMethods Active Transfer solution, including:
 - Managed File Transfer Server (MFT Server)
 - Managed File Transfer Gateway (MFT Gateway)
 - My WebMethods Server (MWS)
 - Postgres DB

## Start the stack

NOTE: On first start, it's best to start the stack in controlled order so all the assets are created correctly
Since "docker compose" does not easily offer an easy way to start multiple components in a specific controlled order... let's perform several docker compose operations at first:

```
docker compose up -d postgres dbconfig
```

... wait for postgres healthy (docker ps | grep postgres) ...
NOTE: the container "dbconfig" is a job... it should have run, setup the tables needed in postgres, and terminated (it's expected)
If you want to check the status or logs for it, run:  
"docker ps -a | grep dbconfig", find the ID, and run "docker logs <dbconfig container id>"

Then:
```
docker compose up -d mws
```

... wait for healthy (docker ps | grep mws)
NOTE: this will take several minutes, depending on the resources assigned to your docker environment.

Then:
```
docker compose up -d mftgateway mftserver
```

On subsequent starts though, and provided the data volumes were not cleared/deleted, it's no problem to start it all in short:
```
docker compose up -d 
```

UIs:
- MFT Admin UI: http://localhost:9100/mft/
- MWS Admin UI: http://localhost:8585

## Configure the stack without the MFT Gateway

- Go to “listener“
- Verify the listener entry named “WebTransfer“ for instance “localhost“
- Name: WebTransfer
- Protocol: HTTP
- Port: 5566
- Activate listener: checked

The listener should show in the list of listener as “active“

The Web Transfer UI should then be accessible at http://localhost:5566

## Configure the stack with the MFT Gateway

### Adding MFT Gateway connectivity from MFT Server

- Login to MFT Admin UI  using Administrator user
- Go to “Gateways“ 
- Click “add“
- Name: MFTGW1
- Host: mftgateway
- Port: 8500
- Test MFTGW1 by clicking into it + make sure “Connect to ActiveTransfer Gateway“ is checked and status shows “Connection Successful“

### Initializing/Enabling the WebTransfer UI through the MFT Gateway

- Go to “listener“
- Disable and Delete the listener entry named “WebTransfer“ for instance “localhost“
- Select the instance “MFTGW1“ in the dropdown
- Click “add“
- Name: WebTransfer
- Protocol: HTTP
- Port: 5566
- Activate listener: checked

The listener should show in the list of listener as “active“

The Web Transfer UI should then be accessible at http://localhost:5666

Note: Port 5566 is already exposed by the MFT Server container, so the port 5666 is the one exposed on the MFT Gateway... (docker mapped to the internal 5566 we just setup)

## Destroy the stack + keep data

docker compose down

## Destroy the stack + destroy the data too

docker compose down -v
