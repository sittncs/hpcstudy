       program main
       implicit none
       include "mpif.h"
       common /mpienv/myid,numprocs

       integer  myid, numprocs
       integer  ierr
       integer*8 i, j, iinput, ioutput
       real*8   elp1, elp2

       call MPI_INIT(ierr)
       call MPI_COMM_RANK(MPI_COMM_WORLD, myid, ierr)
       call MPI_COMM_SIZE(MPI_COMM_WORLD, numprocs, ierr)

!      preparation
       elp1 = MPI_WTIME()
       iinput=0
       do i=1, 50000*(myid+1)
         do j=1, 50000
           iinput = iinput + 1
         enddo
       enddo

!      mpi_barrier
!       call MPI_BARRIER(MPI_COMM_WORLD, ierr)
 
!      summation
       ioutput=0
       do i=1, 50000
         do j=1, 50000
           ioutput = ioutput + 1
         enddo
       enddo
       write(*,*) iinput, ioutput, 'myid=' , myid

       elp2 = MPI_WTIME()
       write(*,*) 'ELAPSE=', elp2-elp1, 'myid=',myid

       call MPI_FINALIZE(ierr)

       stop
       end
