defmodule Ausbildungsnachweisdigital.ReportsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ausbildungsnachweisdigital.Reports` context.
  """

  @doc """
  Generate a report.
  """
  def report_fixture(attrs \\ %{}) do
    {:ok, report} =
      attrs
      |> Enum.into(%{
        activity: "some activity",
        duration: 42
      })
      |> Ausbildungsnachweisdigital.Reports.create_report()

    report
  end
end
