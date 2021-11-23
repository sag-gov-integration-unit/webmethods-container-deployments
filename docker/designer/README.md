# Docker Sample Deployments - SoftwareAG webMethods Designer Workstation

Sample deployment of webMethods Designer Workstation using Docker / Docker-compose:

## Running the Designer Workstation container:

```bash
docker run -d -p 5900-5920:5900-5920 --name designer ghcr.io/softwareag-government-solutions/webmethods-designer-workstation:10.7.2
```

This will run a headless Ubuntu v20.04 desktop session.  Within the session, the VNC Server will run to provide remote access to the desktop.  When running the container, it will generate a random password for
the VNC connection and select a port (between 5900-5920).  First get the ContainerID using the following command:

```bash
docker ps
```

Then, use the ContainerID to display the logs which will contain the connection details:

```bash
docker logs {ContainerID}
```

Use the port and password to connect to the desktop with your VNC Viewer.

## About the Designer Workstation container:

The Designer Workstation container consists of the Designer Eclipse-based tool, an install of the Integration Server, along with some other programs (Firefox Browser, Git Plugins, etc).  Once you are connected to the container's desktop, you can Designer using the Start Menu -> Programming -> Designer Workstation.

While the Designer can connect to any running Integration Server to author assets, a built-in server is included within the container itself.  To start the built-in Integration Server, use Start Menu -> Programming -> Start Integration Server.  It will take a moment for the Integration Server to start.  You can monitor its bootstrap by examining the server;s log file:

```bash
tail -f /opt/softwareag/IntegrationServer/logs/server.log
```

You will know if the server is up and running when you see the phrase "Initialization completed in xx seconds." written in the log.