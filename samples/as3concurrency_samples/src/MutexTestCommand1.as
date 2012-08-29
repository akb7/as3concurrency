package 
{
    import jp.akb7.concurrent.WorkerSprite;
    
    public class MutexTestCommand1 extends WorkerSprite 
    {
        public override function run():void{
            
            mutex.lock();
            trace(name+":MutexTestRunnable.run() - start");
            for (var i:int = 0; i < 10; i++) 
            {
                trace(name+"["+i+"]");
            }
            trace(name+":MutexTestRunnable.run() - end : ");
            mutex.unlock();
        }
    }
}