import java.util.Enumeration;
import java.util.Vector;

// 
// the MethodState class simply contains a vector of Threads 
//

class MethodState {

	Vector<Thread> threads = new Vector<Thread>();

	void enterInThread(Thread t) {
		threads.addElement(t);
	}

	void exitInThread(Thread t) {
		threads.removeElement(t);
	}

	boolean hasOtherThreadThan(Thread t) {
		Enumeration<Thread> e = threads.elements();
		while (e.hasMoreElements())
			if (e.nextElement() != t)
				return (true);
		return (false);
	}

}
