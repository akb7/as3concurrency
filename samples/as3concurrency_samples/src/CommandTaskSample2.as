package {
    import flash.display.Sprite;
    
    import jp.akb7.concurrent.events.CommandEvent;
    import jp.akb7.concurrent.CommandTask;
    
    public class CommandTaskSample2 extends Sprite {
        
        public function CommandTaskSample2() {
            //非同期処理
            var task:CommandTask=new CommandTask(Workers.HighLoadCallableCommand);
            task.addEventListener(CommandEvent.RESULT, task_resutlHandler);
            task.getResultAsync();
        }
        
        public function task_resutlHandler(e:CommandEvent):void {
            var task:CommandTask=e.target as CommandTask;
            var data:Object=e.data;
            trace(data);
        }
    }
}

