package second;

public aspect Log {
	final static boolean ENABLED = true;
	
	pointcut logStorage(): if (Log.ENABLED) && (call (* Storage.*(..)) && !call(* Storage.display*(..)));
	
    after(): logStorage() {
        System.out.println("Storage "+thisJoinPoint.getSignature().getName()+" "+thisJoinPoint.getArgs()[1]+" "+thisJoinPoint.getArgs()[0].toString()); 
        ((Storage)thisJoinPoint.getTarget()).display();
    }
}