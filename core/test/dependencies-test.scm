(in-test-group
 dependencies

 (define-test ()
   (interaction
    (initialize-scheduler)
    (define barometer-height (make-cell))
    (define barometer-shadow (make-cell))
    (define building-height (make-cell))
    (define building-shadow (make-cell))
    (similar-triangles barometer-shadow barometer-height
		       building-shadow building-height)

    (add-content building-shadow
		 (supported (make-interval 54.9 55.1) '(shadows)))
    (add-content barometer-height
		 (supported (make-interval 0.3 0.32) '(shadows)))
    (add-content barometer-shadow
		 (supported (make-interval 0.36 0.37) '(shadows)))
    (run)
    (content building-height)
    (produces #(supported #(interval 44.514 48.978) (shadows)))

    (define fall-time (make-cell))
    (fall-duration fall-time building-height)

    (add-content fall-time
		 (supported (make-interval 2.9 3.3) '(lousy-fall-time)))
    (run)
    (content building-height)
    (produces #(supported #(interval 44.514 48.978) (shadows)))

    (add-content fall-time
		 (supported (make-interval 2.9 3.1) '(better-fall-time)))
    (run)
    (content building-height)
    (produces #(supported #(interval 44.514 47.243)
			  (better-fall-time shadows)))

    (add-content building-height (supported 45 '(superintendent)))
    (run)
    (content building-height)
    (produces #(supported 45 (superintendent)))

    (content barometer-height)
    (produces #(supported #(interval .3 .30328)
			  (superintendent better-fall-time shadows)))

    (content barometer-shadow)
    (produces #(supported #(interval .366 .37)
			  (better-fall-time superintendent shadows)))

    (content building-shadow)
    (produces #(supported #(interval 54.9 55.1) (shadows)))

    (content fall-time)
    (produces #(supported #(interval 3.0255 3.0322)
			  (shadows superintendent)))
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

    (add-content building-shadow
		 (make-tms (supported (make-interval 54.9 55.1) '(shadows))))
    (add-content barometer-height
		 (make-tms (supported (make-interval 0.3 0.32) '(shadows))))
    (add-content barometer-shadow
		 (make-tms (supported (make-interval 0.36 0.37) '(shadows))))
    (run)
    (content building-height)
    (produces #(tms (#(supported #(interval 44.514 48.978) (shadows)))))

    (define fall-time (make-cell))
    (fall-duration fall-time building-height)

    (add-content fall-time
		 (make-tms (supported (make-interval 2.9 3.1) '(fall-time))))
    (run)
    (content building-height)
    (produces #(tms (#(supported #(interval 44.514 47.243)
				 (shadows fall-time))
		     #(supported #(interval 44.514 48.978)
				 (shadows)))))

    (tms-query (content building-height))
    (produces #(supported #(interval 44.514 47.243) (shadows fall-time)))

    (kick-out! 'fall-time)
    (run)
    (tms-query (content building-height))
    (produces #(supported #(interval 44.514 48.978) (shadows)))

    (kick-out! 'shadows)
    (run)
    (tms-query (content building-height))
    (produces #(*the-nothing*))

    (bring-in! 'fall-time)
    (run)
    (tms-query (content building-height))
    (produces #(supported #(interval 41.163 47.243) (fall-time)))

    (content building-height)
    (produces #(tms (#(supported #(interval 41.163 47.243)
				 (fall-time))
		     #(supported #(interval 44.514 47.243)
				 (shadows fall-time))
		     #(supported #(interval 44.514 48.978)
				 (shadows)))))

    (add-content building-height (supported 45 '(superintendent)))

    (run)
    (content building-height)
    (produces #(tms (#(supported 45 (superintendent))
		     #(supported #(interval 41.163 47.243)
				 (fall-time))
		     #(supported #(interval 44.514 47.243)
				 (shadows fall-time))
		     #(supported #(interval 44.514 48.978)
				 (shadows)))))

    (tms-query (content building-height))
    (produces #(supported 45 (superintendent)))

    (bring-in! 'shadows)
    (run)
    (tms-query (content building-height))
    (produces #(supported 45 (superintendent)))

    (content barometer-height)
    (produces #(tms (#(supported #(interval .3 .30328)
				 (fall-time superintendent shadows))
		     #(supported #(interval .29401 .30328)
				 (superintendent shadows))
		     #(supported #(interval .3 .31839)
				 (fall-time shadows))
		     #(supported #(interval .3 .32) (shadows)))))


    (tms-query (content barometer-height))
    (produces #(supported #(interval .3 .30328)
			  (fall-time superintendent shadows)))

    (kick-out! 'fall-time)
    (run)
    (tms-query (content barometer-height))
    (produces #(supported #(interval .3 .30328) (superintendent shadows)))

    (bring-in! 'fall-time)
    (run)
    (tms-query (content barometer-height))
    (produces #(supported #(interval .3 .30328) (superintendent shadows)))

    (content barometer-height)
    (produces #(tms (#(supported #(interval .3 .30328)
				 (superintendent shadows))
		     #(supported #(interval .3 .31839)
				 (fall-time shadows))
		     #(supported #(interval .3 .32) (shadows)))))
    ))

 (define-test ()

;;; Restore the state we had in the preceding example
   (interaction
    (initialize-scheduler)
    (define barometer-height (make-cell))
    (define barometer-shadow (make-cell))
    (define building-height (make-cell))
    (define building-shadow (make-cell))
    (similar-triangles barometer-shadow barometer-height
		       building-shadow building-height)

    (add-content building-shadow
		 (make-tms (supported (make-interval 54.9 55.1) '(shadows))))
    (add-content barometer-height
		 (make-tms (supported (make-interval 0.3 0.32) '(shadows))))
    (add-content barometer-shadow
		 (make-tms (supported (make-interval 0.36 0.37) '(shadows))))

    (define fall-time (make-cell))
    (fall-duration fall-time building-height)

    (add-content fall-time
		 (make-tms (supported (make-interval 2.9 3.1) '(fall-time))))
    (run)
    (tms-query (content building-height))

    (kick-out! 'fall-time)
    (run)
    (tms-query (content building-height))

    (bring-in! 'fall-time)
    (kick-out! 'shadows)
    (run)
    (tms-query (content building-height))

    (add-content building-height (supported 45 '(superintendent)))
    (run)
    (bring-in! 'shadows)
    (run)
    (tms-query (content building-height))

    (tms-query (content barometer-height))
    (kick-out! 'fall-time)
    (run)
    (tms-query (content barometer-height))
    (bring-in! 'fall-time)
    (run)
    (tms-query (content barometer-height))
;;; That was a long story!
    (add-content building-height
		 (supported (make-interval 46. 50.) '(pressure)))
    (run)
    (produces '(contradiction (superintendent pressure)))

    (tms-query (content building-height))
    (produces #(supported #(*the-contradiction*) (superintendent pressure)))

    (tms-query (content barometer-height))
    (produces #(supported #(interval .3 .30328) (superintendent shadows)))

    (kick-out! 'superintendent)
    (run)
    (tms-query (content building-height))
    (produces #(supported #(interval 46. 47.243) (fall-time pressure)))

    (tms-query (content barometer-height))
    (produces #(supported #(interval .30054 .31839)
			  (pressure fall-time shadows)))

    (bring-in! 'superintendent)
    (kick-out! 'pressure)
    (run)
    (tms-query (content building-height))
    (produces #(supported 45 (superintendent)))
    (tms-query (content barometer-height))
    (produces #(supported #(interval .3 .30328) (superintendent shadows)))
    ))

 (define-test ()
   (interaction
    (initialize-scheduler)
    (define answers (multiple-dwelling))
    (run)
    (map v&s-value (map tms-query (map content answers)))
    (produces '(3 2 4 5 1))

    *number-of-calls-to-fail*
    (produces 66)
    ))

 )
