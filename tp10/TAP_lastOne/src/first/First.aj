aspect FIRST {
    pointcut hello(): execution(* first.Hello.*(..));
    before() : hello() {
        System.out.println("f : " + 
          thisJoinPoint.getSignature().getName()); 
    }
    
    after() : hello(){
    	System.out.println("ef");
    }
}
 