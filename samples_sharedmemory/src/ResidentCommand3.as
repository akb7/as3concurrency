package
{
    import flash.net.registerClassAlias;
    
    import data.UserInfo;
    
    import jp.akb7.concurrent.ResidentCommand;
    
    [SWF(width="0", height="0", frameRate="1")]
    public class ResidentCommand3 extends ResidentCommand
    {
		{
			registerClassAlias("data.UserInfo",UserInfo);
		}
		
        public function ResidentCommand3()
        {
            super();
            trace("ResidentCommand3:Strat,"+stage.frameRate);
        }
        
        public function getUserList(value:int):Array{
            trace("ResidentCommand33:getUserList,start");

			var result:Array = [];
			
			for (var i:int = 0; i < value; i++) 
			{
				var user:UserInfo = new UserInfo();
				user.uid = i;
				user.name = "Name"+i;
				result.push(user);
			}
			trace("ResidentCommand33:getUserList,end");
			
			return result;
        }
    }
}