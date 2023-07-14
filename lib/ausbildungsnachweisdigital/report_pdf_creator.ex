defmodule Ausbildungsnachweisdigital.ReportPdfCreator do
  def to_pdf(report) do
    Pdf.build([size: :a4, compress: true], fn pdf ->
      pdf
      |> Pdf.set_info(title: "Demo PDF")
      |> Pdf.set_font("Helvetica", 10)
      |> Pdf.text_at({200, 200}, report.activity)
      |> Pdf.export()
    end)
  end
end
