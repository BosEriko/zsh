# SteamOS (Distro)
This is my personal configuration for SteamOS. Feel free to use it or fork it.

## Sync the repository
To start you must first sync the home directory. Run the command below to do so.
```sh
curl -fsSL https://raw.githubusercontent.com/BosEriko/steam/HEAD/install.sh | sh
```

## Setup Environment Variables
Before running the installation script you first need to setup a few things. Run the command below to setup your environment variables.
```sh
cp ~/example.env.z.sh ~/env.z.sh && nano ~/env.z.sh
```

## Installation
After setting up the variables you can now restart your terminal to start installing.
```sh
source ~/.zshrc
```
