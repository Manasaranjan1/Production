@IsTest
public class Test_Schedule_CalculateDuration {
    
    @IsTest
    Public static void mymethod(){
        Test.startTest();
        Schedule_CalculateDuration sh1 = new Schedule_CalculateDuration();
        String sch = '0 0 23 * * ?'; 
        system.schedule('Test Shedule Class Check', sch, sh1);
        Test.stopTest();
    }   
}