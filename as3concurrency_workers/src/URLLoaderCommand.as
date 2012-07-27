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
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.net.registerClassAlias;
	import flash.system.Worker;
	import flash.utils.ByteArray;
	
	import jp.akb7.concurrent.AsyncCallable;
	import jp.akb7.concurrent.Command;
	
	public class URLLoaderCommand extends Command implements AsyncCallable
	{	
		{
			registerClassAlias("flash.net.URLRequest",flash.net.URLRequest);
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
			urlstream.addEventListener(SecurityErrorEvent.SECURITY_ERROR,urlstream_errorHandler);
			urlstream.addEventListener(IOErrorEvent.IO_ERROR,urlstream_errorHandler);
			urlstream.load(req);
		}
		
		protected function urlstream_completeHandler(event:Event):void
		{
			var ba:ByteArray = new ByteArray();
			var urlstream:URLStream = event.target as URLStream;
			urlstream.readBytes(ba,0,urlstream.bytesAvailable);
			setResult(ba);
		}
		
		protected function urlstream_errorHandler(event:Event):void
		{
			setResult(null);
		}
	}
}