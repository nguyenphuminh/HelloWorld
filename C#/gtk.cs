using Gtk;
using GtkSharp;
using System;

class Hello {
 static void Main()
 {
   Application.Init ();

   Window window = new Window("");
   window.DeleteEvent += cls_evn;
   Button close = new Button ("Hello world");
   close.Clicked += new EventHandler(cls_evn);

   window.Add(close);
   window.ShowAll();

   Application.Run ();
 }
 static void cls_evn(object obj, EventArgs args)
 {
   Application.Quit();
 }
}
