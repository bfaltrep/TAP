
public class Consumer extends Thread {
	String resource;
	Storage store;
	int count;
	int timeout;
	
	public Consumer(String r, Storage s, int c, int t) {
	    resource = r;
	    store = s;
	    count = c;
	    timeout = t;
	}
	
	public void run() {
	    while(true) {
		try { store.removeResource(resource, new Integer(count)); }
		catch (Exception e) {}
		try { Thread.sleep(timeout); }
		catch (InterruptedException e) {}
	    }
	}
}
