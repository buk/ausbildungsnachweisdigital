defmodule AusbildungsnachweisdigitalWeb.ReportPdfController do
  use AusbildungsnachweisdigitalWeb, :controller

  alias Ausbildungsnachweisdigital.ReportPdfCreator
  alias Ausbildungsnachweisdigital.Reports

  def download(conn, params) do
    report = Reports.get_report!(params["id"])
    pdf = ReportPdfCreator.to_pdf(report)

    {:ok, pdf_binary} =
      ExTypst.render_to_pdf("<%= reports %>",
        reports: ExTypst.Format.table_content(ReportPdfCreator.to_pdf(report))
      )

    File.write!("reports.pdf", pdf_binary)
    IO.puts("Successfully written reports.pdf file")
  end
end
