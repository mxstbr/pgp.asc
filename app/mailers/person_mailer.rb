class PersonMailer < ApplicationMailer
	default from: "pgp@mxstbr.com"
  layout 'mailer'

	  def verification_email(person, key)
	  	@person = person
	  	mail to: "<#{@person.mail}>", subject: "pgp.asc Hall of Fame", gpg: { encrypt: true, keys: { @person.mail => key }}
		end
end
