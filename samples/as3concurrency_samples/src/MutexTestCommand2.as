package 
{
    import jp.akb7.concurrent.WorkerSprite;

    public class MutexTestCommand2 extends WorkerSprite 
    {
        public override function run():void{
            
            if(mutex.tryLock()){
                trace(name+":MutexTestRunnable.run() - start");
                for (var i:int = 0; i < 10; i++) 
                {
                    trace(name+"["+i+"]");
                }
                trace(name+":MutexTestRunnable.run() - end : ");
            } else {
                trace(name+":MutexTestRunnable.run() - ng : ");
            }
        }
    }
}