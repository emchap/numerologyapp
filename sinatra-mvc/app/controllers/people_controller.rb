get '/people' do
  @people = Person.all
  erb :"/people/index"
end

get '/people/:id' do
	@person = Person.find(params[:id])
	birthdate_string = @person.birthdate.strftime("%m%d%Y")
	birth_path_number = Person.birth_path_number(birthdate_string)
	@message = Person.message(birth_path_number)
	
	erb :"/people/show"
end