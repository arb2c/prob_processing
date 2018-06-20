FUNCTION make1dhist_fast,data,bins,xpoints
   ;Returns a 1D histogram of data1 with 
   ;endbins specified by bins1 
   
   ;xpoints is an optional parameter - puts the 
   ;x-axis points to be used on a histogram plot
   ;in the specified variable.
 
   ;example: x=make1dhist(data,[0.0,10.0,20.0],xvalues)
   ;will classify data1 into 2 bins with these cutoff points
   ;and return the midbin values ([5,15]) in xvalues for plotting.
   
   ;This is a faster version, 6/2018
   
   v=value_locate(bins, [data])
   h=histogram([v], min=0, max=n_elements(bins)-2)

   xpoints=(bins+bins[1:*])/2.0 ;simple average to get midpoints for plotting
   return,h
END