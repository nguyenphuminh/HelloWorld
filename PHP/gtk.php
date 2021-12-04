<?php
$wnd = new GtkWindow();
$wnd->set_title('Hello');
$wnd->connect_simple('destroy', array('gtk', 'main_quit'));
$lblHello = new GtkLabel("Hello world'");
$wnd->add($lblHello);
$wnd->show_all();
Gtk::main();
?>
