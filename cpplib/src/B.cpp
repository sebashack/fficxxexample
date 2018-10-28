#include <string>
#include <iostream>

#include "B.h"

B::B( std::string const & str ) : m_str( str ) {}

void B::foo( void )
{
    std::cout << "B:foo" << std::endl;
}

void B::bar( void )
{
    std::cout << "bar" << std::endl ;
}

void B::printIt( void )
{
    std::cout << m_str << std::endl ;
}
