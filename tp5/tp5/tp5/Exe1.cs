using System;
using System.Collections.Generic;
using System.Linq;

namespace tp5
{
	/*
	mcs puis mono
	 
	ajouter une méthode a une classe depuis l'extérieur :
	class foo{}

	static class other{
		public method(this MaClass){}
	}

	static class main{
		public main(){
			Foo f = new Foo();
			f.method();
		}
	}
	*/


	static class Delegate {
		public static IEnumerable<J> Flatten<T, J>(this IEnumerable<T> source)
			where T : IEnumerable<J> {
			foreach (T t in source)
				foreach (J j in t)
					yield return j;
		}

		public static void ForEach<T>(this IEnumerable<T> source,
			Action<T> action) {
			foreach (T element in source)
				action(element);
		}
	}

	class Exe1 {
		
		public class Vertex<T> {
			public T data { get; }

			public List<Vertex<T>> neighbors { get; }

			public Vertex(T _data) {
				data      = _data;
				neighbors = new List<Vertex<T>>();
			}

			public void AddNeighbor(Vertex<T> w) {
				if (!neighbors.Contains(w))
					neighbors.Add(w); 
			}

			public T GetData(){
				return data;
			}

			public List<Vertex<T>> GetNeighbors(){
				return neighbors;
			}

		};
			
		/* Q1 */

		public static List<Tuple<T,T>> GetEdges<T>(List<Vertex<T>> graph){
			List<Tuple<T,T>> res = new List<Tuple<T,T>> ();
			graph.ForEach((elmt) => {
				elmt.GetNeighbors().ForEach((subelmt) => {
					res.Add (new Tuple<T,T>(elmt.GetData(),subelmt.GetData()));
				});
			});

			return res;
		}

		/* Q2 */

		class Q2{

			int ContainAt<T>(T val1, List<Tuple<T,int>> list){
				for (int i = 0; i < list.Count; i++)
					if (list [i].Item1.Equals(val1))
						return i;
				return -1;
			}

			public List<Tuple<T,int>> MapCollect<T>(List<Vertex<T>> list){
				List<Tuple<T,int>> res = new List<Tuple<T,int>> ();

				for (int i = 0; i < list.Count; i++)
					res.Add(new Tuple<T,int>(list [i].GetData (),0));

				for(int i =0; i < list.Count; i++) {
					List<Vertex<T>> neightbors = list[i].GetNeighbors ();
					for (int j = 0; j < neightbors.Count; j++) {
						int tmp = ContainAt (neightbors[j].GetData (), res);
						if (tmp != -1)
							res [tmp] = new Tuple<T,int>(res[tmp].Item1, res [tmp].Item2+1);
					}
				}
				return res;
			}
		}

		public static void Main() {
			Random rnd = new Random();
			List<Vertex<int>> graph = new List<Vertex<int>>();

			for (int i = 0; i < 5; i++) // Create vertices
				graph.Add(new Vertex<int>(i));

			for (int i = 0; i < 5; i++) { // Add edges
				Vertex<int> v = graph[i];
				for (int j = 0; j < 5; j++)
					v.AddNeighbor(graph[rnd.Next(5)]);
			}
			int index = rnd.Next(5); // Add some more edges
			for (int i = 0; i < 5; i++)
				graph[i].AddNeighbor(graph[index]);

			Console.WriteLine (" --- --- --- --- Part1 --- --- --- --- ");

			List<Tuple<int,int>> q1 = GetEdges (graph);
			foreach(Tuple<int, int> i in q1)
				Console.WriteLine ("{0} -> {1}",i.Item1,i.Item2);

			Console.WriteLine (" --- --- --- --- Part2 --- --- --- --- ");

			Q2 q2 = new Q2 ();
			List<Tuple<int,int>> q2res = q2.MapCollect (graph);

			for(int i = 0; i < q2res.Count; i++)
				Console.WriteLine ("Data : {0} - nb occurence : {1}",q2res[i].Item1, q2res[i].Item2);
		}
	}
}

