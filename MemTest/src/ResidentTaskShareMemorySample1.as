package {
    import flash.display.Sprite;
    import flash.utils.ByteArray;
    
    import jp.akb7.concurrent.ResidentTask;
    
    public class ResidentTaskShareMemorySample1 extends Sprite {
        
        public var task1:ResidentTask;
        
        public var ba:ByteArray;
        
        public function ResidentTaskShareMemorySample1() {
            task1=new ResidentTask(Workers.ResidentCommandWithShareMemory1,"s-1");
            task1.start();
            var a:int = task1.invokeMethod("test") as int;
            trace("ba:"+a);
        }
    }
}

