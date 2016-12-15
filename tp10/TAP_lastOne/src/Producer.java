class Producer extends Thread {
	String resource;
	Storage store;
	int count;
	int timeout; 
	
	public Producer(String r, Storage s, int c, int t) {
	    resource = r;
	    store = s;
	    count = c;
	    timeout = t;
	}
	
	public void run() {
	    while(true) {
		try { store.addResource(resource, count); }
		catch (Exception e) {}
		try { Thread.sleep(timeout); }
		catch (InterruptedException e) { }
	    }
	}
}