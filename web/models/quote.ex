defmodule Splurty.Quote do
  use Splurty.Web, :model

  schema "quotes" do
    field :saying, :string
    field :author, :string
  end


  defmodule Queries do

    import Ecto.Query

    def random do
      #query = from Splurty.Quote
      #qs = Splurty.Repo.all(query)
      #Enum.shuffle(qs)
      #|> List.first
      {:ok, %{rows: [row]}} = Ecto.Adapters.SQL.query(Splurty.Repo, "select * from quotes order by rand() limit 1", [])
      [id, saying, author] = row
      %Splurty.Quote{id: id, saying: saying, author: author}
    end
  end
end
