#!r6rs

(library

 (engines sine-dp)

 (export sine-dp)

 (import (rnrs)
         (sine spn)
         (scheme-tools))

 (define/kw (sine-dp expr [max-spn-size :default +inf.0])
   (marginalize expr 'max-spn-size max-spn-size))

 )