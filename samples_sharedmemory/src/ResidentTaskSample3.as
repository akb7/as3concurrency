package {
    import flash.net.registerClassAlias;
    import flash.utils.ByteArray;
    
    import data.UserInfo;
    
    import jp.akb7.concurrent.ResidentTask;
    import jp.akb7.concurrent.events.CommandEvent;
    import jp.akb7.core.MainSprite;
    
    public class ResidentTaskSample3 extends MainSprite{
        
        public var task1:ResidentTask;
        
        public var ba:ByteArray;
        
        public function init():void{
            registerClassAlias("data.UserInfo",UserInfo);
        }
        
        public function prepare():void{
            task1=new ResidentTask(Workers.ResidentCommand3);
            task1.start();
        }
        
        public function main():void{
            //同期処理
            var list:Array = task1.invokeMethod("getUserList",[100000]) as Array;
            trace(list.length);
            
            //非同期処理
            task1.addEventListener(CommandEvent.RESULT,task1_getUserListResult);
            task1.invokeAsyncMethod("getUserList",[100000]);
        }
        
        protected function task1_getUserListResult(event:CommandEvent):void
        {
            var list:Array = event.data as Array;
            trace(list.length);
        }
    }
}

