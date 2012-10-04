package
{
    import flash.net.registerClassAlias;
    
    import data.UserInfo;
    
    import jp.akb7.concurrent.ResidentCommand;
    
    [SWF(width="0", height="0", frameRate="1")]
    public class ResidentCommandWithShareMemory3 extends ResidentCommand
    {
        {
            registerClassAlias("data.UserInfo",UserInfo);
        }
        public function ResidentCommandWithShareMemory3()
        {
            super();
            trace("ResidentCommandWithShareMemory:Strat,"+stage.frameRate);
        }
        
        public function getUserListStreaming(value:int):Boolean{
            trace("ResidentCommandWithShareMemory3:getUserList,start");

            for (var i:int = 0; i < value; i++) 
            {
                var user:UserInfo = new UserInfo();
                user.uid = i;
                user.name = "Name"+i;
                
                do{
                }while(sharedMemory.bytesAvailable > 0 );
                
                this.mutex.lock();
                trace("ResidentCommandWithShareMemory3:lock");
                this.sharedMemory.writeObject(user);
                this.sharedMemory.position = 0;
                trace("ResidentCommandWithShareMemory3:unlock");
                this.mutex.unlock();
            }
            do{
            }while(sharedMemory.bytesAvailable > 0 );
            
            return true;

            trace("ResidentCommandWithShareMemory3:getUserList,end");
        }
    }
}