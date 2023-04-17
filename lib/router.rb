class Router
  def initialize(controller)
    @controller = controller
    @running    = true
  end

  def run
    puts "Welcome to the Cookbook!"
    puts "           --           "

    while @running
      display_tasks
      action = gets.chomp.to_i
      print `clear`
      route_action(action)
    end
  end

  private

  def route_action(action)
    case action
    when 1 then @controller.list
    when 2 then @controller.add
    when 3 then @controller.import
    when 4 then @controller.mark_as_done
    when 5 then @controller.remove
    when 0 then stop
    else
      puts "Please press 1, 2, 3 or 4"
    end
  end

  def stop
    @running = false
  end

  def display_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all recipes"
    puts "2 - Add a new recipe"
    puts "3 - Import a recipe from the web"
    puts "4 - Mark recipe as 'done'"
    puts "5 - Remove a recipe"
    puts "0 - Stop and exit the program"
  end
end
