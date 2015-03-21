class PersonMailer < ApplicationMailer
	default from: "contact@mstoiber.com"
  layout 'mailer'

	  def verification_email(person, fpr)
	  	puts '§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§'
			puts 'Person Mailer verification_email'
	  	@person = person
	  	mail to: "<#{@person.mail}>", subject: "pgp.asc Hall of Fame", gpg: { encrypt: true, keys: { '<#{@person.mail}>' => fpr } }
		end
end
