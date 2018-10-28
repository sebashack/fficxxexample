#include <iostream>

#include "A.h"

A::A() { }

void A::foo()
{
    std::cout << "A:Foo" << std::endl;
}

void A::foo2( signed long t )
{
    std::cout << "A:Foo2 : got " << t << std::endl;
}
