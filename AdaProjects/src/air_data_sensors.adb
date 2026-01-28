with Ada.Numerics.Float_Random;
use Ada.Numerics.Float_Random;

package body Air_Data_Sensors is


   Current_True_Airspeed : Knots := 0.0;


   Gens : array (Sensor_ID) of Generator;


   Broken_Sensors : array (Sensor_ID) of Boolean := (others => False);


   procedure Init is
   begin
      for S in Sensor_ID loop
         Reset(Gens(S));
      end loop;
   end Init;


   procedure Set_True_Airspeed(Speed : Knots) is
   begin
      Current_True_Airspeed := Speed;
   end Set_True_Airspeed;


   procedure Inject_Failure(ID : Sensor_ID; Broken : Boolean) is
   begin
      Broken_Sensors(ID) := Broken;
   end Inject_Failure;


   function Read_Sensor(ID : Sensor_ID) return Sensor_Reading is
      Reading : Sensor_Reading;
      Noise : Float;
      Raw_Val : Float;
   begin
      if Broken_Sensors(ID) then
         Reading.Value := 0.0;
         Reading.Is_Valid := False;
         return Reading;
      end if;


      Noise := (Random(Gens(ID)) * 4.0) - 2.0;


      Raw_Val := Float(Current_True_Airspeed) + Noise;


      if Raw_Val < 0.0 then
         Raw_Val := 0.0;
      elsif Raw_Val > 1000.0 then
            Raw_Val := 1000.0;
      end if;

      Reading.Value := Knots(Raw_Val);
      Reading.Is_Valid := True;

      return Reading;
     end Read_Sensor;


end Air_Data_Sensors;
