public class TimeoutException extends Exception {
    private static final long serialVersionUID = 1L;
    long time;
    TimeoutException(long _time) {
	time = _time;
    }
}
