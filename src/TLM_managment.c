#include <hal/Timing/Time.h>
#include <hcc/api_fat.h>
#include <stdio.h>

#define MAX_LOG_PATH 17

//TODO: handle errors(there wont be any)
int writeToFile(void *data, int size, char *ext) {
  Time time;
  Time_get(&time);
  char buffer[MAX_LOG_PATH];

  snprintf(buffer, MAX_LOG_PATH, "/log/%02d/%02d/%02d.%s", time.year + 2000,
           time.month, time.date, ext);

  FN_FILE* file = f_open(buffer, "a");
  printf("writing telem to file: %s", buffer);

  f_write(data, size, 1, file);
  return 0;
}
