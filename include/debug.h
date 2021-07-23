#ifndef __DEBUG_H__
#define __DEBUG_H__

#define DEBUG(x) do {         \
  std::err << x << std::endl; \
} while (0)

#endif

