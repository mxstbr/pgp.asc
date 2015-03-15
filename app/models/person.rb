class Person < ActiveRecord::Base
	has_many :keys, dependent: :destroy

	before_create :send_verification_email

	# This method creates a random verification hash, checks that the hash is unique in the database,
	# then sends the verification email. Mode is either 'http' or 'https'
	def send_verification_email(person = self, website_protocol = 'https://')
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

		# Format the URL

		# If no website_protocol was passed
		if 	website_protocol.empty?
			# Get the one from the URL
			website_protocol = /^(http\:\/\/|https\:\/\/)?([a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3})(\/\S*)?$/.match(person.url)[1]
			# If the URL didn't have one
			if 	website_protocol.empty?
				# Set it to HTTPS
				website_protocol = 'https://'
			end
		end

		# Put together URL
		website = /^(http\:\/\/|https\:\/\/)?([a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3})(\/\S*)?$/.match(person.url)[2]
		person.url = website

		if Person.exists?(:url => website) 
			return false
		end

		website = website_protocol + website + '/pgp.asc'
		puts '##########################################'
		puts website

		# Get the key with a CURL request
		request = Curl::Easy.new(website)
		request.ssl_verify_peer = false
		request.perform
		# Slice the key from the HTML
		key = request.body_str
	    # Import the key
		imported_key = GPGME::Key.import(key)
		# If everything went right, send the email
		if defined? imported_key.imports.first.fpr
			fpr = imported_key.imports.first.fpr
		else
			# If it failed with HTTPS, try HTTP
			if website_protocol == 'https://'
				return send_verification_email(person, 'http://')
			end
			# Otherwise just show an error
			return false
		end
		PersonMailer.verification_email(person, fpr).deliver_now
	end
end