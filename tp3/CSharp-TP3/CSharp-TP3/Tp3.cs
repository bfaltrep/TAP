using System;
using System.Collections.Generic;

namespace CSharpTP3{
	
	public static class MainClass
	{
		public static List<T> Map<T2, T>(List<T2> l, Func<T2, T> fgen){
			List<T> l_res = new List<T>(l.Count);
			foreach (T2 tval in l) {
				l_res.Add(fgen(tval));
			}
			return l_res;
		}

		public static Dictionary<T,List<T2>> Convert<T, T2>(List<KeyValuePair<T,T2>> l){
			Dictionary<T,List<T2>> dico = new Dictionary<T, List<T2>>();
			foreach (KeyValuePair<T,T2> lval in l) {
				if (!dico.ContainsKey (lval.Key)) {
					List<T2> val = new List<T2> ();
					val.Add (lval.Value);
					dico.Add (lval.Key, val);
				} else {
					List<T2> tmp = dico [lval.Key];
					tmp.Add(lval.Value);
				}
			}
			return dico;
		}

		public static void Main ()
		{

			List<KeyValuePair <int, string>> list = new List<KeyValuePair <int, string>> ();

			list.Add (new KeyValuePair<int, string> (1, "un"));
			list.Add (new KeyValuePair<int, string> (7, "sept"));
			list.Add (new KeyValuePair<int, string> (1, "uno"));

			List<int> keys = Map (list, i => i.Key);
			foreach (int k in keys)
				Console.WriteLine ("{0} : {1}", k, list.Find (i => (i.Key == k)).Value);
			
			Console.WriteLine ("");Console.WriteLine (" -- ");Console.WriteLine ("");

			Dictionary<int, List<string>> dic = Convert (list);
			foreach (KeyValuePair<int, List<string>> entry in dic) {
				Console.WriteLine ("{0}",entry.Key);
				foreach(string elmt in entry.Value)
					Console.WriteLine ("    {0}",elmt);
			}
		}

	}
}
/*
Différence entre programmation générique C# et Ocaml : 
	En C#, il faut préciser énormément d'informations sur le générique, 
	là ou le Caml a une inférence de type et la curryfication qui allègent le code.
*/
