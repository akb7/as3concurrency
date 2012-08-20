package 
{
    import flash.concurrent.Condition;
    import flash.concurrent.Mutex;
    import flash.display.Sprite;
    
    import jp.akb7.concurrent.Task;
    
    public class ConditionSample1 extends Sprite{
        
        public function ConditionSample1(){
            var m:Mutex = new Mutex();
            var c:Condition = new Condition(m);
            
            var th1:Task = new Task(Workers.ConditionCommand1,"commnad-1",c);
            var th2:Task = new Task(Workers.ConditionCommand1,"commnad-2",c);
            
            trace("main - commnads - start");
            th1.start();
            th2.start();
            
            trace("main - load");
            for (var i:int = 0; i < 1000000; i++) 
            {
                var s:String = ""+i;
            }
            
            trace("main - commnad - notifyAll");
            c.mutex.lock();
            c.notifyAll();
            c.mutex.unlock();
        }         
    }
}