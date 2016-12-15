package second;
public interface Condition {

    //
    // This method is called automatically by Coordinator.guardedEntry(...)
    // and it's called everytime the coordination state changes.
    //
    public boolean checkit();
}
