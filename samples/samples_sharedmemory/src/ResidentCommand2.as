package
{
    import flash.utils.setInterval;
    import flash.utils.setTimeout;
    
    import jp.akb7.concurrent.ResidentCommand;
    
    [SWF(width="0", height="0", frameRate="1")]
    public class ResidentCommand2 extends ResidentCommand
    {
        public function ResidentCommand2()
        {
            super();
            trace("ResidentCommand1:Strat,"+stage.frameRate);
        }
        
        public function test(i1:int,i2:int,i3:int):int{
            for(var i:int=0; i < 100000; i++) {
                var s:String="" + i;
            }
            
            return i1+i2+i3;
        }

        public function testTimeout(i1:int,i2:int,i3:int):void{
            for(var i:int=0; i < 100000; i++) {
                var s:String="" + i;
            }
            
            setTimeout(cal,1000,i1,i2,i3);
        }
        
        private function cal(i1:int,i2:int,i3:int):void{
            setResult(i1+i2+i3);
        }
    }
}