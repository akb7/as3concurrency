package {
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    import jp.akb7.concurrent.FutureTask;
    
    public class FutureTaskSample1 extends Sprite {
        
        public function FutureTaskSample1() {
            stage.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void{
            
            //同期処理
            var task:FutureTask=new FutureTask(Workers.HighLoadCallableCommand);
            var result:String=task.getResult() as String;
            trace(result);
            });
        }
    
    }
}

