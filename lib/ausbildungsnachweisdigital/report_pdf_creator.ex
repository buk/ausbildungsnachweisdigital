template = """
= Ausbildungsnachweise

Ausbildungsnachweise von Sebastian Bachmann.

#table(
  columns: (auto, 1fr, auto),
  [*No*], [*Aktivität*], [*Dauer in Std.*],
  <%= reports %>
)
"""

defmodule Ausbildungsnachweisdigital.ReportPdfCreator do


  @activities ["Lorem Ipsum", "Lorem Ipsum Lorem Ipsum", "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum", "Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum", "Lorem Ipsum Lorem Ipsum Lorem Ipsum"]
  @durations [4, 2, 5, 2,8, 9]

  def build_reports(n) do 
    for n <- 1..n do 
      activities = "#{Enum.random(@activities)}"
      durations = "#{Enum.random(@durations)}"
      [n, activities, durations]
    end
  end
end

{:ok, pdf_binary} = ExTypst.render_to_pdf(template, 
  reports: ExTypst.Format.table_content(Ausbildungsnachweisdigital.ReportPdfCreator.build_reports(10))
)

File.write!("reports.pdf", pdf_binary)
IO.puts("Successfully written reports.pdf file")