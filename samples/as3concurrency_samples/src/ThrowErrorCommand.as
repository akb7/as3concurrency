package {
    import jp.akb7.concurrent.Command;
    
    public class ThrowErrorCommand extends Command {
        public override function run():void {
            throw new Error("dummy error");
        }
    }
}


