package jp.akb7.concurrent {
    
    [ExcludeClass]
    public final class Fault {
		
        public var errrorID:int;
        
        public var name:*;
        
        public var message:*;
		
		public function Fault(){
			errrorID = 0;
			message = "Unknown";
			name = "jp.akb7.concurrent.Fault";
		}
    }
}


