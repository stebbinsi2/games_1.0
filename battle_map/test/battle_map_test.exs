defmodule BattleMapTest do
  use ExUnit.Case
  doctest BattleMap


  # You May Use The Following Test Suite To Validate Your Solution.
  defmodule BarbarianTests do

    describe "Barbarian" do
      test "can attack within two squares of current position" do
        for x <- 2..6, y <- 2..6 do
          assert Character.can_attack?(%Barbarian{}, {4, 4}, {x, y})
        end
      end

      test "cannot attack beyond two squares of current position" do
        refute Character.can_attack?(%Barbarian{}, {4, 4}, {1, 1})
        refute Character.can_attack?(%Barbarian{}, {4, 4}, {7, 7})
        refute Character.can_attack?(%Barbarian{}, {4, 4}, {7, 1})
        refute Character.can_attack?(%Barbarian{}, {4, 4}, {1, 7})
      end

      test "logic is not hardcoded to the {4, 4} position" do
        refute Character.can_attack?(%Barbarian{}, {3, 3}, {6, 6})
      end
    end
  end
end
