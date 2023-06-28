defmodule Ausbildungsnachweisdigital.GoalsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ausbildungsnachweisdigital.Goals` context.
  """

  @doc """
  Generate a goal.
  """
  def goal_fixture(attrs \\ %{}) do
    {:ok, goal} =
      attrs
      |> Enum.into(%{
        completed: true,
        content: "some content",
        deadline: ~D[2023-06-27],
        title: "some title"
      })
      |> Ausbildungsnachweisdigital.Goals.create_goal()

    goal
  end
end
