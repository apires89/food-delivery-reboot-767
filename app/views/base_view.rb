class BaseView
  def display(elements)
    elements.each_with_index do |element,index|
      print_element(element,index)
    end
  end

  def ask_user_for(something)
    puts "What is the #{something}?"
    gets.chomp
  end


end
