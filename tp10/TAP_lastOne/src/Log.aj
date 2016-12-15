
public aspect Log {
    pointcut logStorageAdd(): execution(* Storage.addResource*(..));
    pointcut logStorageRemove(): execution(* Storage.removeResource*(..));
    
    after(): logStorageAdd() {
        System.out.println("Add to Storage"); 
        /*thisJoinPoint.getSignature().getName()*/
    }

	after(): logStorageRemove(){
		System.out.println("Remove from Storage"); 
        thisJoinPoint.getSignature().getName()
	}
}
