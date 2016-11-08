#include <iostream>

using namespace std;

template <unsigned long N>
struct fact
{
  static unsigned const value = N*fact<N-1>::value;
  //static const auto value = fact<N-1>::value*N;      auto pour qu'il reconnaisse le type tout seul
};

template <>
struct fact<0>
{
  static unsigned const value = 1;
};

//créer un tableau pour chaque appel à fact. Il pose une limite à la taille de ce tableau
int main(void)
{
  cout << "1010 : " << fact<0>::value << endl;
  cout << "1110 : " << fact<1>::value << endl;
  cout << "1011 : " << fact<5>::value << endl;
}
 
