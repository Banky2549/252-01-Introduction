#ifndef API_BRIDGE_LAB_H
#define API_BRIDGE_LAB_H

#include <stddef.h>

int legacy_parse_year(const char *record);
int modern_parse_year(const char *record, int *out_year);

void legacy_make_slug(const char *name, char *out);
int modern_make_slug(const char *name, char *out, size_t out_size);

#endif
