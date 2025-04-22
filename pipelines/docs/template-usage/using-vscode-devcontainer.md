# Using Visual Studio Code (VS Code) Dev Container

Running VS Code inside a Docker container can be useful for many reasons, but in this walkthrough we'll focus on using a Docker container to set up a development environment that is isolated from your local environment.

VS Code documentation [Remote development in Containers](https://code.visualstudio.com/docs/remote/containers-tutorial)

## Requirements

- Visual Studio Code
- Having a docker environment
  - Windows: <https://docs.docker.com/docker-for-windows/install/>
  - Linux: <https://docs.docker.com/engine/install/#server>
  - MacOS: <https://docs.docker.com/docker-for-mac/install/>

## Procedures

1. Open the project folder in Visual Studio Code

2. VS Code will check if the required extension [ms-vscode-remote.remote-containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) is installed, accepts the installation if it doesn't.

3. Another notification will appear asking to reopen the project using the Dev Container, click on "Reopen in Container"

    ![Dev Container Notification](./images/vscode-dev-container-notification.png)

4. If you missed the notification, use the command palette `<CTRL + SHIFT + P>` and type "remote container" and choose "Rebuild Container"

## Be patient

The very first time that the docker images is going to be build takes some time, so bear with it!
