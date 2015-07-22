# `pgp.asc`

## Table of Contents

- [`pgp.asc`](#pgpasc)
  - [What is pgp.asc?](#what-is-pgpasc)
  - [Example](#example)
  - [Why should I?](#why-should-i)
  - [Goals?](#goals)
  - [How can I help?](#how-can-i-help)
    - [Getting up and running](#getting-up-and-running)
    - [Project Structure](#project-structure)
    - [Target groups](#target-groups)
  - [FAQ](#faq)
    - [Why not use key servers, keybase, the blockchain, DNS,...?](#why-not-use-key-servers-keybase-the-blockchain-dns)
    - [How is this decentralized?](#how-is-this-decentralized)
    - [Why should my website serve `pgp.asc` with HTTPS?](#why-should-my-website-serve-pgpasc-with-https)

## What is pgp.asc?

pgp.asc is an initiative to decentralize public PGP keys, making it easier to get an up to date and authenticated key.

Sounds complicated? It isn’t: Just upload your public PGP key to your websites root folder in a `pgp.asc` file and you’re good to go!

## Example

Make your public PGP key (please, please only your public key) available at:

	https://yoururl.com/pgp.asc

Note that HTTPS is used here. This is [important](#why-should-my-website-serve-pgpasc-with-https).

You can even go further and add a meta tag in your `<head>` to make the file even more discoverable:

	<link href="https://yoururl.com/pgp.asc" rel="pgpkey" type="text/plain">

or

	<link href="https://yoururl.com/pgp.asc" rel="publickey" type="text/plain">

(see `rel="publickey"` and `rel="pgpkey"` [Specification](https://xato.net/cryptography/rel-publickey-rel-pgpkey/#.VKe984HGKrU) for more details)

## Why should I?

To make it easier to find your public PGP key, and immediately validate it. (Since only you have access to your server) 
To provide an up to date key, as you can delete your old one. 
To spread the word about encryption.

## Goals?

Right now, the primary goals are to get the website up and running and to work out some details. Then to spread the word and get some adoption.

## How can I help?

First of all, awesome that you want to help!

We basically need help with everything, ranging from Front-End and Design over Back-end to Copywriting. Take a look at the issues and submit new ones if you have an idea or found a bug!

### Getting up and running

This assumes you have Ruby, Rails and all the needed utilities installed and a PostgreSQL instance running. If you get any errors during this setup, please refer to your search engine for help! If you still cannot figure it out, contact me on [twitter](http://twitter.com/mxstbr).

- Clone the repo to your local machine using `git clone git@github.com:mstoiber/pgp.asc.git`.

- Open the terminal and change into the pgp.asc folder.

- Run `bundle install`.

- Run `bower install`.

- Open another instance/tab of the terminal and run `mailcatcher`.

- Run `rake db:create`, followed by `rake db:migrate`.

- Run `rails server`, and go to `http://localhost:3000` to see the site! If you send an email through the form, you can find it at `http://127.0.0.1:1080/`. (This is mailcatcher, as the name suggests it "catches" the mails)

### Project Structure

If you want to edit the frontend, ignore everything except the `app` folder. In there you should focus on the `assets` (Stylesheets, Scripts and Images) and the `views/persons` folder. (The actual HTML files you see)

For the backend, all the important logic is in the Persons Controller (`app/controllers/persons_controller.rb`) and the Person Model. (`app/models/person.rb`)

If you are looking for something but can't find it, contact me on [twitter](http://twitter.com/mxstbr).

### Target groups

1) People who know and use PGP

We should cover those with the main parts of the website, as they already understand all the lingo involved and know what is going on.

2) People who have heard and maybe even tried using PGP, but are not using it regularly

I have no idea what to do with them. Ideas?

3) People who have no idea WTF is going on

We can use the website to spread the word about E-Mail encryption and maybe later about other privacy related issues. What about a prominent link on the homepage á la "I have no idea WTF is going on" linking to a basic guide to PGP. (E.g. http://curtiswallen.com/pgp)

## FAQ

### Why not use key servers, keybase, the blockchain, DNS,...?

We are not preaching against keyservers and services like keybase. You can (and should) still use those. pgp.asc should be seen as an add-on to the currently available options, and my (mstoiber) personal goal is that we someday have mailto: links with somekind of attribute, and I don't even have to search for your key anymore when I click on your link.

We want to have a section devoted to more elaborate techniques to protect yourself, the surrounding elements of PGP, e.g. MITM attacks, open networks in general, pre-used PCs, etc. (Stuff that Curtis Wallens brilliant [guide to PGP](http://curtiswallen.com/pgp) touches on.) There will hopefully also be a section devoted to different, more elaborate, methods of distributing your key (or the location of your key), e.g. namecoin, [DNS](http://www.gushi.org/make-dns-cert/HOWTO.html), etc.

### How is this decentralized?

> de·cen·tral·ize

> To undergo redistribution or dispersal away from a central location or authority.

[Source](http://www.thefreedictionary.com/decentralized)

In this case the central location(s) would be the key servers, so this is decentralized, everybody hosting their own key.

### Why should my website serve `pgp.asc` with HTTPS?

To protect against [man-in-the-middle attacks](http://en.wikipedia.org/wiki/Man-in-the-middle_attack). A malicious user intercepting an incoming HTTP request for your key could instead serve a key of their own. It's good general practice to validate a user's PGP fingerprint out-of-band to ensure that the key you have for them is authentic.