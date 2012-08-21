package
{
    import jp.akb7.concurrent.ResidentCommand;
    
    [SWF(width="0", height="0", frameRate="1")]
    public class ResidentCommandWithShareMemory1 extends ResidentCommand
    {
        public function ResidentCommandWithShareMemory1()
        {
            super();
            trace("ResidentCommandWithShareMemory:Strat,"+stage.frameRate);
        }
        
        public function test():void{
            trace("ResidentCommandWithShareMemory:test,start");
            sharedMemory.writeUnsignedInt(1);
            trace("ResidentCommandWithShareMemory:test,end");
        }
    }
}