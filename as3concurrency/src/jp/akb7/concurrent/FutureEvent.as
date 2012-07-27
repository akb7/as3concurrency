package jp.akb7.concurrent 
{
    import flash.events.Event;
    
    public class FutureEvent extends Event
    {
        public static const RESULT:String = "result";
        
        public var data:Object;
        
        public function FutureEvent(type:String)
        {
            super(type,false,false);
        }
    }
}