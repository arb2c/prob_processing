FUNCTION randomf, x, y, n, endbins=endbins, seed=seed
   ;Return n random numbers based on the distribution described 
   ;by x and y.  
   ;AB 5/2012
   IF n_elements(endbins) eq 0 THEN endbins=0

   IF min(y) lt 0 THEN BEGIN
      print,'y values must all be positive numbers'
      return,-1
   ENDIF

   ;Numerically integrate the function to find cumulative probability
   nx=n_elements(x)
   r=randomu(seed,n,/double)
   cp=dblarr(nx)
  
   IF endbins eq 0 THEN BEGIN
      dx=[0,x[1:*]-x]    ;Need to do some normalization in case of uneven x
      FOR i=1L,nx-1 DO cp[i]=cp[i-1]+y[i]*dx[i]  ;Integrate at each interval
   ENDIF ELSE BEGIN
      dx=x[1:*]-x
      FOR i=1L,nx-1 DO cp[i]=cp[i-1]+y[i-1]*dx[i-1]  ;Integrate at each interval
   ENDELSE

   cp=cp/max(cp,/nan)  ;Normalize to 1     
   out=interpol(x,cp,r)  ;Find interpolates of the inverse function at random spots

   return,out
END
