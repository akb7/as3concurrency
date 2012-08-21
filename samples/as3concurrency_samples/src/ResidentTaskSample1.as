package {
    import flash.display.Sprite;
    import flash.utils.setInterval;
    
    import jp.akb7.concurrent.ResidentTask;
    import jp.akb7.concurrent.events.FutureEvent;
    
    public class ResidentTaskSample1 extends Sprite {
        
        public var task1:ResidentTask;
        public var task2:ResidentTask;
        
        public function ResidentTaskSample1() {
            task1=new ResidentTask(Workers.ResidentCommand1);
            task2=new ResidentTask(Workers.ResidentCommand2);
            debugWorker();
            
            task1.start();
            
            var date:Date = task1.invokeMethod("getDate") as Date;
            trace("date:"+date);
            
            var sum:Object = task1.invokeMethod("test",[1,2,3]);
            trace("sum:"+sum);
            
            var sum1:Object = task1.invokeMethod("test",[4,5,6]);
            trace("sum:"+sum1);
            
            try{
                var sum2:Object = task1.invokeMethod("tesat",[4,5,6]);
                trace("sum:"+sum2);
            }catch(e:Error){
                trace(e.name+":"+e.message);
            }
            
            task2.start();
            task2.addEventListener(FutureEvent.RESULT,task_resultHandler);
            task2.invokeAsyncMethod("test",[7,8,9]);
            trace("called");
            
            setInterval(debugWorker,1000);
        }
        
        protected function task_resultHandler(event:FutureEvent):void
        {
            trace("sum:"+event.data);
        }
        
        private function debugWorker():void
        {
            trace(task1.isRunning,task1.workerStatus);
            trace(task2.isRunning,task2.workerStatus);
        }
    }
}

