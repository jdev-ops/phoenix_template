defmodule ApiServicesSupervisor do
  @moduledoc false

  use DynamicSupervisor

  def start_link(arg),
      do: DynamicSupervisor.start_link(__MODULE__, arg, name: __MODULE__)

  def init(_arg),
      do: DynamicSupervisor.init(strategy: :one_for_one)

  def start_server(person),
      do: DynamicSupervisor.start_child(__MODULE__, {ApiService1, person})

end
