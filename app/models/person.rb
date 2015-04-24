class Person < ActiveRecord::Base
	has_many :keys, dependent: :destroy

	before_create :send_verification_email

	# This method creates a random verification hash, checks that the hash is unique in the database,
	# then sends the verification email. Mode is either 'http' or 'https'
	def send_verification_email(person = self, website_protocol = 'https://')

		website_regex = /^(http\:\/\/|https\:\/\/)?([a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3})(\/\S*)?$/
		exists = true
		# Generates a random, unique hash for every person
		begin
		  random_hash = SecureRandom.hex(16)
		  if Person.exists?(:confirm_hash => random_hash)
		    exists = true
		  else
		    person.confirm_hash = random_hash
		    exists = false
		  end
		end while exists === true


		# Get the website protocol from the URL
		passed_website_protocol = website_regex.match(person.url)[1]

		# If the URL had a website protocol
		if (defined?passed_website_protocol).nil?
			# Use that one
			website_protocol = passed_website_protocol
		end

		# Get actual URL part, i.e. 'pgpasc.org' in 'http://pgpasc.org/halloffame.html'
		website = website_regex.match(person.url)

		# If the website was wrongly formatted
		if website == nil
			return false
		else
			# Otherwise get the URL
			website = website_regex.match(person.url)[2]
		end
		# Set the current persons URL to that
		person.url = website

		# If a person with that URL already exists, and they are confirmed show an error
		if Person.exists?(:url => website)
			existing_person = Person.find_by url: website
			if existing_person.confirmed == true
				return false
			end
		end

		# Put together website for CURL request
		website = website_protocol + website + '/pgp.asc'

		# Get the key with a CURL request
		begin
			request = Curl::Easy.new(website)
			request.ssl_verify_peer = false
			request.perform
		rescue Curl::Err::SSLPeerCertificateError, Curl::Err::HostResolutionError, Curl::Err::ConnectionFailedError => error
			# If it failed with HTTPS, try HTTP
			if website_protocol == 'https://'
				return send_verification_email(person, 'http://')
			end
			# If the request fails with HTTPS and with HTTP, flash an error message
			return false
		end
		# Slice the key from the HTML
		key = request.body_str
	  # Import the key
		imported_key = GPGME::Key.import(key)
		# Send the email
		PersonMailer.verification_email(person, key).deliver_now
	end
end