package 
{
    import jp.akb7.concurrent.Command;

    public class MutexTestCommand2 extends Command 
    {
        public override function run():void{
            
            if(mutex.tryLock()){
                trace(name+"MutexTestRunnable.run() - start");
                for (var i:int = 0; i < 10; i++) 
                {
                    trace(name+"["+i+"]");
                }
                trace(name+"MutexTestRunnable.run() - end : ");
            } else {
                trace(name+"MutexTestRunnable.run() - ng : ");
            }
        }
    }
}