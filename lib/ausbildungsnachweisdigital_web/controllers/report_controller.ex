defmodule AusbildungsnachweisdigitalWeb.ReportController do
  use AusbildungsnachweisdigitalWeb, :controller

  alias Ausbildungsnachweisdigital.ReportPdfCreator
  alias Ausbildungsnachweisdigital.Reports

  def download(conn, params) do
    report = Reports.get_report!(params["id"])
    pdf = ReportPdfCreator.to_pdf(report)
    filename = "report.pdf"

    conn
    |> put_resp_content_type("application/pdf")
    |> put_resp_header("content-disposition", "attachment; filename=\"#{filename}\"")
    |> send_resp(200, pdf)
  end
end
