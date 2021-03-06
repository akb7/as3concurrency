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
    import flash.display.Sprite;
    import flash.events.UncaughtErrorEvent;
    import flash.system.MessageChannel;
    import flash.system.Worker;
    import flash.utils.ByteArray;
    
    import jp.akb7.concurrent.errors.WorkerError;
    
    internal class WorkerSprite extends Sprite {
        
        private var _name:String;

        private var _mutex:Mutex;
        
        private var _condition:Condition;
        
        private var _sharedMemory:ByteArray;

        protected var _outchannel:MessageChannel;
        
        protected var _inchannel:MessageChannel;
        
        public final override function get name():String {
            return _name;
        }


        public final function get mutex():Mutex {
            return _mutex;
        }
        
        public final function get condition():Condition {
            return _condition;
        }
        
        public final function get sharedMemory():ByteArray {
            return _sharedMemory;
        }

        public function WorkerSprite():void{
            _name=Worker.current.getSharedProperty(TaskConsts.NAME);

            _mutex=Worker.current.getSharedProperty(TaskConsts.MUTEX);
            _condition=Worker.current.getSharedProperty(TaskConsts.CONDITION);
            _sharedMemory=Worker.current.getSharedProperty(TaskConsts.SHAREDMEMORY);

            loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,loaderInfo_uncaughtErrorHandler);
            run();
        }
        
        public function run():void {
            throw new WorkerError("not impl");
        }
        
        protected function loaderInfo_uncaughtErrorHandler(event:UncaughtErrorEvent):void
        {
            if( event.error is WorkerError){
                return;
            }
            event.stopImmediatePropagation();
            event.preventDefault();
        }
    }
}


