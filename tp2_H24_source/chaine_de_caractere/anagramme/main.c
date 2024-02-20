#include <stdio.h>
#include <stdint.h>

extern int32_t anagramme(void);

int main(void) {
    int32_t a = anagramme();
    if (a==0) printf("String1 est une anagramme de String2\n");
    if (a==1) printf("Les deux String n'ont pas la même longueur, aucun anagramme\n");
    if (a==255) printf("String1 n'est pas une anagramme de String2\n");
    return 0;
}