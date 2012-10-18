package {
    import flash.utils.ByteArray;
    import flash.utils.setInterval;
    
    import jp.akb7.concurrent.ResidentTask;
    import jp.akb7.core.MainSprite;
    
    public class ResidentTaskShareMemorySample1 extends MainSprite {
        
        public var task1:ResidentTask;
        
        public var ba:ByteArray;
        
        public function main():void {
            ba = new ByteArray();
            task1=new ResidentTask(Workers.ResidentCommandWithShareMemory1,"s-1",ba);
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

