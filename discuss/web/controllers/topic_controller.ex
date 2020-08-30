defmodule Discuss.TopicController do 
    use Discuss.Web, :controller

    alias Discuss.Topic

    def new(conn, params) do       
       changeset = Topic.changeset(%Topic{}, %{})
       
       render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"topic" => topic}) do
        changeset = Topic.changeset(%Topic{}, topic)

        case Repo.insert(changeset) do
            {:ok, post} -> 
                conn
                |> put_flash(:info, "Topic created")
                |> redirect(to: page_path(conn, :index))
            {:error, changeset} -> 
                render conn, "new.html", changeset: changeset
        end
        
        
    end
end