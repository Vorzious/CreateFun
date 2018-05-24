# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds_dev.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CreateFun.Repo.insert!(%CreateFun.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
require Logger

alias CreateFun.Accounts

# Add admin
case Accounts.list_admins() do
  [] ->
      admins = [
          %{
              "username" => "admin",
              "password" => "test123"
          }
      ]
      Enum.each(admins, fn(admin) -> 
          case Accounts.create_admin(admin) do
              {:ok, _} ->
                  Logger.info("Admin inserted successfully")
              {:error, %Ecto.Changeset{} = changeset} ->
                  Logger.info("Failed to insert Administrator")
          end
      end)
      {:error, error} ->
          Logger.error("Something went wrong when adding Administrators")

      _ ->
          Logger.error("Admins already populated")
end
