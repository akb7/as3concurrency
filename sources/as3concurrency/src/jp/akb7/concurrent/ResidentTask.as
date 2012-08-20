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
package jp.akb7.concurrent
{
    import flash.concurrent.Condition;
    import flash.concurrent.Mutex;
    import flash.events.Event;
    import flash.utils.ByteArray;
    
    public class ResidentTask extends Task
    {
        public static const INVOKE:String="jp.akb7.concurrent.ResidentTask.invoke";
        
        public function ResidentTask(runnable:ByteArray, name:String=null, condition:Condition=null, mutex:Mutex=null, sharedMemory:ByteArray=null)
        {
            super(runnable, name, condition, mutex, sharedMemory);
        }
        
        public final function invokeMethod(methodName:String,args:Array=null):Object{
            _outchannel.send([INVOKE,methodName].concat(args));
            var result:Object = _inchannel.receive(true);
            if(result is Fault) {
                var f:Fault=result as Fault;
                var error:Error=new Error(f.message, f.errrorID);
                error.name=f.name;
                throw error;
            }
            return result;
        }
        
        public final function invokeAsyncMethod(methodName:String,args:Array=null):void{
            _outchannel.send([INVOKE,methodName].concat(args));            
            _inchannel.addEventListener(Event.CHANNEL_MESSAGE, inchannel_channelMessageHandler);
        }
        
        private function inchannel_channelMessageHandler(e:Event):void {
            //メッセージチャンネルにメッセージがあるかどうか
            if(_inchannel.messageAvailable) {
                //メッセージチャンネルに受信
                var data:Object=_inchannel.receive();
                doParseReciveMessage(data);
                _inchannel.removeEventListener(Event.CHANNEL_MESSAGE, inchannel_channelMessageHandler);
            }
        }
        
        protected final override function doPrepare():void {
            setupMessageChannel();
        }
    }
}