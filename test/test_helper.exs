{:ok, _} = Application.ensure_all_started(:ex_machina)  #ensure ex_machina is started

ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Spender.Repo, :manual)

