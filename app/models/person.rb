class Person < ActiveRecord::Base
	has_many :keys, dependent: :destroy

	after_create :send_verification_email

	# This method creates a random verification hash, checks that the hash is unique in the database,
	# then sends the verification email
	def send_verification_email
		exists = true
		begin
		  random_hash = SecureRandom.hex(16)
		  if Person.exists?(:confirm_hash => random_hash)
		    exists = true
		  else
		    self.update_attribute(:confirm_hash, random_hash)
		    puts "======================================"
		    puts random_hash
		    exists = false
		  end
		end while exists === true
		PersonMailer.verification_email(self).deliver
	end
end
