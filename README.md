# vagrant-adam

[![Build Status](https://travis-ci.org/petems/vagrant-adam.svg?branch=master)](https://travis-ci.org/petems/vagrant-adam)
[![Coverage Status](https://img.shields.io/coveralls/petems/vagrant-adam.svg)](https://coveralls.io/r/petems/vagrant-adam?branch=master)
[![Code Climate](https://codeclimate.com/github/petems/vagrant-adam/badges/gpa.svg)](https://codeclimate.com/github/petems/vagrant-adam)

A Vagrant plugin that ensures a given script is run before anything else on a Vagrant environment. This is useful if you want to fix issues around requiretty in sudoers, or doing a one-off fix for a Vagrant bo.

The plugin should work correctly with all providers, but right now the acceptance tests are only setup for Virtualbox. However, from my quick tests it works with the following [Vagrant providers](http://docs.vagrantup.com/v2/providers/index.html):

* VirtualBox (part of core)
* AWS (ships in [vagrant-aws](https://github.com/mitchellh/vagrant-aws) plugin)
* Rackspace (ships in [vagrant-rackspace](https://github.com/mitchellh/vagrant-rackspace)
  plugin)
* VMWare Fusion (can be [purchased from Hashicorp](http://www.vagrantup.com/vmware))
* LXC (ships in [vagrant-lxc](https://github.com/fgrehm/vagrant-lxc))
* OpenStack (ships in [vagrant-openstack-plugin](https://github.com/cloudbau/vagrant-openstack-plugin))
* Digital Ocean (ships in [vagrant-digitalocean](https://github.com/smdahlen/vagrant-digitalocean))
* Parallels Desktop (ships in [vagrant-parallels](https://github.com/yshahin/vagrant-parallels))

## Installation

Ensure you have downloaded and installed Vagrant 1.1 or newer from the
[Vagrant downloads page](http://downloads.vagrantup.com/).

Installation is performed in the prescribed manner for Vagrant 1.1 plugins.

```
$ vagrant plugin install vagrant-adam
```

## Usage

The Vagrant Adam plugin automatically hooks into the Vagrant provisioning
middleware, and it's setup to always run before the `Vagrant::Action::Builtin::SyncedFolders` process (I believe it's unique in this fact!)

To run a particular script, you specify the path or URL of the script you want to run

### Path on host machine
```ruby
Vagrant.configure("2") do |config|

  config.adam.provision_url = '/tmp/cool_script.sh'

  ...

end
```

### Url of script
```ruby
Vagrant.configure("2") do |config|

  config.adam.provision_url = 'https://gist.githubusercontent.com/petems/367f8119bbff011bf83e/raw/29efc24e8a0db3ce2e0452f1c23d2119146ed583/remove_requiretty.sh'

  ...

end
```

## Contributing and Tests


## Getting Help

* If you have an issue: report it on the [issue tracker](https://github.com/petems/vagrant-adam/issues)

# Authors

- Peter Souter

Thank you to all of our [Contributors](https://github.com/petems/vagrant-adam/graphs/contributors), testers, and users.

If you'd like to contribute, please see our [contribution guidelines](https://github.com/petems/vagrant-adam/blob/master/CONTRIBUTING.md) first.