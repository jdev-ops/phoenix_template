defmodule ApiService1 do
  @moduledoc false

  use GenServer, restart: :transient

  def start_link(data),
      do: GenServer.start_link(__MODULE__, data, name: process_name(data))

  defp process_name(%{name: name} = data),
       do: {:via, Registry, {ApiServicesRegistry, name}}

  def init(data),
      do: {:ok, data}

  @impl true
  def handle_cast({:set_age, age}, state) do
    {:noreply, %{state | age: age}}
  end

  @impl true
  def handle_call(:get_age, {pid, _ref}, %{age: age} = state) do
    {:reply, age, state}
  end


  #  def init(person),
  #      do: {:ok, person, {:continue, nil}}

  def handle_continue(nil, person) do
    IO.puts("👋 #{person}")
    {:stop, :normal, person}
  end

end
