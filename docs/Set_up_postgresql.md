#Install postgresql with homebrew

Run `brew` on the terminal to confirm that you have brew installed.

Then run `brew install postgresql` this should take around 5 min 40 sec depending on how fast your internet is.

To start up your postgresql: `brew services start postgresql`

##Fixing postgres error while cloning the repo

In the local dir of your project run:

* `createdb`

* `psql -h localhost`

This gives you access to the database.

Create a username:

* `CREATE ROLE postgres WITH LOGIN ENCRYPTED PASSWORD 'password';`

This creates a new role and password, if the role already exists run the following:

* `Alter role user postgres with new_role_name`

Run `mix test` should return the number of tests and 0 failures if there is no error in your test.





