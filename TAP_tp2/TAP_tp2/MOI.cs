using System;

namespace Application
{
	public class MOI
	{
		// Type declaration
		public delegate int OneInt (int value);
		// Anonymous function
		public static OneInt square = new OneInt(i => i*i);
		// One-time declaration using predefined type
		public static Func<int, int> cube = i => i*i*i;
		// Delegate using multiple arguments
		public delegate void Concat (string s1, string s2);
		public static Concat c = (a,b) => Console.WriteLine(a+b);

		public static void Main() {
			Console.WriteLine("Caramba !");
		}
	}
}

