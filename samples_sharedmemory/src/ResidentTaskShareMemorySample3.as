package {
    import flash.utils.ByteArray;
    
    import jp.akb7.concurrent.ResidentTask;
    import jp.akb7.core.MainSprite;
    
    public class ResidentTaskShareMemorySample3 extends MainSprite {
        
        public var task1:ResidentTask;
        
        public var ba:ByteArray;
        
        public function main():void {
            ba = new ByteArray();
            task1=new ResidentTask(Workers.ResidentCommandWithShareMemory3,"s-2",ba);
            //debugWorker();
            
            task1.start();
            
            trace("ba:"+ba.bytesAvailable);
            var list:Array = task1.invokeMethod("getUserList",[100]) as Array;
            trace("ba:"+ba.bytesAvailable);

        }
        
        private function debugWorker():void
        {
            trace(task1.isRunning,task1.workerStatus);
            trace("ba:"+ba.bytesAvailable);
        }
    }
}

