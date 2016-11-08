#include <iostream>

using namespace std;

template <unsigned long N, int m>
struct tri
{
  static unsigned const value = N*fact<N-1>::value;
};

template <int N>
struct tri<0, N>
{
  static unsigned const value = 1;
};






int main(void)
{
  char Tableau [8] = {1, 2, 6, 5, 2, 1, 9, 8,};

  
  cout << "1010 : " << fact<0>::value << endl;
  cout << "1110 : " << fact<1>::value << endl;
  cout << "1011 : " << fact<5>::value << endl;
}
 
