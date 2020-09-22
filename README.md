# DEPRECATED
# Rails Resque Template

Step 1 :

Make sure your Gemfile contain :


```Gemfile
 # Redis
 gem 'redis'
 
 # Resque
 gem 'resque', :require => 'resque/server'
```
 
Step 2 :

Add redis URL in resque.rb in config/initializers :


```Gemfile
ENV["REDIS_URL"] ||= "redis://@localhost:6379/"

uri = URI.parse(ENV["REDIS_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

Dir["/app/jobs/*.rb"].each { |file| require file }
```

Do not forget to add your job in Dir("somewhere in app folder")


Step 3 (optional) :

Add resque routes your config/routes.rb

```Ruby
require 'resque/server'

Rails.application.routes.draw do

	mount Resque::Server.new, at: "/resque"
```

This step is for monitoring your resque.


Step 4 :

Create jobs folder in your app/jobs/task.rb :


```Ruby
module Task
	@queue = :task
 	
    def self.perform(task)
      puts "Some #{task}!"
  	end
end
```

Step 5 :

Create rake file in lib/tasks/resque.rake :

```rake
require "resque/tasks"

task "resque:setup" => :environment
```

Step 6 :

Run your rails server 

Step 7 :

Run your redis server


Step 7 :

Run your resque :

```bash 

TERM_CHILD=1 QUEUES=* bin/rake resque:work

```



