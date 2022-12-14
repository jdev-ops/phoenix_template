defmodule {{project_name}}Web do

  def controller do
    quote do
      use Phoenix.Controller, namespace: {{project_name}}Web

      import Plug.Conn
      alias {{project_name}}Web.Router.Helpers, as: Routes
      import Phoenix.LiveView.Controller
    end
  end

  def view do
    quote do
      use Phoenix.View,
          root: "lib/{{project_name}}_web/templates",
          namespace: {{project_name}}Web

      # Import convenience functions from controllers
      import Phoenix.Controller,
             only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
          layout: { {{project_name}}Web.LayoutView, "live.html"}

      unquote(view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import LiveView helpers (live_render, live_component, live_patch, etc)
      import Phoenix.LiveView.Helpers

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import {{project_name}}Web.ErrorHelpers
      alias {{project_name}}Web.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
