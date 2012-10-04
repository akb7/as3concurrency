package
{
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    
    import jp.akb7.concurrent.ResidentCommand;
    
    [SWF(width="0", height="0", frameRate="1")]
    public class ResidentCommandWithShareMemory2 extends ResidentCommand
    {
        public function ResidentCommandWithShareMemory2()
        {
            super();
            trace("ResidentCommandWithShareMemory:Strat,"+stage.frameRate);
        }
        
        public function getFillRect(w:int,h:int,color:uint):void{
            trace("ResidentCommandWithShareMemory:test,start");
            var bd:BitmapData = new BitmapData(100,100,false,color);
            var ba:ByteArray = new ByteArray();
            bd.copyPixelsToByteArray(new Rectangle(0,0,w,h),ba);
                        
            sharedMemory.writeBytes(ba,0,ba.bytesAvailable);
            
            bd.dispose();
            trace("ResidentCommandWithShareMemory:test,end");
        }
    }
}