(in-test-group barometer
 (define-test (barometer-example)
   (interaction
    (initialize-scheduler)
    (define barometer-height (make-cell))
    (define barometer-shadow (make-cell))
    (define building-height (make-cell))
    (define building-shadow (make-cell))
    (similar-triangles
     barometer-shadow barometer-height building-shadow building-height)
    (add-content building-shadow (make-interval 54.9 55.1))
    (add-content barometer-height (make-interval 0.3 0.32))
    (add-content barometer-shadow (make-interval 0.36 0.37))
    (run)

    (content building-height)
    (produces #(interval 44.51351351351351 48.977777777777774))

    (define fall-time (make-cell))
    (fall-duration fall-time building-height)
    (add-content fall-time (make-interval 2.9 3.1))
    (run)

    (content building-height)
    (produces #(interval 44.51351351351351 47.24276000000001))
      
    (content barometer-height)
    (produces #(interval .3 .3183938287795994))

    (content fall-time)
    (produces #(interval 3.0091234174691017 3.1))

    (add-content building-height 45)
    (run)

    (content barometer-height)
    (produces #(interval .3 .30327868852459017))

    (content barometer-shadow)
    (produces #(interval .366 .37))

    (content building-shadow)
    (produces #(interval 54.9 55.1))

    (content fall-time)
    (produces #(interval 3.025522031629098 3.0321598338046556)))))
