## Setting up Spender on your Machine
This guide assumes you Elixir and Erlang set up on your machine
If not follow the [installation instructions](https://elixir-lang.org/install.html) for your system.
1. Clone the development branch using `git clone https://github.com/LittleKidogo/MoneyLog.git`
2. Follow this [guide](/docs/postgres_setup.md) to setup postgres on your system if you haven't already
3. From the downloaded `Moneylog` folder run the following
4. Run `mix deps.get` to install dependecies
5. Run `mix ecto.create` to create the application database  
6. Run `mix ecto.migrate` to run the migrations on the created database
7. Run `npm install` in the `assets` directory to install javascript assets
7. Run `MIX_ENV=test mix test` this should exit with a status of 0
8. Run `mix phx.server` and the application should be available at [localhost:4000](localhost:4000)
6. Ready to hack away!
