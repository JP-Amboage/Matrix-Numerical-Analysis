subroutine jacobi(a, b, u, eps, nmaxit, ier)
  implicit none

  real, dimension(:,:), intent(in) :: a
  real, dimension(:), intent(in) :: b
  real, dimension(:), intent(out) :: u
  real, intent(in) :: eps
  integer, intent(in) :: nmaxit
  integer, intent(out) :: ier

  real, dimension(:), allocatable :: v
  real :: s, err
  integer :: n, i, j, k

  n = size(b)

  allocate(v(n))

  do k=1, nmaxit
    err = 0
    do i=1,n
      s = 0
      do j = 1, i-1
        s = s + a(i,j)*u(j)
      end do

      do j = i+1, n
          s = s + a(i,j)*u(j)
      end do

      v(i) = (b(i) - s)/a(i,i)
    end do

    do i = 1, n
        err = err + abs(v(i) - u(i))
        u(i) = v(i)
    end do

    if(err < eps) then
      ier = 0
      return
    end if
  end do
  ier = 1
end subroutine
