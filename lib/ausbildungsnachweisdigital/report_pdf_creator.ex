# template = """
# = Ausbildungsnachweise
# 
# Ausbildungsnachweise von Sebastian Bachmann.
# 
# #table(
#   columns: (auto, 1fr, auto),
#   [*No*], [*Aktivität*], [*Dauer in Std.*],
#   <%= reports %>
# )
# """

defmodule Ausbildungsnachweisdigital.ReportPdfCreator do
  def to_pdf(report) do
    {:ok, pdf_binary} =
      ExTypst.render_to_pdf("template",
        reports: ExTypst.Format.table_content(to_pdf(report))
      )

    File.write!("reports.pdf", pdf_binary)
    IO.puts("Successfully written reports.pdf file")
  end
end
