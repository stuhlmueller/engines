#!r6rs

(library

 (engines sine-enum)

 (export sine-enum)

 (import (rnrs)
         (sine enum-interpreter)
         (scheme-tools))

 (define/kw (sine-enum expr [limit :default 10000])
   (enum-interpreter expr 'limit limit))

 )