class PersonsController < ApplicationController
  require 'securerandom'

  def index
  	@person = Person.new

    # If a confirm hash parameter is passed
    if params[:ch] != nil
      # And a person with that confirm hash exists
      if Person.exists?(:confirm_hash => params[:ch])
        # Find the person and set 'confirmed' to true
        person = Person.find_by confirm_hash: params[:ch]
        person.update_attribute(:confirmed, true)
        # The show a success message
        flash[:success] = "You are now in the Hall of Fame, thanks!"
      else
        # Otherwise show an error
        flash[:error] = "Something went wrong with the verification, please try again!"
      end

      redirect_to root_path
    end
  end

  def create
    @person = Person.create(person_params)

    # If nothing went wrong with the sending of the mail
    if @person.save
      flash[:success] = "Almost there #{@person.name}, check your mail!"
    else
      # This gets shown when something went wrong in the model
      flash[:error] = "Something went wrong, did you enter the right URL?"
    end

  	redirect_to root_path
  end

  def show
  end

  def halloffame
    @person = Person.new
    @persons = Person.all.where(confirmed: 'true').order('updated_at DESC')
  end

  def pgpguide
    @person = Person.new
  end

  private
    def person_params
      params.require(:person).permit(:name, :url, :mail)
    end
end
