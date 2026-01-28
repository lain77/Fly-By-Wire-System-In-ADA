with Ada.Text_IO;       use Ada.Text_IO;
with Ada.Float_Text_IO;
with Air_Data_Sensors;  use Air_Data_Sensors;
with Voter;             use Voter;

procedure Main is

   protected Flight_State is
      procedure Land_Aircraft;
      function Is_Flying return Boolean;
   private
      Flying : Boolean := True;
   end Flight_State;

   protected body Flight_State is
      procedure Land_Aircraft is
      begin
         Flying := False;
      end Land_Aircraft;

      function Is_Flying return Boolean is
      begin
         return Flying;
      end Is_Flying;
   end Flight_State;

   package Knots_IO is new Ada.Text_IO.Fixed_IO(Knots);
   use Knots_IO;


   task Flight_Computer_Task;

   task body Flight_Computer_Task is
      Reading_L, Reading_R, Reading_S : Sensor_Reading;
      Consensus : Voting_Result;
      Cycle : Integer := 0;
   begin
      Init;
      Set_True_Airspeed(250.0);

      while Flight_State.Is_Flying loop
         Cycle := Cycle + 1;

         Reading_L := Read_Sensor(Left_Probe);
         Reading_R := Read_Sensor(Right_Probe);
         Reading_S := Read_Sensor(Standby_Probe);

         if Cycle = 10 then
            Put_Line("Right sensor failure");
            Inject_Failure(Right_Probe, True);
         end if;

         Consensus := Vote_Best_Speed(Reading_L, Reading_R, Reading_S);

         Put("CYCLE " & Integer'Image(Cycle) & " | ");

         Put("L:"); Put(Reading_L.Value, Fore=>3, Aft=>1, Exp=>0);
         Put(" R:"); Put(Reading_R.Value, Fore=>3, Aft=>1, Exp=>0);
         Put(" S:"); Put(Reading_S.Value, Fore=>3, Aft=>1, Exp=>0);

         Put(" | VOTE: " & Voting_Source'Image(Consensus.Source));
         Put(" => FINAL:"); Put(Consensus.Speed, Fore=>3, Aft=>1, Exp=>0);
         New_Line;

         delay 0.5;
      end loop;

      Put_Line("End flight system");
   end Flight_Computer_Task;

begin
   New_Line;
   Put_Line("Press [ENTER] to land");
   New_Line;

   Skip_Line;

   Put_Line("Landing aircraft");
   Flight_State.Land_Aircraft;

end Main;
