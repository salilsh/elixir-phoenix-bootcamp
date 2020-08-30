defmodule Discuss.PageController do
  use Discuss.Web, :controller

  alias Discuss.Topic
  
  def index(conn, _params) do
    topics = Repo.all(Topic)

    render conn, "index.html", topics: topics
  end
end
