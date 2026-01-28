with Air_Data_Sensors; use Air_Data_Sensors;

package Voter is

   type Voting_Source is (Pair_LR, Pair_RS, Pair_SL, Failure);

   type Voting_Result is record
      Speed  : Knots;
      Source : Voting_Source;
   end record;

   function Vote_Best_Speed (L, R, S : Sensor_Reading) return Voting_Result;

end Voter;
