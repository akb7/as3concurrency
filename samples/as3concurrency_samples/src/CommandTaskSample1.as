package {
    import jp.akb7.concurrent.CommandTask;
    import jp.akb7.core.MainSprite;
    
    public class CommandTaskSample1 extends MainSprite {
		public function main():void {
            //同期処理
            var task:CommandTask=new CommandTask(Workers.HighLoadCallableCommand);
            var result:String=task.getResult() as String;
            trace(result);
        }
    }
}

