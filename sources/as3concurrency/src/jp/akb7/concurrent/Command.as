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
package jp.akb7.concurrent {
    import flash.concurrent.Condition;
    import flash.concurrent.Mutex;
    import flash.display.Sprite;
    import flash.errors.IllegalOperationError;
    import flash.events.Event;
    import flash.system.MessageChannel;
    import flash.system.MessageChannelState;
    import flash.system.Worker;
    import flash.utils.ByteArray;
    
    public class Command extends Sprite implements Runnable {
        private var _mutex:Mutex;
        
        private var _condition:Condition;
        
        private var _name:String;
        
        private var _sharedMemory:ByteArray;
        
        private var _runnable:ByteArray;
        
        protected var _outchannel:MessageChannel;
        
        protected var _inchannel:MessageChannel;
        
        public function get mutex():Mutex {
            return _mutex;
        }
        
        public function get condition():Condition {
            return _condition;
        }
        
        public override function get name():String {
            return _name;
        }
        
        public function get sharedMemory():ByteArray {
            return _sharedMemory;
        }
        
        public function Command() {
            _mutex=Worker.current.getSharedProperty(Task.MUTEX);
            _condition=Worker.current.getSharedProperty(Task.CONDITION);
            _name=Worker.current.getSharedProperty(Task.NAME);
            _sharedMemory=Worker.current.getSharedProperty(Task.SHAREDMEMORY);
            
            if(this is AsyncCallable) {
                doCallAsync();
            } else if(this is Callable) {
                doCall();
            } else {
                run();
            }
        }
        
        public function run():void {
            throw new IllegalOperationError("not impl");
        }
        
        protected final function setResult(result:Object):void {
            if(_outchannel != null && _outchannel.state == MessageChannelState.OPEN) {
                _outchannel.send(result);
            }
        }
        
        protected function doCall():void {
            _outchannel=getOutChannel();
            _inchannel=getInChannel();
            var result:Object=(this as Callable).call();
            setResult(result);
            _outchannel=null;
        }
        
        protected function doCallAsync():void {
            _outchannel=getOutChannel();
            _inchannel=getInChannel();
            (this as AsyncCallable).callAsync();
        }
        
        protected function getOutChannel():MessageChannel {
            var channel:MessageChannel = Worker.current.getSharedProperty(FutureTask.OUT_CHANNEL);
            
            return channel;
        }
        protected function getInChannel():MessageChannel {
            var channel:MessageChannel = Worker.current.getSharedProperty(FutureTask.IN_CHANNEL);
            
            return channel;
        }
        
        protected function inchannel_channelMessageHandler(event:Event):void
        {    
        }
    }
}


