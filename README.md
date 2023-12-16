## Dominance

Dominance is going to be a "Game Engine" that I will utilize in future games I develop. I say "Game Engine" because I don't know how extensive it will actually become.

## Developer Requirements

Currently, Dominance development is only supported on Ubuntu. For developers with Windows machines, they can develop on Dominance through WSL.
Due to internal use of the SFML library, developers will need to install some dependencies for the SFML library.

A dependency script is located at the following location: `scripts/dependencies.sh`

This script will install all the necessary package dependencies for SFML development. It is necessary to run this script in order to build Dominance.

## Third Party Libraries used in Dominance

- googletest
  ```
  libgmock
  libgmock_main
  libgtest
  libgtest_main
  ```
- SFML
  ```
  libsfml-aduio
  libsfml-graphics
  libsfml-network
  libsfml-system
  ```
