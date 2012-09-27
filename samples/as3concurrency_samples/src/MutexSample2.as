package 
{
    import flash.concurrent.Mutex;
    import flash.display.Sprite;
    
    import jp.akb7.concurrent.Task;
    
    public class MutexSample2 extends Sprite{
        
        public function MutexSample2(){
            var m:Mutex = new Mutex();
            
            var task1:Task = new Task(Workers.MutexTestCommand2,"command-1",null,null,m);
            var task2:Task = new Task(Workers.MutexTestCommand2,"command-2",null,null,m);
            
            trace("command - start");
            task1.start();
            task2.start();
        }         
    }
}