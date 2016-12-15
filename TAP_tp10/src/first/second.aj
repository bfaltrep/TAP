package first;
aspect SECOND {
    pointcut justints(int x): execution(* first.Hello.*(int)) && args(x);
    before(int x) : justints(x) {
        System.out.println(" SECOND:"+x+" " + 
          thisJoinPoint.getSignature().getName()); 
    }
    
    after(int x) : justints(x){
    	System.out.println(" ENDSECOND "+x);
    }
}