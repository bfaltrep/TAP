using System;
using System.Collections.Generic;
using System.Linq;

namespace tp4
{
	class Program {
		private static List<string> people = new List<string>() 
		{ 
			"Robert", "Roger", "Raymond", "Remi", 
			"Radicowl", "Ross", "Rififi", "Rossinante" 
		};

		// ---- Part I

		private static void partOne(){
			IEnumerable<string> query_initial = from p in people select p;
			//Q1
			IEnumerable<string> query_order = from p in people where p.Length>5 orderby p descending select p;
			//Q2
			IEnumerable<string> query_q2 = people.Where(p => p.Length>5).OrderByDescending(p => p); 
			/*Q3 : TODO
				- On doit utiliser la programmation .

				- L'avantage du système orienté méthode est l'utilisation des fonctions anonymes

			*/
			Console.WriteLine("------ Initial ------");
			foreach (string person in query_initial) 
				Console.WriteLine(person);
			Console.WriteLine("------ query oriented ------");
			foreach (string person in query_order) 
				Console.WriteLine(person);
			Console.WriteLine("------ method oriented ------");
			foreach (string person in query_q2) 
				Console.WriteLine(person);
		}

		// ---- Part II

		private static T Fold<T, T2>(Func<T, T2, T> fgen,T init, IEnumerator<T2> list){
			while (list.MoveNext ()) {
				T2 val = list.Current;
				init = fgen (init,val);
			}
			return init;
		}
		/*
		Q7 : TODO
		*/
		private static void partTwo(){
			Console.WriteLine("------ Part II ------");
			Console.WriteLine(Fold((acc, x) => acc+x,"", people.GetEnumerator()));
			Console.WriteLine("------ Part II - 2 ------");
			Console.WriteLine(Fold((acc, x) => acc+1,0, people.GetEnumerator()));
		}

		public static void Main() 
		{
				partOne();
				partTwo();
		}
	}
}

