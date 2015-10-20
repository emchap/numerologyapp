require 'sinatra'

######
# Assorted sundry methods
######

def birth_path_number(birthdate)
	number = birthdate[0].to_i + birthdate[1].to_i + birthdate[2].to_i + birthdate[3].to_i + birthdate[4].to_i + birthdate[5].to_i + birthdate[6].to_i + birthdate[7].to_i
	
	number = number.to_s
	number = number[0].to_i + number[1].to_i
	
	if number > 9
	then 
		number = number.to_s
		number = number[0].to_i + number[1].to_i
	end

	return number

end

def message(birth_path_number)
	initial = "Your numerology number is: #{birth_path_number}."
	case birth_path_number
		when 1
			return "#{initial} One is the leader. The number one indicates the ability to stand alone, and is a strong vibration. Ruled by the Sun."
		when 2
			return "#{initial} This is the mediator and peace-lover. The number two indicates the desire for harmony. It is a gentle, considerate, and sensitive vibration. Ruled by the Moon."
		when 3
			return "#{initial} Number Three is a sociable, friendly, and outgoing vibration. Kind, positive, and optimistic, Three's enjoy life and have a good sense of humor. Ruled by Jupiter."
		when 4
			return "#{initial} This is the worker. Practical, with a love of detail, Fours are trustworthy, hard-working, and helpful. Ruled by Uranus."
		when 5
			return "#{initial} This is the freedom lover. The number five is an intellectual vibration. These are \'idea\' people with a love of variety and the ability to adapt to most situations. Ruled by Mercury."
		when 6
			return "#{initial} This is the peace lover. The number six is a loving, stable, and harmonious vibration. Ruled by Venus."
		when 7
			return "#{initial} This is the deep thinker. The number seven is a spiritual vibration. These people are not very attached to material things, are introspective, and generally quiet. Ruled by Neptune."
		when 8
			return "#{initial} This is the manager. Number Eight is a strong, successful, and material vibration. Ruled by Saturn."
		when 9
			return "#{initial} This is the teacher. Number Nine is a tolerant, somewhat impractical, and sympathetic vibration. Ruled by Mars."
		else
			return "Whoops! There's an error." #This is no longer necessary since we're validating the form input, but leaving for now.
	end
end

def all_responses(i)
	messages = []
	while i < 10
		messages << "<p>#{message(i)}</p>"
		i += 1
	end
	
	#this is hideous but I've been fighting with Sinatra for three hours and no longer care
	return messages
end

def setup_index_view
    birthdate = params[:birthdate]
    birth_path_number = birth_path_number(birthdate)
    @message = message(birth_path_number)
	erb :index
end

def valid_birthdate(input)
	if input.length == 8 && input.match(/^[0-9]+[0-9]$/)
		return true
	else
		return false
	end
end

######
# The Sinatra requests are below, methods defined above.
######

get '/' do
	erb :form
end

post '/' do   
	#birthdate = params[:birthdate].gsub("-","") (The gsub is for when this is a date, we're making it text to test validation)
	birthdate = params[:birthdate]
	if valid_birthdate(birthdate)
		birth_path_num = birth_path_number(birthdate)
		redirect "/message/#{birth_path_num}"
	else
		@error = "You should enter a valid birthdate in the form of mmddyyyy."
		erb :form
	end
end

get '/allresponses' do
	@responses = all_responses(1)
	erb :all_responses
end

get '/:birthdate' do
	setup_index_view
end

get '/message/:birth_path_num' do
	birth_path_num = params[:birth_path_num].to_i
	@message = message(birth_path_num)
	erb :index
end

