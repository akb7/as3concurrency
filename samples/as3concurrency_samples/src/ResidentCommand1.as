package
{
    import jp.akb7.concurrent.ResidentCommand;
    
    [SWF(width="0", height="0", frameRate="1")]
    public class ResidentCommand1 extends ResidentCommand
    {
        public function ResidentCommand1()
        {
            super();
            trace("ResidentCommand1:Strat,"+stage.frameRate);
        }
        
        public function test(i1:int,i2:int,i3:int):int{
            return i1+i2+i3;
        }
    }
}