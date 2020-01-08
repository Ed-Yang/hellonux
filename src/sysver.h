#ifndef _SYSVER_H
#define _SYSVER_H

#include <stdio.h>
#include <string.h>
#include <unistd.h>

#ifdef __cplusplus
extern "C"
{
#endif

int get_sysver(char *name, int *len);

#ifdef __cplusplus
}
#endif

#endif /* _SYSVER_H */
