defmodule AusbildungsnachweisdigitalWeb.ReportPdfController do
  use AusbildungsnachweisdigitalWeb, :controller

  alias Ausbildungsnachweisdigital.Reports

  def download_all(conn, params) do
    {:ok, pdf_binary} = Reports.reports_to_pdf()
    download = Map.get(params, "download", false) != false

    conn
    |> put_resp_content_type("application/pdf")
    |> put_resp_header(
      "content-disposition",
      "#{(download && "attachment") || "inline"}; filename=\"report.pdf\""
    )
    |> send_resp(200, pdf_binary)
  end

  def download(conn, %{"id" => id} = params) do
    {:ok, pdf_binary} = Reports.report_to_pdf(id)
    download = Map.get(params, "download", false) != false

    conn
    |> put_resp_content_type("application/pdf")
    |> put_resp_header(
      "content-disposition",
      "#{(download && "attachment") || "inline"}; filename=\"report-##{id}.pdf\""
    )
    |> send_resp(200, pdf_binary)
  end
end
