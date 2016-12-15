import java.util.Vector;

public class Method {
    String name;
    Vector<Exclusion> exclusions = new Vector<Exclusion>(3);

    Method(String n) {
      name = n;
    }

    void addExclusion(Exclusion ex) {
      exclusions.addElement(ex);
    }

    void removeExclusion(Exclusion ex) {
      for (int i = 0; i < exclusions.size(); i++) {
        if (exclusions.elementAt(i) == ex)
  	exclusions.removeElementAt(i);
      }
    }
}
