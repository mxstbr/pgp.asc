class PersonsController < ApplicationController
  require 'securerandom'

  def index
  	@person = Person.new
  end

  def create
    @person = Person.create(person_params)

  	redirect_to root_path
  end

  def show
    if params[:ch] != nil
      @person = Person.find_by_id(params[:id])
      if @person.confirm_hash == params[:ch]
        @person.update_attribute(:confirmed, true)
        flash[:success] = "You are now in the Hall of Fame, thanks!"
      else
        flash[:error] = "Something went wrong with the verification, please try again!"
      end

      redirect_to root_path
    end
  end

  def halloffame
    @person = Person.new
    @persons = Person.all
  end

  def pgpguide
    @person = Person.new
  end

  private
    def person_params
      params.require(:person).permit(:name, :url, :mail)
    end
end
