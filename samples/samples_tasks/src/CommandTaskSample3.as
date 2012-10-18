package {
    import jp.akb7.concurrent.CommandTask;
    import jp.akb7.core.MainSprite;
    
    public class CommandTaskSample3 extends MainSprite {
        public function main():void {
            
            //同期処理1
            var task:CommandTask=new CommandTask(Workers.HighLoadCallableCommand);
            var result:String=task.getResult() as String;
            trace(result);
            
            //同期処理2
            task=new CommandTask(Workers.HighLoadCallableCommand);
            result=task.getResult() as String;
            trace(result);
        }
    }
}

