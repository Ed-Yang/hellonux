// REF: http://wiki.wrtnode.cc/index.php?title=OpenWrt增加软件包的方法/en

#include "sysver.h"
#include <sys/utsname.h>

int get_sysver(char *name, int *len)
{
    int rv = -1, l;
    static struct utsname unameData;

    if (name == NULL || len == NULL)
        return -1;

    if ((rv=uname(&unameData)) == 0) {
        l = ((int)strlen(unameData.version) >= *len) ? *len-1: strlen(unameData.version);
        memset(name, 0, *len);
        strcpy(name, unameData.version);
        *len = l;
    }

    return rv;
}

