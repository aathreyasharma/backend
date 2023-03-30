# README
The implementation is a solution to handle and solves for potential data inconsistency.
This rails app is an **API** only implementation. 
The app provides a solution for the following problem statement.

EX: Let us suppose we have two tables, `invoice` and `invoice_items`. We store the sum of all `invoice_items` as `total_price` on the `invoice` table. If a user updates an `invoice_item` directly on the database, we have no way of knowing the event and no callbacks are invoked on the application server.

To handle such a scenario, we are using [**Triggers**](https://www.postgresql.org/docs/current/triggers.html) and [**NOTIFY/LISTEN**](https://www.postgresql.org/docs/current/sql-notify.html) features of PostgreSQL database.
(Read More)

* The flow goes like this:
  - A user makes a change on the database table
  - The trigger is invoked based on the occured event. Ex: `update`
  - The trigger notifies a channel along with the payload data
  - Any listeners listening to the channel gets the payload
  - The payload is then parsed to get the details. Ex: event_type
  - The data is then queued for processing asynchronously
  - Based on the received information, the Job is then processed by an appropriate processor which contains business logic



* Versions and dependencies
  - [rvm](https://rvm.io/)
    - It is preferred to use `rvm` to manage your rubies
  - ruby -> 3.2.1
    - Latest stable ruby at the time of creating the codebase
  - rails -> 7.x
  - [hairtrigger](https://github.com/jenseng/hair_trigger) -> 1.0.0
    - `hairtrigger` is a database agnostic library that allows us to easily manage the necessary migrations that are required to create triggers on the database
    - Though trigger procedures can directly be created on the database without any gems, it's better to use the gem because it allows us to add the trigger definitions on the Model level. It helps us keep track of the procedures on the database at the application level. If a trigger is directly added on the database, it becomes difficult to understand, track and debug the changes that occur in the database behind the scenes because of the triggers.
    
  - sidekiq -> 7.0.7
    - To handle jobs async

* Database
  - Download & install [PostgreSQL](https://www.postgresql.org/download/)
    - 15.2 at the time of creation of the app
    - username: postgres
    - password: postgres
  - Download & install [Redis](https://redis.io/docs/getting-started/installation/)

* Configuration
  - Eager loading is enabled in `development` mode to run the app easily locally
  - The database listener is run on a [rake task](https://github.com/aathreyasharma/backend/blob/main/lib/tasks/database_listener.rake)
  - Models that are to be listened should be initialized at least once inorder to be referenced by the listener which doesn't happen on lazy loading

* Running the application
  - Clone the repo and go to the home directory. `cd backend`
  - run `bundle install` in the home directory
  - run `rails db:create` to create the database
  - run `rails db:migrate` to run the migrations
  - run `rails db:seed` to add sample data
  - run `rails db:reset db:seed` to drop the database and repopulate again
    - Sample data contains a few records of the following models:
      - **User**
      - **Product**
      - **Invoice**
      - **InvoiceItem**
   - run `rails database_listener:run` on a new terminal to start the database listener
     - You shoud see the message
        > ***We are now listening to Database messages!!***
   - run `redis-server` on a new terminal to have the redis running
   - run `bundle exec sidekiq` on a new terminal to start sidekiq
   - Go to `http://localhost:3000/sidekiq` to monitor the queues
   And you are all set!
 
* Extensability
  - The model `InvoiceItem` or more precisely the table `invoice_items` is now being listened to for any events
  - The way this is done is by including the concern that is defined in the module [`DatabaseListenable`](https://github.com/aathreyasharma/backend/blob/main/app/models/concerns/database_listenable.rb) called `add_db_listener` ([here](https://github.com/aathreyasharma/backend/blob/3432f99e05c5cb4f1fb83b91880e13c3c1cf701d/app/models/concerns/database_listenable.rb#L4))
  - This is where we keep a track of all the tables that are to be listened to for any changes (`listening_klasses`)
  - Steps to make it work across models:
    - Add `add_db_listener` in your model
    - It adds the the necessary triggers to your model
    - It helps keep track of all the model names that are to be listened to
    - run `rake db:generate_trigger_migration`
      - It generates the necessary migration required to add triggers to your table on the database level
    - Add a new processor in the `app/event_processors` directory to handle the events of the new listenable model
      - Make sure the name of the processor corresponds with the model name.
        -  Ex: `InvoiceProcessor` or a `ProductProcessor`
        - This is because the event from the database contains the table name on which the event occured and the table name is then `classify`ed. Ex: `invoice_items -> InvoiceItem`
    - Restart the server
    - Restart the listener (`rails database_listener:run`)

* Services (job queues, cache servers, search engines, etc.)
  - [`DatabaseListener`](https://github.com/aathreyasharma/backend/blob/main/app/services/database_listener.rb) is a listener service that is used to capture events occured at database level
    - It listen to multiple channels by opening async connection and processes the received message
  - [`DbEventJob`](https://github.com/aathreyasharma/backend/blob/main/app/jobs/db_event_job.rb) is used by the listener to queue the payload for further processing. It calls appropriate processor(service) to process further
  - [`InvoiceItemProcessor`](https://github.com/aathreyasharma/backend/blob/main/app/event_processors/invoice_item_processor.rb) A processor dedicated to handle events on InvoiceItem

* How to run the test suite
  - Tests are written with RSpec
  - To prepare the DB
    - `RAILS_ENV=test rails db:create db:migrate`
  - Run command `rspec` to run all the test cases
  - Reset the **test** database
    - Sometimes we might want to completely reset the test database. It may be because of various reasons like a failed migration or existance of stale data, or something else. Existance of stale data might also sometimes fail test cases randomly. In such cases we can completely remake the DB.
    - `RAILS_ENV=test rails db:drop db:create db:migrate`

* ...
