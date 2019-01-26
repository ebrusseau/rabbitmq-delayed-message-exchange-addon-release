# CloudFoundry RabbitMQ Delayed Message Exchange BOSH Addon Release

This repository contains a BOSH addon release that will add and configure the rabbitmq_delayed_message_exchange plugin.

# Preparing the Release

Binary blobs for the plugins must be downloaded and added to the release before creating it. The included **scripts/download-latest-blobs** will download the releases and add the blobs to the local blob folder.

Once this is complete, the release will need to be created using:

```
$ bosh create-release --final --tarball=rabbitmq-delayed-message-exchange-addon.tgz
```

## Deploying the Release

In order to deploy the release from this repository, simply issue the following BOSH command:
```
$ bosh -e <your environment> upload-release
```

## Configuring BOSH

To apply the addon, a runtime config entry must be created that will instruct BOSH to apply the addon to instances created by the cf-rabbitmq deployment. The file **runtime-config.yml** has been included and should work most installations, however take note that the version number may not match the version number of your newly created release. To set this runtime config using this file, issue the following BOSH command:

```
$ bosh -e <your environment> update-runtime-config --name=rabbitmq-delayed-message-exchange-addon runtime-config.yml
```
