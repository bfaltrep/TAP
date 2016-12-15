public interface CoordinationAction {
    //
    // This method is called  by Coordinator.guardedEntry(...) and
    // Coordinator.guardedExit(...). Use it for changing coordination state
    // upon entering and exiting methods.
    ///
    public void doit();
}
