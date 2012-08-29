package {
    import flash.display.Sprite;
    
    import jp.akb7.concurrent.CommandTask;
    
    public class CommandTaskSample1 extends Sprite {
        
        public function CommandTaskSample1() {
            //同期処理
            var task:CommandTask=new CommandTask(Workers.HighLoadCallableCommand);
            var result:String=task.getResult() as String;
            trace(result);
        }
    }
}

