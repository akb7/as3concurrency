package {
    import jp.akb7.concurrent.WorkerSprite;
    import jp.akb7.concurrent.Task;
    
    public class NestCallCommand extends WorkerSprite {
        public override function run():void {
            trace("NestCallCommand.run() - start");
            new Task(Workers.HighLoadCommand).start();
            trace("NestCallCommand.run() - end");
        }
    }
}


