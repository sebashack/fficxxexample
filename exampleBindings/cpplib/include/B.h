#ifndef __B__
#define __B__

#include <string>

#include "A.h"

class B : public A
{
public:
    B( std::string const & str, double *arr, unsigned int size );

    virtual void foo( void ) override;

    void bar( void );

    void printIt( void );

    void printArr( void );

    double *getArr() const;

    double *getCreatedArr() const;

    unsigned int getSize() const;

    unsigned int getCreatedSize() const;

    B makeObject() const;

private:
    std::string m_str;
    double  *m_array;
    unsigned int m_size;
};

#endif
