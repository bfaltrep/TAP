using System;

namespace TAP_tp2
{
	public class ex1_toi
	{
		public delegate int Fun(int a, int b, Func<int, int, int> f);

		public static Fun execute = (a,b,f) => f(a,b);

		public static Func<int, int, int> addi = (a,b) => a+b;

		public static void Main() {
			
			Console.WriteLine(execute(5,2,addi));
		}

	}
}

