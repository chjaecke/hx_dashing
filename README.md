HX Dashing
===========

#### This projects implements a dashboard to display general information of a [Cisco HyperFlex](https://www.cisco.com/c/en/us/products/hyperconverged-infrastructure/index.html) cluster. Dashboard information includes cluster name, health and datastore information. The dashboard is based on the [dashing.io](http://dashing.io) framework. Installation is quite easy by deploying the dashboard as a Docker container. Additional HyperFlex information can be added to the dashboard by extending the dashing.io framework.

## Table of Contents
  
  * [Installation](#installation)
  * [Getting Started](#getting-started)
    * [Get the HyperFlex Auth Token](#get-the-hyperflex-auth-token)
    * [Start the Container](#start-the-container)
  * [Developer Information](#developer-information)
  * [Contributing](#contributing)
  * [Changelog](#changelog)

# Getting Started
HX Dashing is deployed as a Docker container. You can either pull the container image from Docker or you can build it from scratch using the source code at Github.

Option 1: Pull the most recent image from Docker Hub: 
`docker pull chjaecke/hx-dashing`

Option 2: Download the source code from Github, change Docker to the downloaded folder and build the image from scratch:
`docker build -t hx-dashing .`

HX Dashing requires 4 parameters to start the dashboard:
* HyperFlex URL
* HyperFlex API Auth Token
* Dashboard IP (default: 0.0.0.0)
* Dashboard Port (default: 3030)

Those parameters are passed to the Docker container through an env-file. The env-file contains environment variables with HyperFlex and Dashboard parameters. The Github repository contains an example file `env_example.list`. The file has the following parameters:

`HX_URL=https://192.168.0.1`
`HX_TOKEN=Bearer ABCXYZ`
`DASHING_IP=0.0.0.0`
`DASHING_PORT=3030`

The Dashing IP and Port are **optional** and should only be changed if you want to host the dashboard on a specific IP withing the container.

## Get the HyperFlex Auth Token
Before starting the dashboard container, you need to request an authorization token through the HyperFlex Rest API. There are various ways to get this token. It is important that you include the **Bearer** prefix in the env-file for the token parameter!

1. **curl**
Send a curl request to the HyperFlex Rest API to get the token. Replace the parameters HX_USER, HX_PASSWORD and HX_IP with your HyperFlex credentials.

    ```
    curl -k --header "Content-Type: application/json" \
      --request POST \
      --data '{"username": <<HX_USER>>, "password": <<HX_PASSWORD>>, "client_id": "HxGuiClient", "client_secret": "Sunnyvale", "redirect_uri": "http://localhost:8080/aaa/redirect"}' \
      https://<<HX_IP>>/aaa/v1/auth?grant_type=password
    ```
    //TODO Explain response

2. **HyperFlex API Explorer**

    1. Go to the HyperFlex API Explorer at: `https://10.1.1.14/apiexplorer/`
    2. Login with root credentials
    3. Go to *Authentication Authorization and Accounting APIs*
    4. Click on *Expand Operations* besides Obtain Access Token
    5. In the body, build the request body with the following JSON information and replace the HX_USER and HX_PW with your login credentials:
         ```
        {
        "username": "<<HX_USER>>",
        "password": "<<HX_PW>>",
        "client_id": "HxGuiClient",
        "client_secret": "Sunnyvale",
        "redirect_uri": "http://localhost:8080/aaa/redirect"
        }
        ```
    6. Click *Try it out*
    7. Inspect the response body to get the authorization token.
    
3. **Postman**
If you are familiar with Postman, you can also request the authorization token through a Rest API call against the HyperFlex API.

## Start the Container
By now, you have filled up the env-file with your HyperFlex and Dashboard parameters. Change the directory on your Docker host where the env-file is stored.
Start the container with the following parameter:
`docker run -ti -p 3030:3030 --name myHyperFlexDashboard chjaecke/hx-dashing`

The dashboard should now be accessible at `localhost:3030/hx`.

# Developer Information
HX Dashing can easily be extended or modified since the dashboard is based on the popular dashing.io framework. You can add additional dashboard information in the dashboard/hx.erb file and fill it with data by creating new jobs. The helper class hx_helper.rb provides a ruby method to easily make API request towards the HyperFlex Rest API.

# Contributing
All users are strongly encouraged to contribute patches, new scripts or ideas.
Please submit a pull request with your contribution and we will review, provide
feedback to you and if everything looks good, we'll merge it!

# Changelog
## v0.1 (2018-08-09)
Initial release
