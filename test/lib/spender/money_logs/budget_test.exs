defmodule Spender.MoneyLogs.MoneylogTest do
  use Spender.DataCase
  alias Spender.MoneyLogs.Moneylog

  @valid_attrs %{name: "Budget", start_date: "2018-03-03", end_date: "2018-03-04"}
  @invalid_attrs %{}
  describe "budget changesets " do
    test " valid changeset if attributes are valid" do
      changeset = Moneylog.changeset(%Moneylog{}, @valid_attrs)
      assert changeset.valid?
    end

    test " invalid changeset if invalid attributes are provided" do
      changeset = Moneylog.changeset(%Moneylog{}, @invalid_attrs)
      refute changeset.valid?
    end

    test " valid if status is accepted" do
      ["new","planning","refined","active","expired"] |> Enum.each(fn(state) ->
        payload = Map.put(@valid_attrs, :status, state)
        changeset = Moneylog.update_status(%Moneylog{}, payload)
        assert changeset.valid?
      end)
    end

    test " invalid if status is not accepted" do
      ["play", "budget", "owner"] |> Enum.each(fn(state) ->
        payload = Map.put(@valid_attrs, :status, state)
        changeset = Moneylog.update_status(%Moneylog{}, payload)
        refute changeset.valid?
      end)
    end
  end
end
