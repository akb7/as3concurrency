package {
    import jp.akb7.concurrent.Task;
    import jp.akb7.core.MainSprite;
    
    public class TaskSample1 extends MainSprite {
		public function main():void {
            var task:Task = new Task(Workers.HighLoadCommand);
			task.start();
        }
    }
}

