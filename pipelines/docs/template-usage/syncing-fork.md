# Syncing the Fork

The template will continue to be improved over time, receiving new features and fixing bugs. To keep your fork updated with the template, you will need to pull the changes any time you want to sync.

## Requirements

- Any terminal (Bash/PowerShell/Shell/etc)
- A fork of the template repository
- [Git SSH key authentication](https://docs.microsoft.com/en-us/azure/devops/repos/git/use-ssh-keys-to-authenticate?view=azure-devops) - but feel free to change it to [other methods](https://docs.microsoft.com/en-us/azure/devops/repos/git/auth-overview?view=azure-devops)

## Setup

You need to clone the forked repository (for instance, `DMCadenaSuministro`):

```powershell
git clone git@ssh.dev.azure.com:v3/ecopetrolad/BI/DMCadenaSuministro
cd DMCadenaSuministro
```

The first time you want to sync changes from your machine, you will need to add the template remote:

```shell
git remote add template git@ssh.dev.azure.com:v3/ecopetrolad/BI/DMDataPlatformTemplate
```

## Syncing

1. Create a new `sync` branch from the `main` branch:

```shell
git checkout main
git pull
git checkout -b sync
```

> If the `sync` branch already exists, you can delete it using `git branch -D sync`

2. Fetch the changes from the `template`:

```shell
git fetch template
```

3. Merge the changes from the `main` branch of the `template`:

```shell
git merge template/main
```

4. On the forked repository, open a Pull Request from `sync` to `main` and follow the regular approval process. The sync will be finished once the merge happens.

> Do not use Squash Commit merge strategy.
