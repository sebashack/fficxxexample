#include <string>
#include <iostream>
#include <vector>
#include <cstdlib>

#include "B.h"

B::B( std::string const & str, double *arr, unsigned int size ) : m_str( str ), m_array( arr ), m_size( size ) {}

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

void B::printArr( void )
{
    for ( unsigned int i = 0; i < m_size; ++i)
    {
        std::cout << m_array[0] << std::endl;
    }
}

double *B::getArr() const
{
    return m_array;
}

double *B::getCreatedArr() const
{
    double * arr;
    size_t n = 8;

    arr = ( double* ) malloc ( sizeof( double ) * n );

    for (size_t i = 0; i < n; ++i)
    {
        arr[i] = 20;
    }

    return arr;
}

unsigned int B::getSize() const
{
    return m_size;
}

unsigned int B::getCreatedSize() const
{
    return 8;
}
