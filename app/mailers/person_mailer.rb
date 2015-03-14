class PersonMailer < ApplicationMailer
	default from: "contact@mstoiber.com"
  layout 'mailer'

	  def verification_email(person, fpr)
	  	@person = person
	  	mail(:to => "<#{@person.mail}>", :subject => "pgp.asc Hall of Fame", gpg: {encrypt: false}) #, keys: { "<#{@person.mail}>" => fpr}})
		end
end
