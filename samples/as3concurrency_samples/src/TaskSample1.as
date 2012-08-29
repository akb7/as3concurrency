package {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    
    import jp.akb7.concurrent.Task;
    
    public class TaskSample1 extends Sprite {
        public function TaskSample1() {
			stage.addEventListener(MouseEvent.CLICK,function(event:Event):void{
            var task:Task = new Task(Workers.HighLoadCommand);
			task.start();
			trace(1);
			task.terminate();
			trace(2);
			});
        }
    }
}

