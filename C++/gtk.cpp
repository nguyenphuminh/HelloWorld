#include <iostream>
#include <gtkmm/main.h>
#include <gtkmm/button.h>
#include <gtkmm/window.h>
using namespace std;

class HelloWorld : public Gtk::Window {
public:
 HelloWorld();
 virtual ~HelloWorld();
protected:
 Gtk::Button m_button;
 virtual void on_button_clicked();
};

HelloWorld::HelloWorld()
: m_button("Hello World") {
 set_border_width(10);
 m_button.signal_clicked().connect(SigC::slot(*this,
 &HelloWorld::on_button_clicked));
 add(m_button);
 m_button.show();
}

HelloWorld::~HelloWorld() {}

void HelloWorld::on_button_clicked() {
 cout << "Hello, World!" << endl;
}

int main (int argc, char *argv[]) {
 Gtk::Main kit(argc, argv);
 HelloWorld helloworld;
 Gtk::Main::run(helloworld);
 return 0;
}
