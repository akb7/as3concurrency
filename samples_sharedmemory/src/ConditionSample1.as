package 
{
    import flash.concurrent.Condition;
    import flash.concurrent.Mutex;
    
    import jp.akb7.concurrent.Task;
    import jp.akb7.core.MainSprite;
    
    public class ConditionSample1 extends MainSprite{
        
        public function main():void{
            var m:Mutex = new Mutex();
            var c:Condition = new Condition(m);
            
            var task1:Task = new Task(Workers.ConditionCommand1,"commnad-1",null,c);
            var task2:Task = new Task(Workers.ConditionCommand1,"commnad-2",null,c);
            
            trace("main - commnads - start");
            task1.start();
            task2.start();
            
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