#include <SFML/Window/VideoMode.hpp>
#include <SFML/Window.hpp>
#include <iostream>

int main(){
  
  sf::Window window(sf::VideoMode(800, 800), "My First Window!", sf::Style::Default);
  window.setVerticalSyncEnabled(true);  
  while(window.isOpen())
  {
    
    sf::Event event;
    while(window.pollEvent(event))
    {
      if(event.type == sf::Event::Closed)
      {
        window.close();
      }
    }
  }
  
  return 0;
}
