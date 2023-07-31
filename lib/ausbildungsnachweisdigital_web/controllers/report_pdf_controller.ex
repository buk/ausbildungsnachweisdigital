defmodule AusbildungsnachweisdigitalWeb.ReportPdfController do
  use AusbildungsnachweisdigitalWeb, :controller

  alias Ausbildungsnachweisdigital.Reports

  def download(conn, %{"id" => id}) do
    Reports.reports_to_pdf(Path.expand("~/Downloads/#{id}.pdf"))
    {:ok, conn}
  end
end
