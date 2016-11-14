using System;
using System.Collections.Generic;
using System.Linq;

namespace tp5
{
	/*
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

	class Program {
		
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

		public static List<Tuple<T,T>> getEdges<T>(List<Vertex<T>> graph){
			List<Tuple<T,T>> res = new List<Tuple<T,T>> ();
			graph.ForEach((elmt) => {
				elmt.GetNeighbors().ForEach((subelmt) => {
					res.Add (new Tuple<T,T>(elmt.GetData(),subelmt.GetData()));
				});
			});

			return res;
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

			Console.WriteLine (getEdges(graph));
		}
	}
}

