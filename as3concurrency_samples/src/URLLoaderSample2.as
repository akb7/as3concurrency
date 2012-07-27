package 
{
    import flash.display.Sprite;
    import flash.net.URLRequest;
    import flash.utils.ByteArray;
    
    import jp.akb7.concurrent.events.FutureEvent;
    import jp.akb7.concurrent.URLLoader;
	
    public class URLLoaderSample2 extends Sprite{
        public function URLLoaderSample2(){
			var req:URLRequest = new URLRequest("test.txt");
			var loader:URLLoader = new URLLoader()
			loader.addEventListener(FutureEvent.RESULT,loader_resultHandler,false,0,true);
			loader.loadAsync(req);
        }
		
		protected function loader_resultHandler(event:FutureEvent):void
		{
			var text:ByteArray = event.data as ByteArray;
			trace(text.readUTFBytes(text.bytesAvailable));
		}
	}
} 