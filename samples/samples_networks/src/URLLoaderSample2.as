package {
    import flash.net.URLRequest;
    import flash.utils.ByteArray;
    
    import jp.akb7.concurrent.URLLoader;
    import jp.akb7.concurrent.events.CommandEvent;
    import jp.akb7.core.MainSprite;
    
    public class URLLoaderSample2 extends MainSprite {
        public function main():void {
            var req:URLRequest=new URLRequest("test.txt");
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

