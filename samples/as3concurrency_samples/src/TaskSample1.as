package {
    import flash.display.Sprite;
    
    import jp.akb7.concurrent.Task;
    
    public class TaskSample1 extends Sprite {
        public function TaskSample1() {
            var task:Task = new Task(Workers.HighLoadCommand);
			task.start();
			task.terminate();
        }
    }
}

