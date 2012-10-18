package {
    import jp.akb7.concurrent.Task;
    import jp.akb7.core.MainSprite;
    
    public class TaskSample2 extends MainSprite {
        public function main():void {
            var task:Task = new Task(Workers.ThrowErrorCommand);
            task.start();
        }
    }
}

