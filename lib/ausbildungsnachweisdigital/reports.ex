defmodule Ausbildungsnachweisdigital.Reports do
  @moduledoc """
  The Reports context.
  """

  import Ecto.Query, warn: false
  alias Ausbildungsnachweisdigital.Repo

  alias Ausbildungsnachweisdigital.Reports.Report

  defp reports_to_typst_table(reports) do
    reports
    |> Enum.with_index(1)
    |> Enum.map(fn {%Report{} = r, row_number} ->
      [row_number, r.activity, r.duration]
    end)
  end

  @spec reports_to_pdf :: {:ok, binary} | {:error, any}
  def reports_to_pdf do
    template = """
    = Ausbildungsnachweise

    #table(
      columns: (auto, 1fr, auto),
      [*No*], [*Tätigkeiten*], [*Ca. dauer in Stunden*],
      <%= reports %>
    )
    """

    reports = list_reports()
    table_content = reports_to_typst_table(reports)

    ExTypst.render_to_pdf(template,
      reports: ExTypst.Format.table_content(table_content)
    )
  end

  @spec report_to_pdf(id :: integer) :: {:ok, binary} | {:error, any}
  def report_to_pdf(id) do
    template = """
    = Ausbildungsnachweis

    Aktivität: <%= report.activity %>

    Dauer: <%= report.duration %>
    """

    report = get_report!(id)

    ExTypst.render_to_pdf(template, report: report)
  end

  @doc """
  Returns the list of reports.

  ## Examples

      iex> list_reports()
      [%Report{}, ...]

  """
  def list_reports do
    Repo.all(Report)
  end

  def list_reports_by_apprentice_id(apprentice_id) do
    query = from(r in Report, where: r.apprentice_id == ^apprentice_id)
    Repo.all(query)
  end

  @doc """
  Gets a single report.

  Raises `Ecto.NoResultsError` if the Report does not exist.

  ## Examples

      iex> get_report!(123)
      %Report{}

      iex> get_report!(456)
      ** (Ecto.NoResultsError)

  """
  def get_report!(id), do: Repo.get!(Report, id)

  @doc """
  Creates a report.

  ## Examples

      iex> create_report(%{field: value})
      {:ok, %Report{}}

      iex> create_report(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_report(attrs \\ %{}) do
    %Report{}
    |> Report.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a report.

  ## Examples

      iex> update_report(report, %{field: new_value})
      {:ok, %Report{}}

      iex> update_report(report, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_report(%Report{} = report, attrs) do
    report
    |> Report.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a report.

  ## Examples

      iex> delete_report(report)
      {:ok, %Report{}}

      iex> delete_report(report)
      {:error, %Ecto.Changeset{}}

  """
  def delete_report(%Report{} = report) do
    Repo.delete(report)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking report changes.

  ## Examples

      iex> change_report(report)
      %Ecto.Changeset{data: %Report{}}

  """
  def change_report(%Report{} = report, attrs \\ %{}) do
    Report.changeset(report, attrs)
  end
end
