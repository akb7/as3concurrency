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
package { 

    import flash.system.Worker;
    
    import jp.akb7.concurrent.AsyncCallable;
    import jp.akb7.concurrent.Command;

    public class FileLoaderCommand extends Command implements AsyncCallable {
        
        private var _path:String;
        
        public function FileLoaderCommand() {
            super();
        }
        
        public function callAsync():void {
            _path=Worker.current.getSharedProperty("jp.akb7.concurrent.FileLoaderCommand.path") as String;
            
            if(_path == null) {
                return;
            }
        }
    }
}


