package {
    import flash.display.Sprite;
    import flash.utils.setInterval;
    
    import jp.akb7.concurrent.ResidentTask;
    import jp.akb7.concurrent.events.FutureEvent;
    
    public class ResidentTaskSample1 extends Sprite {
        
        public var task:ResidentTask;
        
        public function ResidentTaskSample1() {
            task=new ResidentTask(Workers.ResidentCommand1);
            debugWorker();
            
            task.start();
            
            var sum:Object = task.invokeMethod("test",[1,2,3]);
            trace("sum:"+sum);
            
            var sum1:Object = task.invokeMethod("test",[4,5,6]);
            trace("sum:"+sum1);
            
            task.addEventListener(FutureEvent.RESULT,task_resultHandler);
            task.invokeAsyncMethod("test",[7,8,9]);
            trace("called");
            
            setInterval(debugWorker,1000);
        }
        
        protected function task_resultHandler(event:FutureEvent):void
        {
            trace("sum:"+event.data);
        }
        
        private function debugWorker():void
        {
            trace(task.isRunning,task.workerStatus);
        }
    }
}

