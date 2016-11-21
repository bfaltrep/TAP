package tp5;

import java.util.ArrayList;
import java.util.List;

public class Ex2 {
	
	// -- classes
	
	public class Q3{
		public int data = 6;
	}
	
	public class Q2 extends Q3{
		public int data = 5;
		
	}
	
	public class Q2Son extends Q2{
		public Q2Son(){super.data = 4;}
		
		public void decrement(){
			super.data --;
		}
	}
	
	// -- methods
	
	public static int getPreuve(List<? extends Q2> q){
		return q.get(0).data;
	}
	
	public static String putPreuve(List<? super Q2> q, Ex2 e){
		q.add(e.new Q2());
		return q.get(q.size()-1).toString();
	}
	
	public static int bothPreuve(List<Q2> q, Ex2 e){
		q.add(e.new Q2());
		return q.get(q.size()-1).data;
	}
	
	// -- better presentation
	
	public static void getQ2(){
		//ok
		List<Number> list = new ArrayList<Number>();
		List<Integer> list2 = new ArrayList<Integer>();
		
		//pas ok : 
		// car meme si Number est parent de Integer, ce sont deux classes différentes.
		//List<Number> list3 = new ArrayList<Integer>(); 
		//List<Integer> list4 = new ArrayList<Number>();
	}
	
	public static void getQ3(){
		List<? extends Number> list = new ArrayList<Float>();
		Number m = new Integer(1);
		// ne peut pas marcher car on a utilisé extends qui ne permet pas l'écriture.
		//list.add(m); 
		Number n = list.get(0);
	}
	
	public static void getQ4(){
		List<? super Integer> list = new ArrayList<Number>();
		List<? super Integer> list2 = new ArrayList<Integer>();
		
		Integer m = new Integer(1);
		list.add(m);
		Number m2 = new Integer(1);
		// ne peut pas marcher car m2 est un Number et que nous ne pouvons donc pas certifié qu'il est un Integer.
		//list.add(m2);
		
		
	}
	
	public static void main(String[] args) {
		Ex2 e = new Ex2();
		List<Q2> preuve = new ArrayList<Q2>();
		for (int i = 0; i < 10; i++) {
			preuve.add(e.new Q2Son());
		}
		
		for(Q2 p : preuve){
			System.out.print(p.data);
		}
		System.out.println();
		/*
		 Q2 : ne peut pas marcher, 
		 car preuve est une liste de Q2 et non de sa sous-classe Q2Son. 
		 Or, il n'y a aucune relation reconnue entre les deux.
		*/
		//preuve.get(0).decrement();
		
		/*
		 Q3:
		*/
		//System.out.println(e.getPreuve(new ArrayList<Q2Son>(){{add(e.new Q2Son()); add(e.new Q2Son());}}));
		
		
		
	}

}