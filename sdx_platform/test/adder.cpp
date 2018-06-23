/*  Test for SDSoC platform
*/

#include "adder.h"

// top function
void adder(data_t *ain, data_t *bin, data_t *cout, int N)
{

    for (int i=0; i<N; i++) { 
		cout[i] = ain[i] + bin[i];
    }

}
