#include <iostream>
#include <stdio.h>
#include <stdlib.h> // exit
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h> // fork
#include <signal.h>
#include <pthread.h>

#include "gtest/gtest.h"
#include "gmock/gmock.h"

#include "sysver.h"

TEST(SYSVER, NullParameters)
{
    EXPECT_EQ(get_sysver(NULL, NULL), -1);
}

int main(int argc, char **argv)
{
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

