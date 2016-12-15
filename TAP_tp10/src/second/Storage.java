package second;
import java.util.Hashtable;

public class Storage {
    private Hashtable<String, Integer> store;

    public Storage() {
    	store = new Hashtable<String, Integer>();
    }

    public void addResource(String s, Integer i) 
	    throws LockedStorageException {
	if (store.containsKey(s)) {
	    Integer c = store.get(s);
	    store.put(s, c + i);
	} else {
	    store.put(s, i);
	}
	
	// Wait a bit to store the resource
	try { Thread.sleep(10); } 
	catch (InterruptedException e) { }
    }

    public void removeResource(String s, Integer i)
	    throws EmptyStorageException, LockedStorageException {
	try {
	    if (store.containsKey(s)) {
		Integer c = store.get(s);
		if (c >= i) {
		    store.put(s, c - i);
		} else {
		    throw new EmptyStorageException(s);
		}
	    } else {
		throw new EmptyStorageException(s);
	    }

	    // Wait a bit to unload the resource
	    try { Thread.sleep(10); } 
	    catch (InterruptedException e) { }
	} finally {}
    }

    public synchronized void display() {
	System.out.print("Store status : ");
	System.out.println(store);
    }

}
