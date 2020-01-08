
#include "sysver.h"

int main(void)
{
    char sname[128] = {0};
    int len;

    len = sizeof(sname);

    get_sysver((char *)sname, (int *)&len);

    fprintf(stderr, "\nHello !\n\n");
    fprintf(stderr, "The sys version: %s\n\n", sname);
    fprintf(stderr, "Have a good day !\n\n");

    return 0;
}

