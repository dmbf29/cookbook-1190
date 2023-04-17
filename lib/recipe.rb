class Recipe
  attr_reader :name, :description, :rating, :prep_time
  attr_writer :done

  # when you go over two arguments, normally better to pass a hash
  # def initialize(name, description, rating, prep_time, done)
  def initialize(attributes = {})
    # p attributes # attributes is a hash
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @prep_time = attributes[:prep_time]
    # we allow the user to say if it's done, but if they didnt say anything, just be false
    @done = attributes[:done] || false
  end

  # this is an attr_reader for a boolean
  def done?
    @done
  end

  def mark!
    @done = !@done
  end
end


# p  Recipe.new
# p  Recipe.new(done: true)
# p pizza.name = 'pizza'
# p pizza


# p Recipe.new(name: 'pizza')
# p Recipe.new(description: 'delicious red pizza', name: 'pizza')
# p Recipe.new(
#     dcription: 'delicious red pizza',
#     name: 'pizza',
#     done: false,
#     rating: '10/10',
#     prep_time: '20min'
#   )
