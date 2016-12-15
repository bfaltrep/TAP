using System;
using System.Linq;
using System.Collections.Generic;

class tp9 {
	public class Thread {
		public int Workload {get; set;} 
		public int Pid      {get; private set;} 
		private IEnumerator<int> Worker;  // an enumerator for these parts
		public Thread() {
			Workload = 0;
			Pid      = rng.Next() % 100 + 100;
			Worker   = CreateWorker(this).GetEnumerator();
		}

		public int Work() {
			int load = Worker.Current;
			Workload += load;
			Worker.MoveNext();
			return load;
		}

		// Work processor (metaphorized)
		static Random rng = new Random();
		static IEnumerable<int> CreateWorker(Thread p) {
			while (true) {
				int load = rng.Next() % 9 + 1;
				Console.WriteLine("{0} : working for {1} hours (total load : {2})", 
					p.Pid, load, p.Workload);
				yield return load;
			}
		}
	}

	static void Main(string[] args) {
		Console.WriteLine("Yield !");
		var ListOfThreads = new List<Thread>();
		for (int i = 0; i < 10; i++) {
			var processor = new Thread();
			ListOfThreads.Add(processor);
		}
		Thread p;
		for (int i=0; i<500; i++) {
			p = ListOfThreads.Aggregate((curp, next) => { 
				if (next.Workload < curp.Workload) 
					return next; 
				else return curp; });
			p.Work();
		}
	}
}