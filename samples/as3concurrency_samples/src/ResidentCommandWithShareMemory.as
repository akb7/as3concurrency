package
{
    import jp.akb7.concurrent.ResidentCommand;
    
    [SWF(width="0", height="0", frameRate="1")]
    public class ResidentCommandWithShareMemory extends ResidentCommand
    {
        public function ResidentCommandWithShareMemory()
        {
            super();
            trace("ResidentCommandWithShareMemory:Strat,"+stage.frameRate);
        }
        
        public function test():void{
            sharedMemory.writeUnsignedInt(1);
        }
    }
}