package first;

class Hello {
    public void print_int(int i) {
        System.out.println("Just an integer : " + i); }

    public void print_nothing() {
        System.out.println("That's nothing"); }

    public static void main(String [] args) {
       // System.out.println("Howdy ?");
        Hello h = new Hello();
        h.print_nothing();
        h.print_int(42);
        h.print_nothing();
       // System.out.println("Hasta la vista ..."); 
        }
}
 