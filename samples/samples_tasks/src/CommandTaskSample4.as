package {
    import jp.akb7.concurrent.CommandTask;
    import jp.akb7.concurrent.events.CommandEvent;
    import jp.akb7.core.MainSprite;
    
    public class CommandTaskSample4 extends MainSprite {
        public function main():void {
            
            //同期処理1
            var task:CommandTask=new CommandTask(Workers.ThrowErrorCallableCommand);
            try{
                var result:String=task.getResult() as String;
            }catch(e:Error){
                trace(e);
            }
            
            //同期処理2
            task=new CommandTask(Workers.ThrowErrorCallableCommand);
            task.addEventListener(CommandEvent.RESULT, task_resutlHandler);
            task.addEventListener(CommandEvent.FAULT, task_faultHandler);
            task.getResultAsync();
        }
        
        public function task_resutlHandler(e:CommandEvent):void {
            var task:CommandTask=e.target as CommandTask;
            var data:Object=e.data;
            trace(data);
        }
        public function task_faultHandler(e:CommandEvent):void {
            var task:CommandTask=e.target as CommandTask;
            var data:Object=e.data;
            trace(data);
        }
    }
}

