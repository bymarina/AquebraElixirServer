defmodule AquebraWeb.DocumentController do
  use AquebraWeb, :controller

  alias Aquebra.Logistic
  alias Aquebra.Logistic.Document

  action_fallback AquebraWeb.FallbackController

  def index(conn, _params) do
    documents = Logistic.list_documents()
    render(conn, "index.json", documents: documents)
  end

  def create(conn, %{"document" => document_params}) do
    with {:ok, %Document{} = document} <- Logistic.create_document(document_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.document_path(conn, :show, document))
      |> render("show.json", document: document)
    end
  end

  def show(conn, %{"id" => id}) do
    document = Logistic.get_document!(id)
    render(conn, "show.json", document: document)
  end

  def update(conn, %{"id" => id, "document" => document_params}) do
    document = Logistic.get_document!(id)

    with {:ok, %Document{} = document} <- Logistic.update_document(document, document_params) do
      render(conn, "show.json", document: document)
    end
  end

  def delete(conn, %{"id" => id}) do
    document = Logistic.get_document!(id)

    with {:ok, %Document{}} <- Logistic.delete_document(document) do
      send_resp(conn, :no_content, "")
    end
  end
end
