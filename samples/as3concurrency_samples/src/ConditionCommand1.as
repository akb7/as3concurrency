package 
{
    import jp.akb7.concurrent.Command;
    
    public class ConditionCommand1 extends Command 
    {
        public override function run():void {
            trace(name+"ConditionCommand.run() - wait");
            condition.mutex.lock();
            condition.wait();
            trace(name+"ConditionCommand.run() - start");
            for (var i:int = 0; i < 10; i++) 
            {
                trace(name+"["+i+"]");
            }
            trace(name+"ConditionCommand.run() - end : ");
            condition.mutex.unlock();
        }
    }
}