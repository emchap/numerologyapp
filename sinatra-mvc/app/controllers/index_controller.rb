require 'sinatra'

get '/' do
	erb :form
end

post '/' do   
	birthdate = params[:birthdate]
	if Person.valid_birthdate(birthdate)
		birth_path_num = Person.birth_path_number(birthdate)
		redirect "/message/#{birth_path_num}"
	else
		@error = "You should enter a valid birthdate in the form of mmddyyyy."
		erb :form
	end
end

def setup_index_view
	birthdate = params[:birthdate]
	birth_path_number = Person.birth_path_number(birthdate)
	@message = Person.message(birth_path_number)
	erb :index
end

get '/:birthdate' do
	setup_index_view
end

get '/message/:birth_path_num' do
	birth_path_num = params[:birth_path_num].to_i
	@message = Person.message(birth_path_num)
	erb :index
end

