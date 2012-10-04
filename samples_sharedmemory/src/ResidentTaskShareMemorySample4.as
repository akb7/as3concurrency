package {
    import flash.concurrent.Mutex;
    import flash.events.Event;
    import flash.net.registerClassAlias;
    import flash.utils.ByteArray;
    
    import data.UserInfo;
    
    import jp.akb7.concurrent.ResidentTask;
    import jp.akb7.concurrent.events.CommandEvent;
    import jp.akb7.core.MainSprite;
    
    public class ResidentTaskShareMemorySample4 extends MainSprite {
        
        public var task1:ResidentTask;
        
        public var ba:ByteArray;
        
        public var mutex:Mutex;
        
        public var list:Array;
        
        public function init():void{
            registerClassAlias("data.UserInfo",UserInfo);
            list = [];
        }
        
        public function prepare():void{
            ba = new ByteArray();
            mutex = new Mutex();
            task1=new ResidentTask(Workers.ResidentCommandWithShareMemory4,"s-2",ba,null,mutex);
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
            readShareMemory();
            ba.clear();
            trace("list.length",list.length);
        }
        
        protected function on_enterFrameHandler(event:Event):void
        {
            readShareMemory();
        }
        
        private function readShareMemory():void
        {
            mutex.lock();
            trace("Main:lock");
            while( ba.bytesAvailable > 0 ){
                var user:UserInfo = ba.readObject() as UserInfo;
                trace(user.name);
                list.push(user);
            }
            mutex.unlock();
            trace("Main:unlock");
            
        }
    }
}

