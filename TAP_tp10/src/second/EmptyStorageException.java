package second;

public class EmptyStorageException extends Exception {
    private static final long serialVersionUID = 1L;
    String res;
    public EmptyStorageException(String _s) {
	res = _s;
    }
}
