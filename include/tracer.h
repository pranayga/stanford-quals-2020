/** @file tracer.h
 *
 *  @brief A tracer facility to provide
 *  more granular logging.
 *
 *  @author Pranay Garg     (pranayga)
 *  @author Aditya Achanana (achanana)
 *
 *  @bug No known bugs.
 */

#ifndef RLU_TRACER_H
#define RLU_TRACER_H

#include <stdio.h>

/** Log a warning for a fatal error
 * @todo Add a panic function which stalls
 * the threads and loops waiting for the
 * gdb.
 */
#define LOG_FATAL(fmt, ...)                                                    \
    do {                                                                       \
        printf("FATAL:   %40s:%-4d: %-30s- " fmt, __FILE__, __LINE__,          \
               __func__, __VA_ARGS__);                                         \
        while (1)                                                              \
            ;                                                                  \
    }

/**
 * Passed at Compile time
 * with -DVERBOSITY to control
 * the VERBOSTY depending on the
 * verbose_levels enum
 */
#if VERBOSITY

/** The verbosity level of the logging facility */
#define LOG_VERBOSE VERBOSITY

/** The different verbose levels,
 * these are controlled by LOG_VERBOSE
 * parameter
 */
enum verbose_levels {
    VERB_1 = 1,
    VERB_2,
    VERB_3,
    VERB_4,
};

/** Component-wise debugging switches */
enum debug_comps {
    DBG_START_COMP = 0,
    DBG_BASIC,
    DBG_END_COMP,
};

/** An info log */
#define LOG_INFO(comp, verbose_level, fmt, ...)                                \
    if (comp > DBG_START_COMP && comp < DBG_END_COMP &&                        \
        (verbose_level) <= LOG_VERBOSE) {                                      \
                                                                               \
        printf("INFO:    %40s:%-4d: %-30s- " fmt, __FILE__, __LINE__,          \
               __func__, __VA_ARGS__);                                         \
    }

/** Log a warning if a condition is met */
#define LOG_WARNING_IF(comp, cond, fmt, ...)                                   \
    if (comp > DBG_START_COMP && comp < DBG_END_COMP && cond) {                \
        printf("WARNING: %40s:%-4d: %-30s- " fmt, __FILE__, __LINE__,          \
               __func__, __VA_ARGS__);                                         \
    }

/** Log a warning */
#define LOG_WARNING(comp, fmt, ...)                                            \
    if (comp > DBG_START_COMP && comp < DBG_END_COMP) {                        \
        printf("WARNING: %40s:%-4d: %-30s- " fmt, __FILE__, __LINE__,          \
               __func__, __VA_ARGS__);                                         \
    }

#else

#define LOG_INFO(...) ((void)0)
#define LOG_WARNING(...) ((void)0)
#define LOG_WARNING_IF(...) ((void)0)

#endif // VERBOSITY

#endif /* _KERN_TRACER_H_ */
