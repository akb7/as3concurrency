package {
    import jp.akb7.concurrent.Command;
    import jp.akb7.concurrent.Task;
    
    public class NestCallCommand extends Command {
        public override function run():void {
            trace("NestCallCommand.run() - start");
            new Task(Workers.HighLoadCommand).start();
            trace("NestCallCommand.run() - end");
        }
    }
}


