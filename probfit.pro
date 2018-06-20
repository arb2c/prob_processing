PRO probfit
   ;Some tests of probabilistic inversion


   ;Assume two measured bins, r0 and r1, and two source bins, s0 and s1.
   ;
   ;Bin 0 probability p0 = [0.8, 0.2]
   ;Bin 1 probability p1 = [0.2, 0.8]
   p0 = [0.6, 0.1,0.3]     ;The last number is for non-measured particles (group both too small and too large together)
   p1 = [0.2, 0.8,0.001]
   
   ;Measured counts are m = [16, 4]
   m = [16, 4]
   
   ;Find most probable s0 and s1 that satisfy measurement m.
   
   ;Step 1, assume most likely source and number from each bin to get first guess
   g = [m[0]/p0[0], m[1]/p1[1]]
   
   ;Step 2, use first guess and apply p to see how well it predicts m
   test1 = g[0]*p0 + g[1]*p1
   
   ;Check difference between m and test1
   diff = m-test1
   
   ;Update guess and apply again
   g = g+diff
   test2 = g[0]*p0 + g[1]*p1

   ;Check difference between m and test2
   diff = m-test2
 
   ;Update guess and apply again
   g = g+diff
   test3 = g[0]*p0 + g[1]*p1
   
   ;Get decent result here after 3 naive iterations.
   ;HOWEVER, just changing probabilities above (e.g. p0=[0.6,0.4]) will lead to negative guess values, clearly unphysical.
   
   
   ;===============
   
   ;Step 1, assume most likely source and number from each bin to get first guess
   g = [m[0]/p0[0], m[1]/p1[1]]

   endbins=[1,2,3,4]

   ;make a 2D surface of these two bins, testing all combinations of guess0 and guess1
   nmax=total(m)+3   ;the maximum number of particles to try out, if all particles are measured then is total(m), a bit more if unmeasured particles present
   c=lonarr(nmax+1, nmax+1);  0L  ;the number of times the measurement is satisfied
   FOR g0=0,nmax DO BEGIN
      FOR g1=0,nmax DO BEGIN	   
         FOR i=0,1000 do begin
            ;q = randomf(endbins,p1,total(m),/endbins)
            ;h=make1dhist(q,endbins)
            ;if h[0] eq m[0] then c++
            IF g0 gt 0 then q0 = randomf(endbins,p0,g0,/endbins) else q0=-1
            h0 =  make1dhist_fast(q0, endbins)
            IF g1 gt 0 then q1= randomf(endbins,p1,g1,/endbins) else q1=-1
            h1 =  make1dhist_fast(q1, endbins)
            htot=h0+h1
            IF (htot[0] eq m[0]) and (htot[1] eq m[1]) THEN c[g0, g1]++
         ENDFOR
      ENDFOR
   ENDFOR
   formatstr='('+string(nmax+1,format='(i0)')+'i5)'
   print,c,format=formatstr
   
   
   ;Faster way
   
stop  
   
END
