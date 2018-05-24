defmodule CreateFunEndpoint.ErrorView do
  use CreateFunEndpoint, :view

  def render(template, assigns) do
    case assigns.conn.path_info do
      ["api" | _] ->  render(CreateFunApi.ErrorView, template, assigns) #YipYip-Scaffold-Remove-API
      ["cms" | _] -> render(CreateFunCms.ErrorView, template, Map.merge(assigns, %{layout: {CreateFunCms.LayoutView, "error.html"}})) #YipYip-Scaffold-Remove-CMS
      _ -> render(CreateFunWeb.ErrorView, template, Map.merge(assigns, %{layout: {CreateFunWeb.LayoutView, "error.html"}})) #YipYip-Scaffold-Remove-WEB
    end
  end

end
