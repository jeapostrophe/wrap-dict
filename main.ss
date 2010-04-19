#lang scheme

(define (make-wrapped-dict to-key from-key
                           to-val from-val)
  (define-struct w (i)
    #:property prop:dict
    (vector (case-lambda
              [(t k)
               (from-val (dict-ref (w-i t) (to-key k)))]
              [(t k f)
               (from-val (dict-ref (w-i t) (to-key k) f))])
            (lambda (t k v)
              (dict-set! (w-i t) (to-key k) (to-val v)))
            (lambda (t k v)
              (dict-set (w-i t) (to-key k) (to-val v)))
            (lambda (t k)
              (dict-remove! (w-i t) (to-key k)))
            (lambda (t k)
              (dict-remove (w-i t) (to-key k)))
            (lambda (t)
              (dict-count (w-i t)))
            (lambda (t)
              (dict-iterate-first (w-i t)))
            (lambda (t p)
              (dict-iterate-next (w-i t) p))
            (lambda (t p)
              (from-key (dict-iterate-key (w-i t) p)))
            (lambda (t p)
              (from-val (dict-iterate-value (w-i t) p)))))
  (lambda (a-dict)
    (make-w a-dict)))

(provide/contract
 [make-wrapped-dict (-> (any/c . -> . any/c) (any/c . -> . any/c)
                        (any/c . -> . any/c) (any/c . -> . any/c)
                        (dict? . -> . dict?))])