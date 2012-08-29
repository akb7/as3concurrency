package {
    import jp.akb7.concurrent.Callable;
    import jp.akb7.concurrent.Command;
    
    public class ThrowErrorCallableCommand extends Command implements Callable {
        public function call():Object {
			throw new Error("dummy error");
            return null;
        }
    }
}


