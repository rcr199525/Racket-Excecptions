#lang racket

(require racket racket/stream)


(define (process-inputs args)
  (define (raise-excp arg)
    (when (<= (abs arg) 5e-4)
      (raise 'my-exception)))
  (map raise-excp args)
  (apply min args)) ;apply takes a function with multiple arguments and inputs a list as the arguments

(define (mainx strlst)
  (define args (for/list ([arg strlst])
                         (string->number arg)))
  (with-handlers ([(lambda (e) (equal? e 'my-exception))
                   (lambda (e) (displayln "A too-small value encountered in command line"))])
    (printf "Minimum value on command line is ~a~n"
            (process-inputs args))))

(define (main)
  (mainx (current-command-line-arguments)))

(main)
