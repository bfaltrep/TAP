import java.util.ArrayList;
import java.util.List;


public class Lambda {

	public static List<Integer> createList(){
		int size = 10;
		List<Integer> res = new ArrayList<Integer>(size);
		for (int i = 0; i < size; i++) {
			res.add((int)Math.round(Math.random()*50));
		}
		return res;
	}
	
	public static void printList(List<Integer> l){
		l.forEach(i -> System.out.println(i));
	}
	
	public static void sortList(List<Integer> l){
		l.sort((v1, v2) -> {return v1 - v2;});

	}
	
	public static void main(String[] args) {
		List<Integer> values = createList();
		/*
		 * Nous remarquons que la methode forEach est définit dans Iterable (java.lang.Iterable.forEach)
		 * le fait qu'elle soit par défaut implique que son code soit présent dans l'interface Iterable, et sera donc utilisable pour toutes classes qui l'étendent. 
		*/
		printList(values);
	
		/*
		 * l inference de type pour les lambdas expressions se sert du format de l (liste d'Integer) pour adapter le type des parametres du comparateur lambda (donc les types créés seront des Integer).
		*/
		sortList(values);
		System.out.println(" --- SORTED ---");
		printList(values);
	}

}
