package tp5;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class Ex2FlatV2 {
	/* 1.3.3 du cours : List<T> flatten List<? extends List<? extends T>>*/
	public class Flat<T>{
		
		public List<? extends T> flatten (List<? extends List<? extends T>> list){
			List<T> res = new ArrayList<T>(); //on ne peut pas utiliser la wildcard ici
			for(int i = 0 ; i < list.size() ; i++)
				res.addAll(list.get(i));
			return res;
		}
	}

	public static void init_list(List<List<Integer>> list){
		for(int i = 0 ; i < 10 ; i++){
			list.add(new ArrayList<Integer>());
			for (int j = 0; j < 5 ; j++) {
				list.get(i).add(((int)(Math.random()*100)));
			}
			
		}
	}
	
	public static void init_arraylist(List<ArrayList<Integer>> list){
		for(int i = 0 ; i < 10 ; i++){
			list.add(new ArrayList<Integer>());
			for (int j = 0; j < 5 ; j++) {
				list.get(i).add(((int)(Math.random()*100)));
			}
		}
	}
	
	public static void main(String[] args) {
		//init
		Ex2FlatV2 ex2 = new Ex2FlatV2();
		Flat<Integer> flat = ex2.new Flat<Integer>();
		
		List<List<Integer>> l1 = new ArrayList<List<Integer>>();
		init_list(l1);
		List<ArrayList<Integer>> l2 = new ArrayList<ArrayList<Integer>>();
		init_arraylist(l2);
		
		//usage
		List<? extends Integer> res1 = flat.flatten(l1);
		List<? extends Integer> res2 = flat.flatten(l2);
		
		//resultat
		for(Integer i : res1)
			System.out.print(i+" ");
		System.out.println(" -- ");
		
		for(Integer i : res2)
			System.out.print(i+" ");
		System.out.println();
	}
}
