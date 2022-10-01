defmodule {{project_name}}Web.PageController do
  use {{project_name}}Web, :controller

  import Logger

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def ping(conn, _params) do
    Logger.error("One problem")
    text conn, "Showing"
  end

  def do_action(conn, %{"action_id" => action_id} = _params) do

#    GenServer.call(:act, action_id)

    text conn, "Ok"
  end

  def post(conn, _params) do
    #    Logger.error("second problem")

    Process.sleep(10000)

    text conn, "post!"
  end


end
