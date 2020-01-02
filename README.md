# teamspeak-server
This is a hacked together repo to build and teardown a Teamspeak server on demand.

The reason I made this was because the common voice chat applications that gamers use, Discord, Steam, and Battle.net, are memory hungry, laggy, and generally have annoying UIs. Teamspeak is dead simple and I have never had a problem with it being slow or confusing for any user to set up.

However, I don't want to run teamspeak on my own computer, and paying for a hosted server seems like a waste of money. So, with this repo, I can create a teamspeak server on the cheap, for only as long as I need it.

In a nutshell this repo is used to:

1. Create an EC2 instance in AWS
2. Install teamspeak on said instance
3. Return the privileged token to the creator
4. Tear down the teamspeak server when done

This software is provided "as is", without warranty of any kind... blah blah blah. This is something I hacked together in about an hour, please don't think that it is a properly engineered solution for anything at all really.

## Getting started
### Pre-requisites

1. You need a Linux machine with Ansible, Python3, and Terraform installed. Ensure that you have valid AWS credentials in $HOME/.aws/credentials for Terraform

### Building
1. Run ./build.sh
2. Retrieve the token from the debug Task when the script is done. (A gotcha is that sometimes the output has a \n at the end of it. Just don't copy past that bit.)
3. Connect to your new Teamspeak server.

## Deleting after you are done
1. Run ./teardown.sh
