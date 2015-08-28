Steps to load the application:

1. clone the github repo and cd to the root directory of the app.
2. Set up the database credentails and facebook app credentails in the config/database.yml and config/initializers/omniauth.rb.
3. run: `bundle install`
3. run the commands:
  a. `rake db:setup`
  b. `rake db:migrate`
  c. `rake db:seed`
4. Start the server using command: `rails s`

Description of the project:
 There are 4 models User, Monsters, Teams and Monster_Types
 User are created using Facebook credentails.
 One User can have have 20 monsters and 3 teams for max.
 Each team can have max of 3 monsters.
 The monsters can of type only definted in monster_types.
 Sorting of monsters can be done by name, power or type per user.
 The type of monster has ranks with fire been the highest, so that we can sort also over the powerness or weakness of user's monsters type.
