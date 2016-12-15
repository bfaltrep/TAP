public class Main {
    
    public static void main(String[] args) {
	Storage storage = new Storage();
	System.out.println("Starting my small enterprise");
	Producer[] ps = {
		new Producer("Cranberry", storage, 1, 10),
		new Producer("Cranberry", storage, 1, 10),		
		new Producer("Cranberry", storage, 1, 10),		
	};
	Consumer[] cs = {
		new Consumer("Cranberry", storage, 1, 10),
		new Consumer("Cranberry", storage, 1, 10),
		new Consumer("Cranberry", storage, 1, 10),
	};
	for (int i = 0; i < ps.length; i++)
	    ps[i].start();
	for (int i = 0; i < cs.length; i++)
	    cs[i].start();
    }
    
}
