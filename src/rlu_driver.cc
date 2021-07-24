/**
 * @file rlu_driver.cc
 * @author Pranay Garg (pranayga)
 * @brief A basic program with implements interfaces to
 * write basic RLU based programs for testing
 * @version 0.1
 * @date 2021-07-24
 *
 * @copyright Copyright (c) 2021
 *
 */
#include "rlu_driver.h"
#include "tracer.h"

using namespace std;

int main()
{
    cout << "Hello World!" << endl;
    LOG_INFO(DBG_BASIC, VERB_4, "Time of %s.\n", "code");
    return 0;
}
