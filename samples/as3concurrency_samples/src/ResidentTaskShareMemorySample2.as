package {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    import flash.utils.setInterval;
    
    import jp.akb7.concurrent.ResidentTask;
    
    public class ResidentTaskShareMemorySample2 extends Sprite {
        
        public var task1:ResidentTask;
        
        public var ba:ByteArray;
        
        public function ResidentTaskShareMemorySample2() {
            ba = new ByteArray();
            task1=new ResidentTask(Workers.ResidentCommandWithShareMemory2,"s-2",ba);
            debugWorker();
            
            task1.start();
            
            trace("ba:"+ba.bytesAvailable);
            task1.invokeMethod("getFillRect",[100,100,0xFF0000]);
            trace("ba:"+ba.bytesAvailable);
            
            var bdba:ByteArray = new ByteArray();
            ba.readBytes(bdba,0,ba.bytesAvailable);
            
            var bd:BitmapData = new BitmapData(100,100);
            bd.setPixels(new Rectangle(0,0,100,100),bdba);
            
            addChild(new Bitmap(bd));
            
            setInterval(debugWorker,1000);
        }
        
        private function debugWorker():void
        {
            trace(task1.isRunning,task1.workerStatus);
            trace("ba:"+ba.bytesAvailable);
        }
    }
}

