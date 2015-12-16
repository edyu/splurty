defmodule Splurty.QuoteController do
  use Splurty.Web, :controller

  def homepage(conn, _params) do
    conn
    |> assign(:quote, Splurty.Quote.Queries.random)
    |> render("show.html")
  end

  def index(conn, _params) do
    conn
    |> assign(:quotes, Repo.all(Splurty.Quote))
    |> render("index.html")
  end

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"quote" => %{"saying" => saying, "author" => author}}) do
    q = %Splurty.Quote{saying: saying, author: author}
    Splurty.Repo.insert(q)

    redirect conn, to: quote_path(conn, :index)
  end

  def show(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)
    conn
    |> assign(:quote, Splurty.Repo.get(Splurty.Quote, id))
    |> render("show.html")
  end

  def edit(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)
    conn
    |> assign(:quote, Splurty.Repo.get(Splurty.Quote, id))
    |> render("edit.html")
  end

  def update(conn, %{"id" => id, "quote" => %{"saying" => saying, "author" => author}}) do
    {id, _} = Integer.parse(id)
    q = Splurty.Repo.get(Splurty.Quote, id)
    q = %{q | saying: saying, author: author }
    Splurty.Repo.update(q)
    redirect conn, to: quote_path(conn, :show, q.id)
  end

  def delete(conn, %{"id" => id}) do
    {id, _} = Integer.parse(id)
    q = Splurty.Repo.get(Splurty.Quote, id)
    Splurty.Repo.delete(q)
    redirect conn, to: quote_path(conn, :index)
  end
end
