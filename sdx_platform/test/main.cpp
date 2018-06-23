/*  Test for SDSoC platform
*/

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "sds_lib.h"
#include "adder.h"


int main(int argc, char ** argv)
{    
	
    // Make a place to store the data from the file and the output of the EKF
    int N = 500;
    data_t *ain, *bin, *cout;
	ain = (data_t *)sds_alloc(N*sizeof(data_t));
	bin = (data_t *)sds_alloc(N*sizeof(data_t));
	cout = (data_t *)sds_alloc(N*sizeof(data_t));

	// random input data
	srand(time(NULL));
	for (int i=0; i<N; i++) {
		int r1 = rand()%100;
		int r2 = rand()%100;
		ain[i] = r1;
		bin[i] = r2;
	}
	
	// run adder test
	adder(ain, bin, cout, N);
	
	//check the results
	for (int i=0; i<N; i++) {
		printf("%d + %d = %d\n", ain[i], bin[i], cout[i]);
	}

	sds_free(ain);
    sds_free(bin);
    sds_free(cout);

    // Done!
    return 0;
}
