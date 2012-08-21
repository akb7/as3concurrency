package {
    import flash.display.Sprite;
    import flash.utils.ByteArray;
    import flash.utils.setInterval;
    
    import jp.akb7.concurrent.ResidentTask;
    
    public class ResidentTaskShareMemorySample1 extends Sprite {
        
        public var task1:ResidentTask;
        
        public var ba:ByteArray;
        
        public function ResidentTaskShareMemorySample1() {
            
            ba = new ByteArray();
            ba.shareable = true;
            
            task1=new ResidentTask(Workers.ResidentCommandWithShareMemory,"s-1",null,null,ba);
            debugWorker();
            
            task1.start();
            
            trace("ba:"+ba.bytesAvailable);
            task1.invokeMethod("test");
            trace("ba:"+ba.bytesAvailable);
            
            setInterval(debugWorker,1000);
        }
        
        private function debugWorker():void
        {
            trace(task1.isRunning,task1.workerStatus);
            trace("ba:"+ba.bytesAvailable);
        }
    }
}

