package {
    import flash.net.URLRequest;
    import flash.utils.ByteArray;
    
    import jp.akb7.concurrent.URLLoader;
    import jp.akb7.core.MainSprite;
    
    public class URLLoaderSample1 extends MainSprite {
        public function main():void {
            var req:URLRequest=new URLRequest("tests.txt");
            
            try {
                var text:ByteArray=new URLLoader().load(req) as ByteArray;
                trace(text.readUTFBytes(text.bytesAvailable));
            } catch(e:Error) {
                trace(e);
            }
        }
    }
}

