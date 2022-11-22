# webmethods API Management in your Private Registry by Software AG Government Solutions 

This section mostly serves the purpose to create product images containing your valid SoftwareAG licenses, so that the deployments can be easier without needs for volumes mapping etc...

We will go over the general steps: 
  1) download existing Software AG webmethods API Management container images from official secure repo: ghcr.io/softwareag-government-solutions
  2) create new container images with respective licenses (if applicable)
  3) move them to you private registry of choice (AWS ECR, Azure Registry, or other repo of choice) to be used by the other tutorials

Here are all the images that will get processed/created here:

- webmethods-apigateway-standalone
- webmethods-apigateway
- webmethods-microgateway
- webmethods-apigateway-configurator
- webmethods-apigateway-deployer-sampleapis
- webmethods-apiportal (only for 10.5/10.7 releases)
- webmethods-devportal (only for 10.11 and above releases)
- webmethods-devportal-standalone (only for 10.11 and above releases)
- webmethods-devportal-configurator (only for 10.11 and above releases)
- webmethods-sample-apis-bookstore
- webmethods-sample-apis-uszip

## Pre-requisites 1

- Have access to Software Gov Solutions Github Registry at [ghcr.io/softwareag-government-solutions/](https://github.com/orgs/softwareag-government-solutions/packages)
- Have valid licenses (trial or full) for SoftwareAG products

If you need help, contact [Software AG Government Solutions](https://www.softwareaggov.com/) at [info@softwareaggov.com](mailto:info@softwareaggov.com) 

## Step 1: SoftwareAG Licenses

Make sure you save a valid licenses in "./licensing" directory with the expected file name (due to volume mapping / dockerfile copying):

 - ApiGateway Advanced
   - expected filename: "./licensing/apigateway-licenseKey.xml"
 - API Portal (*Optional: only needed for the deployments involving API Portal product*)
   - expected filename: "./licensing/apiportal-licenseKey.xml"
 - Terracotta (*Optional: only needed for the deployments involving API Gateway clustering*)
   - expected filename: "./licensing/terracotta-license.key"
 - Microgateway (*Optional: only needed for the deployments involving Microgateway product*)
   - expected filename: "./licensing/microgateway-licenseKey.xml"

## Step 2: Load webMethods Major Versions

The webMethods major versions flavors (wM 10.5, wM 10.7, etc...) are pre-defined in the ./configs folder, in files named "docker.env<version>"
To chose what version to load, you simply need to load the right environment file with your docker-compose command.

To help with that, you can set the following Environment variable, which will then be used in the docker-compose commands on this page:
If the variable is not defined, the commands will then automatically load the ./configs/docker.env file which is always set to the latest SAG RELEASE.

```bash
export SAG_RELEASE=1015
```

or

```bash
export SAG_RELEASE=1011
```

## Step 3: Login to Software Gov Solutions Github Registry 

Login to [ghcr.io/softwareag-government-solutions](https://github.com/orgs/softwareag-government-solutions/packages)

```
docker login ghcr.io/softwareag-government-solutions
```

If you need access to the registry, contact [Software AG Government Solutions](https://www.softwareaggov.com/) at [info@softwareaggov.com](mailto:info@softwareaggov.com)

### Step 4: Build the images with licenses

Build all the images:

```bash
/bin/sh ./build.sh "ghcr.io/softwareag-government-solutions" "<PRIVATE_REGISTRY>"
```

## Step 5: Push images to your Private Registry

 - [Pushing to AWS Elastic Container Registry (ECR)](./README-ECR.md)
 - [Pushing to Azure Container Registry](./README-AzureRegistry.md)

### Next steps

At this point, you should have all the images in AWS ECR, Azure, or other private registry of choice, and as such, you are now ready to deploy webmethods API Management stacks in your own environments.