with Air_Data_Sensors; use Air_Data_Sensors;

package body Voter is

   function Vote_Best_Speed (L, R, S : Sensor_Reading) return Voting_Result is
      Diff_LR, Diff_RS, Diff_SL : Knots;
      Result : Voting_Result;
   begin
      Diff_LR := abs(L.Value - R.Value);
      Diff_RS := abs(R.Value - S.Value);
      Diff_SL := abs(S.Value - L.Value);

      if Diff_LR <= Diff_RS and then Diff_LR <= Diff_SL then
         Result.Speed  := (L.Value + R.Value) / 2.0;
         Result.Source := Pair_LR;

      elsif Diff_RS <= Diff_LR and then Diff_RS <= Diff_SL then
         Result.Speed  := (R.Value + S.Value) / 2.0;
         Result.Source := Pair_RS;

      else
         Result.Speed  := (S.Value + L.Value) / 2.0;
         Result.Source := Pair_SL;
      end if;

      return Result;
   end Vote_Best_Speed;

end Voter;
