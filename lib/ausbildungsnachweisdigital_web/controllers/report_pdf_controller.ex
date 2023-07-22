defmodule AusbildungsnachweisdigitalWeb.ReportPdfController do
	use AusbildungsnachweisdigitalWeb, :controller

	alias Ausbildungsnachweisdigital.ReportPdfCreator


	def download() do
		

		pdf = ReportPdfCreator.build_reports(10)

		
		# pdf = ReportPdfCreator.build_employes(report)
		# filename = report.id
	end
end