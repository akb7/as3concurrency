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
    import flash.errors.IllegalOperationError;
    import flash.events.Event;
    
    public class ResidentCommand extends Command
    {
        public function ResidentCommand()
        {
            super();
        }
        
        public override final function run():void {
            _outchannel=getOutChannel();
            _inchannel=getInChannel();
            _inchannel.addEventListener(Event.CHANNEL_MESSAGE, inchannel_channelMessageHandler);
        }
        
        public function doInvoke(mesasges:Array):void{
            var funcName:String = mesasges.shift();
            
            try{
                var f:Function = this[funcName];
                var result:Object = f.apply(null,mesasges);
                setResult(result);
            } catch(e:Error){
                var fault:Fault=new Fault();
                fault.errrorID = e.errorID;
                fault.message = e.message;
                fault.name = e.name;
                setResult(result);
            }
        }
        
        protected override function inchannel_channelMessageHandler(event:Event):void
        {    
            if (_inchannel.messageAvailable)
            {
                var data:Object = _inchannel.receive();
                if( data is Array ){
                    var mesasges:Array = data as Array;
                    if( mesasges.length > 0 ){
                        var methodName:String = mesasges.shift();
                        if( methodName == "jp.akb7.concurrent.ResidentTask.invoke"){
                            doInvoke(mesasges);
                        }
                    }
                }
            }
        }
    }
}