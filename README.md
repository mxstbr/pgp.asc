# `pgp.asc`

## What is pgp.asc?

pgp.asc is an initiative to decentralize public PGP keys, making it easier to get an up to date and authenticated key.

Sounds complicated? It isn’t: Just upload your public PGP key to your websites root folder in a `pgp.asc` file and you’re good to go!

## Example

Make your public PGP key (please, please only your public key) available at:

	https://yoururl.com/pgp.asc

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

We basically need help with everything, ranging from Front-End and Design over Back-end to Copywriting. Take a look at the Todo List below and submit a PR with your ideas! 

### Todo List

- [ ] Website
	- [ ] Design, [Discussion](/../../issues/1)
		- [ ] Color Scheme
		- [ ] Sketches/Pictures? (similar to [humans.txt](http://humanstxt.org))
		- [ ] Logo?
	- [ ] Automated Hall of Fame, [Discussion](/../../issues/3)
- [ ] Copywriting
	- [ ] General Copy, [Discussion](/../../issues/2)
	- [ ] PGP Guide for beginners, [Discussion](/../../issues/5)

### Website

#### Target groups

1) People who know and use PGP

We should cover those with the main parts of the website, as they already understand all the lingo involved and know what is going on.

2) People who have heard and maybe even tried using PGP, but are not using it regularly

I have no idea what to do with them. Ideas?

3) People who have no idea WTF is going on

We can use the website to spread the word about E-Mail encryption and maybe later about other privacy related issues. What about a prominent link on the homepage á la "I have no idea WTF is going on" linking to a basic guide to PGP. (E.g. http://curtiswallen.com/pgp) 

#### Copy

I (Max) suck at copywriting, but had to write something to start out. If you have any ideas on how to improve the wording, what to include and what to leave out, [discuss it in issue #2](/../../issues/2).

#### Design

My (Max) design is very basic, and not very inviting. If you want to help with the Design, join the [discussion in issue #1](/../../issues/1)!

#### Backend

I think a "Hall of Fame" is a great idea to motivate people to upload a pgp.asc file to their website. I'd be great if it runs automatically, i.e. people submit their link through the website, we check if the pgp.asc file exists, send them an encrypted mail with the key they provided to the mail adress they provided with a validation link inside. As soon as they click that link, their website gets added to the Hall of Fame. Already got an idea on how to accomplish parts of this? Awesome, [join the disscusion in issue #3](/../../issues/3)! For general backend related ideas, please open a new issue!

#### Front-End

As soon as basic design decisions are made, we can start coding it out. 

## FAQ

### Why not use key servers, keybase, the blockchain, DNS,...?

We are not preaching against keyservers and services like keybase. You can (and should) still use those. pgp.asc should be seen as an add-on to the currently available options, and my (mstoiber) personal goal is that we someday have mailto: links with somekind of attribute, and I don't even have to search for your key anymore when I click on your link.

We want to have a section devoted to more elaborate techniques to protect yourself, the surrounding elements of PGP, e.g. MITM attacks, open networks in general, pre-used PCs, etc. (Stuff that Curtis Wallens brilliant [guide to PGP](http://curtiswallen.com/pgp) touches on.) There will hopefully also be a section devoted to different, more elaborate, methods of distributing your key (or the location of your key), e.g. namecoin, [DNS](http://www.gushi.org/make-dns-cert/HOWTO.html), etc.

### How is this decentralized?

&gt; de·cen·tral·ize
 
&gt; To undergo redistribution or dispersal away from a central location or authority.

[Source](http://www.thefreedictionary.com/decentralized)

In this case the central location(s) would be the key servers, so this is decentralized, everybody hosting their own key.
