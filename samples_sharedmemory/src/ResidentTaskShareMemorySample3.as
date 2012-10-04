package {
    import flash.concurrent.Mutex;
    import flash.events.Event;
    import flash.net.registerClassAlias;
    import flash.utils.ByteArray;
    
    import data.UserInfo;
    
    import jp.akb7.concurrent.ResidentTask;
    import jp.akb7.concurrent.events.CommandEvent;
    import jp.akb7.core.MainSprite;
    
    public class ResidentTaskShareMemorySample3 extends MainSprite {
        
        public var task1:ResidentTask;
        
        public var ba:ByteArray;
		
		public var mutex:Mutex;
		
		public function init():void{
			registerClassAlias("data.UserInfo",UserInfo);
		}
		
		public function prepare():void{
			ba = new ByteArray();
			mutex = new Mutex();
			task1=new ResidentTask(Workers.ResidentCommandWithShareMemory3,"s-2",ba,null,mutex);
			task1.start();
		}
        
        public function main():void{
			task1.addEventListener(CommandEvent.RESULT,task1_getUserListStreamingResultHandler);
            task1.invokeAsyncMethod("getUserListStreaming",[100]) as Array;
			addEventListener(Event.ENTER_FRAME,on_enterFrameHandler);
        }
		
		protected function task1_getUserListStreamingResultHandler(event:CommandEvent):void
		{
			removeEventListener(Event.ENTER_FRAME,on_enterFrameHandler);
		}
		
		protected function on_enterFrameHandler(event:Event):void
		{
			var tryLock:Boolean = mutex.tryLock();
			trace("Main:tryLock"+tryLock);
			if( tryLock ){
				if( ba.bytesAvailable > 0 ){
					var user:UserInfo = ba.readObject() as UserInfo;
					trace(user.name);
					ba.clear();
					trace("Main:unlock");
				}
				mutex.unlock();
			}
		}
    }
}

