package 
{
    import flash.concurrent.Mutex;
    
    import jp.akb7.concurrent.Task;
    import jp.akb7.core.MainSprite;
    
    public class MutexSample2 extends MainSprite{
        
        public function main():void{
            var m:Mutex = new Mutex();
            
            var task1:Task = new Task(Workers.MutexTestCommand2,"command-1",null,null,m);
            var task2:Task = new Task(Workers.MutexTestCommand2,"command-2",null,null,m);
            
            trace("command - start");
            task1.start();
            task2.start();
        }         
    }
}