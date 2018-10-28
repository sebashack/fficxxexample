#ifndef __B__
#define __B__

#include "A.h"

class B : public A
{
public:
    B();

    virtual void foo(void) override;

    void bar(void);
};

#endif
