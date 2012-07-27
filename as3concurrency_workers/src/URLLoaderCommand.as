/*****************************************************
 *  
 *  Copyright 2012 AKABANA.  All Rights Reserved.
 *  
 *****************************************************
 *  The contents of this file are subject to the Mozilla Public License
 *  Version 1.1 (the "License"); you may not use this file except in
 *  compliance with the License. You may obtain a copy of the License at
 *  http://www.mozilla.org/MPL/
 *   
 *  Software distributed under the License is distributed on an "AS IS"
 *  basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 *  License for the specific language governing rights and limitations
 *  under the License.
 *   
 *  
 *  The Initial Developer of the Original Code is AKABANA.
 *  Portions created by AKABANA are Copyright (C) 2012 AKABANA
 *  All Rights Reserved. 
 *  
 *****************************************************/
package 
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.net.registerClassAlias;
	import flash.system.Worker;
	import flash.utils.ByteArray;
	
	import jp.akb7.concurrent.AsyncCallable;
	import jp.akb7.concurrent.Command;
	import jp.akb7.concurrent.Fault;
	
	public class URLLoaderCommand extends Command implements AsyncCallable
	{	
		{
			registerClassAlias("flash.net.URLRequest",flash.net.URLRequest);
            registerClassAlias("jp.akb7.concurrent.Fault",jp.akb7.concurrent.Fault);
		}
		
		public function URLLoaderCommand(){
			super();   
		}
				  
		public function callAsync():void{
			
			var req:URLRequest = Worker.current.getSharedProperty("jp.akb7.concurrent.URLLoaderCommand.request") as URLRequest;
			if( req == null ){
				return;
			}
			var urlstream:URLStream = new URLStream();
			urlstream.addEventListener(Event.COMPLETE,urlstream_completeHandler);
            urlstream.addEventListener(HTTPStatusEvent.HTTP_STATUS,urlstream_httpStatusHandler);
			urlstream.addEventListener(SecurityErrorEvent.SECURITY_ERROR,urlstream_securityErrorHandler);
			urlstream.addEventListener(IOErrorEvent.IO_ERROR,urlstream_ioErrorHandler);
            try{
			    urlstream.load(req);
            } catch(e:Error){
                setError(e.errorID,e.name,e.message);
            }
		}
        
        protected function urlstream_httpStatusHandler(event:HTTPStatusEvent):void
        {
            if( event.status >= 400 ){
                setError(event.status,event.type,event.responseURL);
            }
        }
		
		protected function urlstream_completeHandler(event:Event):void
		{
			var ba:ByteArray = new ByteArray();
			var urlstream:URLStream = event.target as URLStream;
			urlstream.readBytes(ba,0,urlstream.bytesAvailable);
			setResult(ba);
		}
        
        protected function urlstream_securityErrorHandler(event:SecurityErrorEvent):void
        {
            setError(event.errorID,event.type,event.text);
        }
		
		protected function urlstream_ioErrorHandler(event:IOErrorEvent):void
		{
            setError(event.errorID,event.type,event.text);
		}
        
        protected function setError(errorID:int,name:*,message:*):void
        {
            var f:Fault = new Fault();
            f.errrorID = errorID;
            f.name = name;
            f.message = message;
            setResult(f);
        }
	}
}