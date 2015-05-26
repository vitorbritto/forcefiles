# Force Files

More than dotfiles! It's my Force Files! xD


## About

I was a little tired of typing so many lengthy commands in bash and organize an initial structure for my projects everytime I was logged in at Shell. Everything was a mess, a real waste of time! Thus I decided to build this repository.

I realized I could split my dotfiles, automation tasks, bash aliases and functions, editor settings and a lot of things up into the main areas I used to work in my Workflow.

Now, I can check, pick up something or run this guy for my recently fresh system. :ghost:

> Notice: I am running on Mac OSX Yosemite. These are my config files to set up a system the way I use it in my workflow.


## Installation

```bash
$ bash -c "$(curl -fsSL raw.github.com/vitorbritto/forcefiles/master/bin/forcefiles)"
```


## Usage

**Options**

- `./forcefiles --help`: Show Help and Instructions
- `./forcefiles --list`: List all applications and dependencies that will be installed

**Scripts**

There are some optional scritps i've stored in `scripts` folder to use in my workflow. They can be executed with the `alias` listed below.

- `vms`: download and install virtual machines for use with Virtual Box and Vagrant.
- `mkhost`, `rmhost`: add or remove virtual hosts.
- `yoda`: script to favorite links.
- `mify`: a front-end development tool for extract classes, ids and hrefs from HTML document.
- `bkp`: script to backup importante files.
- `nexus`: start a web server in _python_ or _php_
- `call`: clone user or organization repositories.
- `ipost`: create a basic templates for posts on Jekyll
- `uify`: general utilities that I use in my work routine
- `timer`: a simple time tracking
- `reminder`: a simple reminder for daily tasks
- `updatedb`: refresh and update the `locate` database


## Acknowledgements

* [@necolas](https://github.com/necolas) (Nicolas Gallagher)
  [https://github.com/necolas/dotfiles](https://github.com/necolas/dotfiles)
* [@mathiasbynens](https://github.com/mathiasbynens) (Mathias Bynens)
  [https://github.com/mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
* [@cowboy](https://github.com/cowboy) (Ben Alman)
  [https://github.com/cowboy/dotfiles](https://github.com/cowboy/dotfiles)

> May the FORCE FILES be with you! :)


## License

[MIT License](http://vitorbritto.mit-license.org/) © Vitor Britto

