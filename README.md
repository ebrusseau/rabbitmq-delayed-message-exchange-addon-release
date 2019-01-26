# CloudFoundry RabbitMQ Delayed Message Exchange BOSH Addon Release

This repository contains a BOSH addon release that will add and configure the rabbitmq_delayed_message_exchange plugin. It is not meant to be deployed directly, as there are preparatory steps and plugin binaries that must be downloaded before deployment.

## Preparing the Release

Binary blobs for the plugins must be downloaded and added to the release before creating it. The included **scripts/download-latest-blobs** will download the releases and add the blobs to the local blob folder.

Once this is complete, the release will need to be created using:

```
$ bosh create-release --final --force --tarball=rabbitmq-delayed-message-exchange-addon.tgz
```

## Deploying the Release

In order to deploy the release from this repository, simply issue the following BOSH command:
```
$ bosh -e <your environment> upload-release rabbitmq-delayed-message-exchange-addon.tgz
```

## Configuring BOSH

To apply the addon, a runtime config entry must be created that will instruct BOSH to apply the addon to instances created by the cf-rabbitmq deployment. See the file **runtime-config-example.yml** for how this file should look.

Note that you will need to change the version number to the appropriate version of the BOSH release you have created above.

Finally, you will set the BOSH runtime config using the file you created:

```
$ bosh -e <your environment> update-runtime-config --name=rabbitmq-delayed-message-exchange-addon runtime-config.yml
```

## Using the Included Scripts to Automate Deployment

Using the included script in a CD pipeline or other automation tool, you can generate and deploy a unique version by running the following script (as an example) and refreshing your RabbitMQ deployment(s):

```
#!/bin/bash

VERSION=$(date +"%Y%m%d%H%M")
RELEASE_DIR=../release
RELEASE_FILE=rabbit-delayed-message-exchange-addon.tgz

scripts/download-latest-blobs
scripts/generate-runtime-config $VERSION $RELEASE_DIR/runtime-config.yml
scriots/create-release $VERSION $RELEASE_DIR/$RELEASE_FILE

bosh -e <environment> upload-release $RELEASE_DIR/$RELEASE_FILE
bosh -e <environment> update-runtime-config --name=rabbit-delayed-message-exchange-addon $VERSION $RELEASE_DIR/runtime-config.yml
```


`
