def main()
	choice = rand(3)

	user_choice_text = ARGV[0]
	user_choice_digit = convert_from_text_to_digit(user_choice_text)

	if user_choice_digit == -1
		puts "Ошибка"
		exit(-1)
	end

	solve_matrix = [[0,-1,1],[1,0,-1],[-1,1,0]]
	result = solve_matrix[user_choice_digit][choice]

	if result == 0
		puts "Ничья. "+convert_from_digit_to_text(user_choice_digit)+" и "+convert_from_digit_to_text(choice)+" равны."
	elsif result == 1
		puts "Победа пользователя! " + convert_from_digit_to_text(user_choice_digit)+" сильнее "+convert_from_digit_to_text(choice)
	else
		puts "Проигрыш пользователя! " + convert_from_digit_to_text(user_choice_digit)+" слабее "+convert_from_digit_to_text(choice)
	end
end



def convert_from_text_to_digit(user_choice_text)
	if user_choice_text == "ножницы"
		return 0
	elsif user_choice_text == "камень"
		return 1
	elsif user_choice_text == "бумага"
		return 2
	elsif user_choice_text == ""
		puts "Введите название предмета"
		return -1
	else
		puts "Неизвестный предмет"
		return -1
	end
end


def convert_from_digit_to_text(user_digit)
	if user_digit == 0
		return "ножницы"
	elsif user_digit == 1
		return "камень"
	elsif user_digit == 2
		return "бумага"
	else
		return ""
	end
end


main()