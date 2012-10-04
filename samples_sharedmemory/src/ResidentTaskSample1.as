package {
    import jp.akb7.concurrent.ResidentTask;
    import jp.akb7.concurrent.events.CommandEvent;
    import jp.akb7.core.MainSprite;
    
    public class ResidentTaskSample1 extends MainSprite{
        
        
        public var task1:ResidentTask;
        public var task2:ResidentTask;
        
        public function main():void{
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
            
            task1.terminate();
            
            task2.start();
            task2.addEventListener(CommandEvent.RESULT,task_resultHandler);
            task2.addEventListener(CommandEvent.FAULT,task_faulttHandler);
            task2.invokeAsyncMethod("testTimeout",[7,8,9]);
            trace("called");
        }
        
        protected function task_resultHandler(event:CommandEvent):void
        {
            trace("sum:"+event.data);
        }
        protected function task_faulttHandler(event:CommandEvent):void
        {
            trace("error:"+event.data);
        }
        
        private function debugWorker():void
        {
            trace(task1.isRunning,task1.workerStatus);
            trace(task2.isRunning,task2.workerStatus);
        }
    }
}

