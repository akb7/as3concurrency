package
{
    import flash.net.registerClassAlias;
    
    import data.UserInfo;
    
    import jp.akb7.concurrent.ResidentCommand;
    
    [SWF(width="0", height="0", frameRate="1")]
    public class ResidentCommandWithShareMemory4 extends ResidentCommand
    {
        {
            registerClassAlias("data.UserInfo",UserInfo);
        }
        public function ResidentCommandWithShareMemory4()
        {
            super();
            trace("ResidentCommandWithShareMemory:Strat,"+stage.frameRate);
        }
        
        public function getUserListStreaming(value:int):Boolean{
            trace("ResidentCommandWithShareMemory4:getUserList,start");

            for (var i:int = 0; i < value; i++) 
            {
                var user:UserInfo = new UserInfo();
                user.uid = i;
                user.name = "Name"+i;
                
                this.mutex.lock();
                trace("ResidentCommandWithShareMemory4:lock");
                this.sharedMemory.writeObject(user);
                trace("ResidentCommandWithShareMemory4:unlock");
                this.mutex.unlock();
            }
            
            do{
            }while(sharedMemory.bytesAvailable > 0 );
            
            return true;

            trace("ResidentCommandWithShareMemory4:getUserList,end");
        }
    }
}