package {
    import flash.display.Sprite;
    
    import jp.akb7.concurrent.FutureTask;
    
    public class FutureTaskSample1 extends Sprite {
        
        public function FutureTaskSample1() {
            //同期処理
            var task:FutureTask=new FutureTask(Workers.HighLoadCallableCommand);
            var result:String=task.getResult() as String;
            trace(result);
        }
    
    }
}

