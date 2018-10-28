#include <iostream>
#include "B.h"

B::B() {}

void B::foo( void )
{
  std::cout << "B:foo" << std::endl;
}

void B::bar( void )
{
  std::cout << "bar" << std::endl ;
}
