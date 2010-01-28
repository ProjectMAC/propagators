(in-test-group
 core

 (define-test ()

   (interaction
    (initialize-scheduler)
    (define f (make-cell))
    (define c (make-cell))

    (fahrenheit->celsius f c)

    (add-content f 77)
    (run)
    (content c)
    (produces 25)
    ))

 (define-test ()

   (interaction
    (initialize-scheduler)
    (define f (make-cell))
    (define c (make-cell))

    (fahrenheit-celsius f c)

    (add-content c 25)
    (run)
    (content f)
    (produces 77)

    (define (celsius-kelvin c k)
      (let ((many (make-cell)))
	((constant 273.15) many)
	(sum c many k)))

    (define k (make-cell))

    (celsius-kelvin c k)
    (run)
    (content k)
    (produces 298.15)
    ))

 (define-test ()

   (interaction
    (initialize-scheduler)
    (define fall-time (make-cell))
    (define building-height (make-cell))
    (fall-duration fall-time building-height)

    (add-content fall-time (make-interval 2.9 3.1))
    (run)
    (content building-height)
    (produces #(interval 41.163 47.243))
    ))

 (define-test ()

   (interaction
    (initialize-scheduler)
    (define barometer-height (make-cell))
    (define barometer-shadow (make-cell))
    (define building-height (make-cell))
    (define building-shadow (make-cell))
    (similar-triangles barometer-shadow barometer-height
		       building-shadow building-height)

    (add-content building-shadow (make-interval 54.9 55.1))
    (add-content barometer-height (make-interval 0.3 0.32))
    (add-content barometer-shadow (make-interval 0.36 0.37))
    (run)
    (content building-height)
    (produces #(interval 44.514 48.978))

    (define fall-time (make-cell))
    (fall-duration fall-time building-height)

    (add-content fall-time (make-interval 2.9 3.1))
    (run)
    (content building-height)
    (produces #(interval 44.514 47.243))

    (content barometer-height)
    (produces #(interval .3 .31839))
    ;; Refining the (make-interval 0.3 0.32) we put in originally

    (content fall-time)
    (produces #(interval 3.0091 3.1))
    ;; Refining (make-interval 2.9 3.1)

    (add-content building-height (make-interval 45 45))
    (run)
    (content barometer-height)
    (produces #(interval .3 .30328))

    (content barometer-shadow)
    (produces #(interval .366 .37))

    (content building-shadow)
    (produces #(interval 54.9 55.1))

    (content fall-time)
    (produces #(interval 3.0255 3.0322))
    ))

   (define-test ()

     (interaction
      (initialize-scheduler)
      (define fall-time (make-cell))
      (define building-height (make-cell))
      (fall-duration fall-time building-height)

      (add-content fall-time (make-interval 2.9 3.1))
      (run)
      (content building-height)
      (produces #(interval 41.163 47.243))

      (add-content building-height 45)

      (run)
      (content fall-time)
      (produces #(interval 3.0255 3.0322))
      ))

   )
