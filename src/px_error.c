#include <R.h>
#include <Rinternals.h>
#include <R_ext/Error.h>
#include <stdio.h>
#include <stdarg.h>

#include "px_intern.h"
#include "paradox.h"

/* px_errorhandler() {{{
 * Default error handler if not set by application
 */
void px_errorhandler(pxdoc_t *p, int error, const char *str, void *data) {
  if(error != PX_Warning || (p && p->warnings == px_true))
    REprintf("PXLib: %s\n", str);
}
/* }}} */

/* px_error() {{{
 * Issue an error from within the library by using the error handler
 */
void px_error(pxdoc_t *p, int type, const char *fmt, ...) {
  char msg[256];
  va_list ap;
  
  va_start(ap, fmt);
  vsnprintf(msg, sizeof(msg), fmt, ap);
  va_end(ap);
  
  if(p && p->errorhandler)
    (p->errorhandler)(p, type, msg, p->errorhandler_user_data);
}
/* }}} */

/*
 * Local variables:
 * tab-width: 4
 * c-basic-offset: 4
 * End:
 * vim600: sw=4 ts=4 fdm=marker
 * vim<600: sw=4 ts=4
 */
