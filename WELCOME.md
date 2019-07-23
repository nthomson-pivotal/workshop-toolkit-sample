# Sample Workshop

Welcome to the sample workshop. This file is opened by vscode when a student opens their workspace and can be used to provide any introductory instructions. It will be rendered in proper markdown.

This workspace has:
- Java 8 installed
- The Spring Music sample application cloned
- CF CLI logged in to your own dedicated space

First, open a terminal via the menu and check out the CF target you're logged in to:

```
cf target
```

Now lets deploy something, you can build the sample application by doing this:

```
cd spring-music
./gradlew assemble
```

Once the application is built you can deploy it to Cloud Foundry using the following command:

```
cf push
```

Congratulations, your application is now built and deployed to Cloud Foundry!
