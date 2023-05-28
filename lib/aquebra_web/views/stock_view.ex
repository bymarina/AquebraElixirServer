defmodule AquebraWeb.StockView do
  use AquebraWeb, :view
  alias AquebraWeb.StockView

  def render("index.json", %{stocks: stocks}) do
    %{data: render_many(stocks, StockView, "stock.json")}
  end

  def render("show.json", %{stock: stock}) do
    %{data: render_one(stock, StockView, "stock.json")}
  end

  def render("stock.json", %{stock: stock}) do
    %{
      id: stock.id,
      type: stock.type,
      quantity: stock.quantity
    }
  end
end
