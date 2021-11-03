# webmethods Container Deployments in Azure Container Instances (ACI) by Software AG Government Solutions 

Sample deployments to Azure ACI in the Government Cloud

## Pre-requisites

- Have an Azure Government Account setup fo ACI use.
- Have your own, private Azure Container Registry created.  Be sure to enable the admin user under "Access Keys".
- Have your Software AG API Gateway and API Portal license files handy.

If you need help, contact [Software AG Government Solutions](https://www.softwareaggov.com/) at [info@softwareaggov.com](mailto:info@softwareaggov.com) 

## Setup Steps

- Set the release level for the webMethods API Platform in an environment variable.

    `export SAG_RELEASE=107`

- Edit the environment variables in the REPO/azure_aci/configs/docker.env{SAG_RELEASE} file for your specific environment.
- Login to the Software AG Government Solutions container repository and pull the docker images into your environment.  See the docker_pull.sh script.
- Copy your license files to the directory that contains the scripts for the environment you want to generate (for example, "apigateway-and-portal").  Rename the API Portal file to apiportal-license.xml and rename the API Gateway file to apigw-license.xml
- Rebuild the API Portal and API Gateway images to incorporate your license files.  See Dockerfile.add-gw-license and Dockerfile.add-portal-license to use as an example.
- Tag your newly-built images for your Azure Container Registry along with the sample API containers and the Gateway Configurator.  You can identify each {IMAGE ID} by using the `docker image ls` command.

    `docker tag {IMAGE ID} {Your ACR REGISTRYLOGINSERVER}/webmethods-sample-apis-bookstore:dev-0.0.4`
    
    `docker tag {IMAGE ID} {Your ACR REGISTRYLOGINSERVER}/webmethods-sample-apis-uszip:dev-0.0.4`

    `docker tag {IMAGE ID} {Your ACR REGISTRYLOGINSERVER}/webmethods-apigateway-standalone:dev-10.7-latest`

    `docker tag {IMAGE ID} {Your ACR REGISTRYLOGINSERVER}/webmethods-apigateway-configurator:configurator-10.7-latest`

    `docker tag {IMAGE ID} {Your ACR REGISTRYLOGINSERVER}/webmethods-apiportal:dev-10.7.1-36`

- Push your newly tagged images into your private Azure Container Registry.  See the docker_push.sh script as an example.
- Run the deploy_all.sh script.  Once it completes, it will take about 5 minutes for all of the containers to start.
