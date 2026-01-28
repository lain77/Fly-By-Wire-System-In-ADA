package Air_Data_Sensors is


   type Knots is delta 0.1 range 0.0 .. 1000.0;

   type Sensor_ID is (Left_Probe, Right_Probe, Standby_Probe);
   

   type Sensor_Reading is record
      Value : Knots;
      Is_Valid : Boolean := True;
   end record;
   

   procedure Init;
   

   procedure Set_True_Airspeed(Speed : Knots);
   

   function Read_Sensor(ID : Sensor_ID) return Sensor_Reading;
   
   
   procedure Inject_Failure(ID : Sensor_ID; Broken : Boolean);

   
end Air_Data_Sensors;
