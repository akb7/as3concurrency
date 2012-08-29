package {
    import flash.display.Sprite;
    import flash.net.URLRequest;
    import flash.utils.ByteArray;
    
    import jp.akb7.concurrent.events.CommandEvent;
    import jp.akb7.concurrent.URLLoader;
    
    public class URLLoaderSample2 extends Sprite {
        public function URLLoaderSample2() {
            var req:URLRequest=new URLRequest("tests.txt");
            var loader:URLLoader=new URLLoader()
            loader.addEventListener(CommandEvent.RESULT, loader_resultHandler, false, 0, true);
            loader.addEventListener(CommandEvent.FAULT, loader_faultHandler, false, 0, true);
            loader.loadAsync(req);
        }
        
        protected function loader_resultHandler(event:CommandEvent):void {
            var text:ByteArray=event.data as ByteArray;
            trace(text.readUTFBytes(text.bytesAvailable));
        }
        
        protected function loader_faultHandler(event:CommandEvent):void {
            trace(event.data);
        }
    }
}

