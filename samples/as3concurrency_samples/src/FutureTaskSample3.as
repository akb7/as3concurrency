package {
    import flash.display.Sprite;
    
    import jp.akb7.concurrent.FutureTask;
    
    public class FutureTaskSample3 extends Sprite {
        
        public function FutureTaskSample3() {
            
            //同期処理1
            var task:FutureTask=new FutureTask(Workers.HighLoadCallableCommand);
            var result:String=task.getResult() as String;
            trace(result);
            
            task.terminate();
            task = null;
            trace(task);
            
            //同期処理2
            task=new FutureTask(Workers.HighLoadCallableCommand);
            result=task.getResult() as String;
            trace(result);
            
            task.terminate();
            task = null;
            trace(task);
        }
    }
}

