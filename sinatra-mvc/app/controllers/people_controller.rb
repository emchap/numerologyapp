get '/people' do
  @people = Person.all
  erb :"/people/index"
end

get '/people/new' do
	@person = Person.new
	erb :"/people/new"
end

post '/people' do
	if params[:birthdate].include?("-")
		birthdate = params[:birthdate]
	elsif birthdate
		birthdate = Date.strptime(params[:birthdate], "%m%d%Y")
	else
  		birthdate = ""
	end
  
	@person = Person.new(first_name: params[:first_name], last_name: params[:last_name], birthdate: birthdate)
	if @person.valid?
		@person.save
		redirect "/people/#{@person.id}"
	else
		@errors = ''
		@person.errors.full_messages.each do |msg|
	  		@errors = "#{@errors} #{msg}."
		end
		erb :"/people/new"
	end
end


get '/people/:id' do
	@person = Person.find(params[:id])
	birthdate_string = @person.birthdate.strftime("%m%d%Y")
	birth_path_number = Person.birth_path_number(birthdate_string)
	@message = Person.message(birth_path_number)
	
	erb :"/people/show"
end

get '/people/:id/edit' do
	@person = Person.find(params[:id])
	erb :'/people/edit'
end

put '/people/:id' do
	@person = Person.find(params[:id])
	@person.first_name = params[:first_name]
	@person.last_name = params[:last_name]
	@person.birthdate = params[:birthdate]
	if @person.valid?
		@person.save
		redirect "/people/#{@person.id}"
	else
		@errors = ''
		@person.errors.full_messages.each do |msg|
	  		@errors = "#{@errors} #{msg}."
		end
		erb :"/people/edit"
	end
end

delete '/people/:id' do
	person = Person.find(params[:id])
	person.destroy
	redirect "/people"
end