defmodule AusbildungsnachweisdigitalWeb.ReportLive.Show do
  use AusbildungsnachweisdigitalWeb, :live_view

  alias Ausbildungsnachweisdigital.Reports

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:report, Reports.get_report!(id))}
  end

  @impl true
  def handle_event("generate_pdf", _, socket) do
    # da die PDF Datei sowieso über HTTP geschickt werden muss,
    # ist die Variante direkt einen Link auf den ReportPdfontroller zu setzen hier sinnvoller
    {:noreply, socket}
  end

  defp page_title(:show), do: "Show Report"
  defp page_title(:edit), do: "Edit Report"
end
