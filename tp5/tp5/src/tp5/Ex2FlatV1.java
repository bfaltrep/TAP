package tp5;

import java.util.ArrayList;
import java.util.List;

public class Ex2FlatV1<T> {
	public List<List<T>> matrix;
	
	public Ex2FlatV1(){
		matrix = new ArrayList<List<T>>();
	}
	
	public void init(T val){
		for (int i = 0; i < 5; i++) {
			matrix.add(new ArrayList<T>());
			for (int j = 0; j < 5; j++) {
				matrix.get(i).add(val);
			}
		}
	} 
	
	public void printBig(){
		for (int i = 0; i < 5; i++) {
			for (int j = 0; j < 5; j++) {
				System.out.print(matrix.get(i).get(j)+" ");
			}
			System.out.println();
		}
	}
	
	public List<T> flatten(){
		List<T> res = new ArrayList<T>();
		for(List<T> elmt : matrix) {
			res.addAll(elmt);
		}
		return res;
	}
	
	public static void main(String[] args) {
		Ex2FlatV1<Integer> val = new Ex2FlatV1<Integer>();
		val.init(new Integer(((int)(Math.random()*100))));		
		val.printBig();
		System.out.println("----");
		List<Integer> res = val.flatten();
		for(Integer i : res)
			System.out.print(i+" ");
		System.out.println();
	}

}
