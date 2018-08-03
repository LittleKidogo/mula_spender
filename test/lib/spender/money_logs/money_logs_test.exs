defmodule Spender.MoneyLogsTest do
  use Spender.DataCase

  alias Spender.{MoneyLogs, MoneyLogs.Moneylog, MoneyLogs.Owner}

  @valid_moneylog %{name: "Moneylog", start_date: "2018-03-03", end_date: "2018-03-04"}
  @updated_moneylog %{name: "Moneylog-Update", start_date: "2018-03-03", end_date: "2018-03-04"}
  describe "moneylog " do
    test "list moneylog/1 returns all moneylog that belong to a user" do
      user = insert(:user)
      owner = insert(:owner, user: user)
      insert(:moneylog, owner: owner)
      insert(:moneylog, owner: owner)

      moneylog = Repo.all(MoneyLogs.Moneylog)

      {:ok, saved_moneylog} = MoneyLogs.list_moneylog(owner)
      assert saved_moneylog |> Enum.sort == moneylog |> Enum.sort
    end

    test "create_moneylog/2 creates and returns a moneylog when attributes are valid" do
      owner = insert(:owner)
      %{name: name } = @valid_moneylog

      {:ok, moneylog} = MoneyLogs.create_moneylog(owner, @valid_moneylog)
      assert Repo.one(MoneyLogs.Moneylog)
      assert moneylog.name == name
    end

    test "update_moneylog/2 updates the details of a moneylog" do
      %{name: name } = @updated_moneylog
      moneylog = insert(:moneylog, @valid_moneylog)
      {:ok, moneylog} = MoneyLogs.update_moneylog(moneylog, @updated_moneylog)
      assert moneylog.name  == name
    end

    test "delete_moneylog/1 deletes a moneylog" do
      moneylog = insert(:moneylog)
      assert Repo.aggregate(Moneylog, :count, :id) == 1
      {:ok, deleted_moneylog} = MoneyLogs.delete_moneylog(moneylog)
      assert Repo.aggregate(Moneylog, :count, :id) == 0
      assert deleted_moneylog.id == moneylog.id
    end

    test "create owner saves an onwer" do
      attrs = %{name: "Zacck"}
      user = insert(:user)
      assert Repo.aggregate(Owner, :count, :id) == 0
      {:ok, owner} = MoneyLogs.create_owner(user,attrs)
      assert Repo.aggregate(Owner, :count, :id) == 1
      assert owner.name == attrs.name
    end
  end
end
