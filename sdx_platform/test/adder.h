/*  Test for SDSoC platform
*/

typedef int data_t;

#ifdef __cplusplus
extern "C" {
#endif

#pragma SDS data access_pattern(ain:SEQUENTIAL, bin:SEQUENTIAL, cout:SEQUENTIAL)
#pragma SDS data copy(ain[0:N], bin[0:N], cout[0:N])
#pragma SDS data data_mover(ain:AXIDMA_SIMPLE, bin:AXIDMA_SIMPLE, cout:AXIDMA_SIMPLE)
#pragma SDS data mem_attribute(ain:PHYSICAL_CONTIGUOUS, bin:PHYSICAL_CONTIGUOUS, cout:PHYSICAL_CONTIGUOUS)
void adder(data_t *ain, data_t *bin, data_t *cout, int N);

#ifdef __cplusplus
}
#endif

