package 
{
    import flash.display.Sprite;
    
    import jp.akb7.concurrent.FutureEvent;
    import jp.akb7.concurrent.FutureTask;
    
    public class FutureTaskSample2 extends Sprite{
        
        public function FutureTaskSample2(){
            //非同期処理
            var task:FutureTask = new FutureTask(Workers.HighLoadCallableCommand);
            task.addEventListener(FutureEvent.RESULT, task_resutlHandler);
            task.getResultAsync();
        } 
        
        public function task_resutlHandler(e:FutureEvent):void{
            var task:FutureTask = e.target as FutureTask;
            var data:Object = e.data;
            trace(data);
        }
    }
}