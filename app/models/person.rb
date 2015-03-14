class Person < ActiveRecord::Base
	has_many :keys, dependent: :destroy

	before_create :send_verification_email

	# This method creates a random verification hash, checks that the hash is unique in the database,
	# then sends the verification email
	def send_verification_email
		exists = true
		# Generates a random, unique hash for every person
		begin
		  random_hash = SecureRandom.hex(16)
		  if Person.exists?(:confirm_hash => random_hash)
		    exists = true
		  else
		    self.confirm_hash = random_hash
		    puts "======================================"
		    puts random_hash
		    exists = false
		  end
		end while exists === true

		# Checks if they actually have a key on their website
		website = self.url.gsub(/\/$/, "") + "/pgp.asc"
		encrypt = false
		key = Curl.get(website).body_str
		imported_key = GPGME::Key.import(key)
		if defined? imported_key.imports.first.fpr
			fpr = imported_key.imports.first.fpr
		else
			return false
		end
		PersonMailer.verification_email(self, fpr).deliver_now
	end
end