       program main
       include "mpif.h"
       common /mpienv/myid,numprocs

       integer  myid, numprocs
       integer  isbuf, irbuf, ierr
       integer  istatus(MPI_STATUS_SIZE)

       call MPI_INIT(ierr)
       call MPI_COMM_RANK(MPI_COMM_WORLD, myid, ierr)
       call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)

       if (myid.eq.0) then
         isbuf = 19750617
       endif

       if (myid.eq.0) then
         call MPI_SEND (isbuf,1,MPI_INTEGER,1,1,MPI_COMM_WORLD,ierr)
       elseif (myid.eq.1) then
         call MPI_RECV (irbuf,1,MPI_INTEGER,0,1,MPI_COMM_WORLD,istatus,ierr)
       endif

       if (myid.eq.1) then
         write(*,*) "IRBUF =",irbuf
       endif
       call MPI_FINALIZE(ierr)

       stop
       end
