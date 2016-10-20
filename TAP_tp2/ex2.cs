using System;
using Gtk;

namespace TAP_tp2
{
	public class ex2
	{

		public static bool actif = true;

		public delegate void Click (object o, EventArgs args);

		public static Click onClick_ping = (o, args) => {if(actif){actif = false; Console.WriteLine("I am ping", o);}};
		public static Click onClick_pong = (o, args) => {if(!actif){actif = true; Console.WriteLine("I am pong", o);}};


		public static void Main() {

			actif = true;
			Application.Init();

			//Create the Window
			Window myWin = new Window("Brave new world");
			myWin.Resize(200,200);
			HBox myBox = new HBox (false, 10);
			myWin.Add(myBox);

			// Set up a ping button object.
			Button ping = new Button ("Ping");
			ping.Clicked += new EventHandler(onClick_ping);
			myBox.Add(ping);

			// Set up a pong button object.
			Button pong = new Button ("Pong");
			pong.Clicked += new EventHandler(onClick_pong);
			myBox.Add(pong);

			//Show Everything     
			myWin.ShowAll(); 
			Application.Run(); }
	}
}

