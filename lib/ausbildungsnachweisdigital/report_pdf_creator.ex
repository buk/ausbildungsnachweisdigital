defmodule Ausbildungsnachweisdigital.ReportPdfCreator do
  
  # Not really easy to create a table with this Package,
  # will try to use chromic again
  # See this for further informations
  # https://chat.openai.com/share/63622d5d-4a49-474f-b5b3-287163a46f9b
  
  def to_pdf(report) do
    Pdf.build([size: :a4], fn pdf ->
      pdf
      |> Pdf.set_info(
        title: "Test Document",
        producer: "Test producer",
        creator: "Test Creator",
        created: ~D"2023-07-15",
        modified: Date.utc_today(),
        author: "Test Author",
        subject: "Test Subject"
      )
      |> add_header("Ausbildungsnachweis Digital")
      |> write_activity(report)
      |> write_duration(report)
      |> Pdf.export()
    end)
  end

  defp add_header(pdf, header) do
    %{width: width, height: height} = Pdf.size(pdf)

    pdf
    |> Pdf.set_font("Helvetica", 16, bold: true)
    |> Pdf.text_wrap!({20, height - 40}, {width - 40, 20}, header, align: :center)
    |> Pdf.move_down(16)
  end

  defp write_activity(pdf, report) do
    %{width: width} = Pdf.size(pdf)

    cursor = Pdf.cursor(pdf)

    text = "Das wurde heute erledigt: #{report.activity}"

    padding = 20

    pdf
    |> Pdf.set_font("Helvetica", 12)
    |> Pdf.text_wrap!(
      {padding, cursor},
      {width - padding * 2, cursor - padding},
      String.trim(text)
    )
    |> Pdf.move_down(12)
  end

  defp write_duration(pdf, report) do
    %{width: width} = Pdf.size(pdf)

    cursor = Pdf.cursor(pdf)

    text = "So viel Zeit wurde dafür ca. in Stunden aufgebracht: #{report.duration}"
    padding = 20

    pdf
    |> Pdf.set_font("Helvetica", 12)
    |> Pdf.text_wrap!(
      {padding, cursor},
      {width - padding * 2, cursor - padding},
      String.trim(text)
    )
    |> Pdf.move_down(12)
  end
end
