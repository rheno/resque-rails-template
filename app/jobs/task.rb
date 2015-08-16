module Task
  @queue = :task

  def self.perform(task)
    puts "Some #{task}!"
  end
end

