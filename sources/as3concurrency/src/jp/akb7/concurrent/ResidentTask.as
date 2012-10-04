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
        

        public function ResidentTask(runnable:ByteArray, name:String=null, sharedMemory:ByteArray=null, condition:Condition=null, mutex:Mutex=null ){
            super(runnable, name, sharedMemory, condition, mutex);
        }
        
        public final function invokeMethod(methodName:String,args:Array=null):Object{
            doInvoke(methodName,args);
            
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
            doInvokeAsync(methodName,args);
        }
        
        public override function terminate():void {
            if(_worker != null) {
                _inchannel.removeEventListener(Event.CHANNEL_MESSAGE, inchannel_channelMessageHandler);
            }
            super.terminate();
        }
        
        private function doInvoke(methodName:String,args:Array):void{
            if( args == null ){
                _outchannel.send([ResidentConsts.INVOKE,methodName]);     
            } else {
                _outchannel.send([ResidentConsts.INVOKE,methodName].concat(args));
            }
        }
        
        private function doInvokeAsync(methodName:String,args:Array):void{
            if( args == null ){
                _outchannel.send([ResidentConsts.INVOKE_ASYNC,methodName]);     
            } else {
                _outchannel.send([ResidentConsts.INVOKE_ASYNC,methodName].concat(args));
            }
        }
        
        private function inchannel_channelMessageHandler(e:Event):void {
            if(_inchannel.messageAvailable) {
                var data:Object=_inchannel.receive();
                doParseReceiveMessage(data);
            }
        }
        
        protected final override function doPrepare():void {
            setupMessageChannel();
            _inchannel.addEventListener(Event.CHANNEL_MESSAGE, inchannel_channelMessageHandler);
        }
    }
}