(in-test-group
 galaxy-range

 (define-test ()
   (interaction
    (define (+- value delta #!optional delta-)
      (let ((delta+ delta)
	    (delta- (if (default-object? delta-) delta delta-)))
	(make-interval (- value delta-) (+ value delta+))))

    (define (depends-on value premises)
      (make-tms (contingent value premises)))

    (initialize-scheduler)


    ;;; Distance-modulus method

    (define-cell l10 (log 10))

    (define-propagator (p:mu->d mu d)
      (p:/ (e:exp (e:* (e:+ (e:/ mu 5) 1) l10))
	   1e6
	   d))

    (define-propagator (p:d->mu d mu)
      (p:* 5
	   (e:- (e:/ (e:log (e:* d 1e6)) l10) 1)
	   mu))

    (define-propagator (c:mu<->d mu d)
      (p:mu->d mu d)
      (p:d->mu d mu))

    (define-cell M87:distance-modulus
      (depends-on (+- 31.43 0.3)
		  (list 'VanDenBergh1985)))

    (define-cell M87:distance)

    (c:mu<->d M87:distance-modulus M87:distance)

    (run)

    (content M87:distance)

    (produces
     #(tms
       (#(supported
	  #(interval 16.826740610704718 22.181964198002227)
	  (VanDenBergh1985)))))


    ;;; Surface-Brightness Fluctuation survey

    (add-content M87:distance
     (depends-on (+- 17 0.31)
		 (list 'Tonry-etal:SBFsurveyIV)))

    (run)

    (content M87:distance)
    (produces
     #(tms
       (#(supported
	  #(interval 16.826740610704718 17.30999999999999)
	  (VanDenBergh1985 Tonry-etal:SBFsurveyIV))
	#(supported
	  #(interval 16.69 17.31)
	  (Tonry-etal:SBFsurveyIV))
	#(supported
	  #(interval 16.826740610704718 22.181964198002227)
	  (VanDenBergh1985)))))
    ;;; The two measurements give a better intersection

    ;;; But note that the original measure is improved
    (content M87:distance-modulus)
   
    (produces
     #(tms
       (#(supported
	  #(interval 31.13 31.191485339376964)
	  (VanDenBergh1985 Tonry-etal:SBFsurveyIV))
	#(supported
	  #(interval 31.13 31.729999999999997)
	  (VanDenBergh1985)))))
   

    ;;; By redshift and Hubble law

    (define-cell :c 2.99792458e5)	;km/sec

    (define-propagator (p:z->v/c z v/c)
      (let-cells ((s (e:square (e:+ 1 z))))
	(p:/ (e:- s 1) (e:+ 1 s) v/c)))

    (define-propagator (p:v/c->z v/c z)
      (p:- (e:sqrt (e:/ (e:+ 1 v/c) (e:- 1 v/c)))
	   1
	   z))

    (define-propagator (c:v/c<->z v/c z)
      (p:v/c->z v/c z)
      (p:z->v/c z v/c))

    (define-propagator (c:v<->z v z)
      (let-cell v/c
	(c:* v/c :c v)
	(c:v/c<->z v/c z)))


    (define-cell M87:redshift
      (depends-on (+- 0.004360 0.000022)
		  (list 'NASA:IPAC)))


    (define-cell M87:radial-velocity)

    (c:v<->z M87:radial-velocity M87:redshift)


    (define-cell H0)			;Hubble constant

    (define-propagator (c:HubbleLaw d v)
      (c:* H0 d v))

    (c:HubbleLaw M87:distance M87:radial-velocity)

    (run)

    (content H0)
   
    (produces
     #(tms
       (#(supported
	  #(interval 74.96371053390713 77.90397375603429)
	  (Tonry-etal:SBFsurveyIV VanDenBergh1985 NASA:IPAC)))))
   

    (content M87:radial-velocity)
   
    (produces
     #(tms
       (#(supported
	  #(interval 1297.6218293419317 1310.8699589359367)
	  (NASA:IPAC)))))
   

    (add-content H0
     (depends-on (+- 73.5 3.2)		;km/sec/Mpc
		 (list 'NASA:WmapsUniverse)))

    (run)

    (content M87:distance)
   
    (produces
     #(tms
       (#(supported
	  #(interval 16.918146406022597 17.30999999999999)
	  (NASA:WmapsUniverse Tonry-etal:SBFsurveyIV VanDenBergh1985 NASA:IPAC))
	#(supported
	  #(interval 16.826740610704718 17.30999999999999)
	  (VanDenBergh1985 Tonry-etal:SBFsurveyIV))
	#(supported
	  #(interval 16.69 17.31)
	  (Tonry-etal:SBFsurveyIV))
	#(supported
	  #(interval 16.826740610704718 22.181964198002227)
	  (VanDenBergh1985)))))
   

    (tms-query (content M87:distance))
   
    (produces
     #(supported
       #(interval 16.918146406022597 17.30999999999999)
       (NASA:WmapsUniverse Tonry-etal:SBFsurveyIV VanDenBergh1985 NASA:IPAC)))
   

    (add-content H0
     (depends-on (+- 70.8 4)		;km/sec/Mpc
		 (list 'NASA:WmapsUniverse 'cosmology)))

    (run)
    (produces
     '(contradiction
       (Tonry-etal:SBFsurveyIV
	VanDenBergh1985
	NASA:IPAC
	NASA:WmapsUniverse
	cosmology)))
   

    (kick-out! 'Tonry-etal:SBFsurveyIV)

    (run)

    (tms-query (content M87:distance))
   
    (produces
     #(supported
       #(interval 17.34788541900978 18.64679884688385)
       (cosmology NASA:WmapsUniverse NASA:IPAC)))
   

    (bring-in! 'Tonry-etal:SBFsurveyIV)
    (kick-out! 'cosmology)

    (run)

    (tms-query (content M87:distance))
    (produces
     #(supported
       #(interval 16.918146406022597 17.30999999999999)
       (NASA:WmapsUniverse Tonry-etal:SBFsurveyIV VanDenBergh1985 NASA:IPAC)))

    (tms-query (content H0))
   
    (produces
     #(supported
       #(interval 74.96371053390713 76.7)
       (NASA:IPAC VanDenBergh1985 Tonry-etal:SBFsurveyIV NASA:WmapsUniverse)))
   



   ;; Even tighter
    (add-content H0
     (depends-on (+- 70.8 1.6)
		 (list 'NASA:WmapsUniverse 'cosmology 'flat-cosmology))))

))
