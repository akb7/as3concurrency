package {
    import flash.display.Sprite;
    
    import jp.akb7.concurrent.CommandTask;
    
    public class CommandTaskSample3 extends Sprite {
        
        public function CommandTaskSample3() {
            
            //同期処理1
            var task:CommandTask=new CommandTask(Workers.HighLoadCallableCommand);
            var result:String=task.getResult() as String;
            trace(result);
            
            task = null;
            trace(task);
            
            //同期処理2
            task=new CommandTask(Workers.HighLoadCallableCommand);
            result=task.getResult() as String;
            trace(result);
            
            task = null;
            trace(task);
        }
    }
}

