//
// the Mutex class implements the Exclusion interface as a Mutex. 
// It is initialized with a list of strings being a list of method 
// names that must not be executed at the same time.  
//

class Mutex implements Exclusion {
	String[] methodNames;
	MethodState[] methodStates;

	String prettyName;

	Mutex(String[] _methodNames) {
		methodNames = _methodNames;
		methodStates = new MethodState[methodNames.length];
		for (int i = 0; i < methodNames.length; i++) {
			methodStates[i] = new MethodState();
		}
	}

	private MethodState getMethodState(String _methodName) {
		for (int i = 0; i < methodNames.length; i++) {
			if (_methodName.equals(methodNames[i]))
				return (methodStates[i]);
		}
		return (null);
	}

	//
	// Loop through each of the other methods in this exclusion set,
	// to be sure that no other thread is running them. Note that we 
	// have to be careful about selfex.
	//
	public boolean testExclusion(String _methodName) {
		Thread ct = Thread.currentThread();
		for (int i = 0; i < methodNames.length; i++) {
			if (!_methodName.equals(methodNames[i])) {
				if (methodStates[i].hasOtherThreadThan(ct))
					return (false);
			}
		}
		return (true);
	}

	//
	// Record the fact that the current thread is executing
	// a method called _methodName
	//
	public void enterExclusion(String _methodName) {
		MethodState methodState = getMethodState(_methodName);
		methodState.enterInThread(Thread.currentThread());
	}

	//
	// Record the fact that the current thread returns from 
	// a method called _methName
	//
	public void exitExclusion(String _methodName) {
		MethodState methodState = getMethodState(_methodName);
		methodState.exitInThread(Thread.currentThread());
	}

	//
	// Prints the list of the method names that are excluded 
	// in the current Mutex
	//
	public void printMethodNames() {
		System.out.print("Mutex names: ");
		for (int i = 0; i < methodNames.length; i++)
			System.out.print(methodNames[i] + " ");
		System.out.println();
	}
}
