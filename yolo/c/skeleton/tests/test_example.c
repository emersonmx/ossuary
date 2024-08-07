#include <unity.h>

void setUp(void)
{
}

void tearDown(void)
{
}

void test_example()
{
    TEST_ASSERT_EQUAL_INT32(4, 2 + 2);
}

int main()
{
    UNITY_BEGIN();
    RUN_TEST(test_example);
    return UNITY_END();
}
