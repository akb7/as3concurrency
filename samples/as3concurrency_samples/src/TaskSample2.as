package {
    import flash.display.Sprite;
    
    import jp.akb7.concurrent.Task;
    
    public class TaskSample2 extends Sprite {
        public function TaskSample2() {
            var task:Task = new Task(Workers.ThrowErrorCommand);
			task.start();
        }
    }
}

