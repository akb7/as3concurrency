package {
    import jp.akb7.concurrent.Command;
    
    public class HighLoadCommand extends Command {
        public override function run():void {
            trace("HighLoadRunnable.run() - start");
            
            for(var i:int=0; i < 100000; i++) {
                var s:String="" + i;
            }
            trace("HighLoadRunnable.run() - end : " + s);
			
        }
    }
}


