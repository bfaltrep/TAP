#include <stdio.h>

int i = 0;
int f (int j) { i = i + j;  return i; }

int main(void) {
  f(1); printf("%d, ", i); 
  f(2); printf("%d, ", i); 
  i=421; f(2); printf("%d \n", i); 
} 
