class PersonMailer < ApplicationMailer
	default from: "contact@mstoiber.com"
  layout 'mailer'

	  def verification_email(person)
	  	@person = person
	  	website = @person.url.gsub(/\/$/, "") + "/pgp.asc"
	  	key = Curl.get(website).body_str
	  	imported_key = GPGME::Key.import(key)
	  	fpr = imported_key.imports.first.fpr
	  	mail(:to => "<#{@person.mail}>", :subject => "pgp.asc Hall of Fame", gpg: {encrypt:false}) #, keys: { "<#{@person.mail}>" => fpr}})
		end
end
