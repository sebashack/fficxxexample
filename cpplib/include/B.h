#ifndef __B__
#define __B__

#include <string>

#include "A.h"

class B : public A
{
public:
    B( std::string const & str );

    virtual void foo( void ) override;

    void bar( void );

    void printIt( void );

private:
    std::string const m_str;
};

#endif
