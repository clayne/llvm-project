! RUN: %python %S/test_errors.py %s %flang_fc1 -pedantic
! Error tests for structure constructors: C1594 violations
! from assigning globally-visible data to POINTER components.
! test/Semantics/structconst04.f90 is this same test without type
! parameters.

module usefrom
  real, target :: usedfrom1
end module usefrom

module module1
  use usefrom
  implicit none
  type :: has_pointer1
    real, pointer :: ptop
    type(has_pointer1), allocatable :: link1 ! don't loop during analysis
  end type has_pointer1
  type :: has_pointer2
    type(has_pointer1) :: pnested
    type(has_pointer2), allocatable :: link2
  end type has_pointer2
  type, extends(has_pointer2) :: has_pointer3
    type(has_pointer3), allocatable :: link3
  end type has_pointer3
  type :: t1(k)
    integer, kind :: k
    real, pointer :: pt1
    type(t1(k)), allocatable :: link
  end type t1
  type :: t2(k)
    integer, kind :: k
    type(has_pointer1) :: hp1
    type(t2(k)), allocatable :: link
  end type t2
  type :: t3(k)
    integer, kind :: k
    type(has_pointer2) :: hp2
    type(t3(k)), allocatable :: link
  end type t3
  type :: t4(k)
    integer, kind :: k
    type(has_pointer3) :: hp3
    type(t4(k)), allocatable :: link
  end type t4
  real, target :: modulevar1 = 0.
  type(has_pointer1) :: modulevar2 = has_pointer1(modulevar1)
  type(has_pointer2) :: modulevar3 = has_pointer2(has_pointer1(modulevar1))
  type(has_pointer3) :: modulevar4 = has_pointer3(has_pointer1(modulevar1))

 contains

  pure subroutine ps1(dummy1, dummy2, dummy3, dummy4, co2, co3, co4)
    real, target :: local1
    type(t1(0)) :: x1
    type(t2(0)) :: x2
    type(t3(0)) :: x3
    type(t4(0)) :: x4
    real, intent(in), target :: dummy1
    real, intent(inout), target :: dummy2
    real, pointer :: dummy3
    real, intent(inout), target :: dummy4[*]
    real, target :: commonvar1
    common /cblock/ commonvar1
    type(has_pointer1), intent(in out) :: co2[*]
    type(has_pointer2), intent(in out) :: co3[*]
    type(has_pointer3), intent(in out) :: co4[*]
    x1 = t1(0)(local1)
    !ERROR: Externally visible object 'usedfrom1' may not be associated with pointer component 'pt1' in a pure procedure
    x1 = t1(0)(usedfrom1)
    !ERROR: Externally visible object 'modulevar1' may not be associated with pointer component 'pt1' in a pure procedure
    x1 = t1(0)(modulevar1)
    !ERROR: Externally visible object 'cblock' may not be associated with pointer component 'pt1' in a pure procedure
    x1 = t1(0)(commonvar1)
    !ERROR: Externally visible object 'dummy1' may not be associated with pointer component 'pt1' in a pure procedure
    x1 = t1(0)(dummy1)
    x1 = t1(0)(dummy2)
    x1 = t1(0)(dummy3)
! TODO when semantics handles coindexing:
! TODO !ERROR: Externally visible object may not be associated with a pointer in a pure procedure
! TODO x1 = t1(0)(dummy4[0])
    x1 = t1(0)(dummy4)
    !ERROR: Externally visible object 'modulevar1' may not be associated with pointer component 'ptop' in a pure procedure
    x2 = t2(0)(has_pointer1(modulevar1))
    !ERROR: Externally visible object 'modulevar1' may not be associated with pointer component 'ptop' in a pure procedure
    x3 = t3(0)(has_pointer2(has_pointer1(modulevar1)))
    !ERROR: Externally visible object 'modulevar1' may not be associated with pointer component 'ptop' in a pure procedure
    x4 = t4(0)(has_pointer3(has_pointer1(modulevar1)))
    !ERROR: The externally visible object 'modulevar2' may not be used in a pure procedure as the value for component 'hp1' which has the pointer component '%ptop'
    x2 = t2(0)(modulevar2)
    !ERROR: The externally visible object 'modulevar3' may not be used in a pure procedure as the value for component 'hp2' which has the pointer component '%pnested%ptop'
    x3 = t3(0)(modulevar3)
    !ERROR: The externally visible object 'modulevar4' may not be used in a pure procedure as the value for component 'hp3' which has the pointer component '%has_pointer2%pnested%ptop'
    x4 = t4(0)(modulevar4)
    !ERROR: A coindexed object may not be used in a pure procedure as the value for component 'hp1' which has the pointer component '%ptop'
    x2 = t2(0)(co2[1])
    !ERROR: A coindexed object may not be used in a pure procedure as the value for component 'hp2' which has the pointer component '%pnested%ptop'
    x3 = t3(0)(co3[1])
    !ERROR: A coindexed object may not be used in a pure procedure as the value for component 'hp3' which has the pointer component '%has_pointer2%pnested%ptop'
    x4 = t4(0)(co4[1])
   contains
    pure subroutine subr(dummy1a, dummy2a, dummy3a, dummy4a, co2a, co3a, co4a)
      real, target :: local1a
      type(t1(0)) :: x1a
      type(t2(0)) :: x2a
      type(t3(0)) :: x3a
      type(t4(0)) :: x4a
      real, intent(in), target :: dummy1a
      real, intent(inout), target :: dummy2a
      real, pointer :: dummy3a
      real, intent(inout), target :: dummy4a[*]
      type(has_pointer1), intent(in out) :: co2a[*]
      type(has_pointer2), intent(in out) :: co3a[*]
      type(has_pointer3), intent(in out) :: co4a[*]
      x1a = t1(0)(local1a)
      !ERROR: Externally visible object 'usedfrom1' may not be associated with pointer component 'pt1' in a pure procedure
      x1a = t1(0)(usedfrom1)
      !ERROR: Externally visible object 'modulevar1' may not be associated with pointer component 'pt1' in a pure procedure
      x1a = t1(0)(modulevar1)
      !ERROR: Externally visible object 'commonvar1' may not be associated with pointer component 'pt1' in a pure procedure
      x1a = t1(0)(commonvar1)
      !ERROR: Externally visible object 'dummy1' may not be associated with pointer component 'pt1' in a pure procedure
      x1a = t1(0)(dummy1)
      !ERROR: Externally visible object 'dummy1a' may not be associated with pointer component 'pt1' in a pure procedure
      x1a = t1(0)(dummy1a)
      x1a = t1(0)(dummy2a)
      x1a = t1(0)(dummy3)
      x1a = t1(0)(dummy3a)
! TODO when semantics handles coindexing:
! TODO !ERROR: Externally visible object may not be associated with a pointer in a pure procedure
! TODO x1a = t1(0)(dummy4a[0])
      x1a = t1(0)(dummy4a)
      !ERROR: Externally visible object 'modulevar1' may not be associated with pointer component 'ptop' in a pure procedure
      x2a = t2(0)(has_pointer1(modulevar1))
      !ERROR: Externally visible object 'modulevar1' may not be associated with pointer component 'ptop' in a pure procedure
      x3a = t3(0)(has_pointer2(has_pointer1(modulevar1)))
      !ERROR: Externally visible object 'modulevar1' may not be associated with pointer component 'ptop' in a pure procedure
      x4a = t4(0)(has_pointer3(has_pointer1(modulevar1)))
      !ERROR: The externally visible object 'modulevar2' may not be used in a pure procedure as the value for component 'hp1' which has the pointer component '%ptop'
      x2a = t2(0)(modulevar2)
      !ERROR: The externally visible object 'modulevar3' may not be used in a pure procedure as the value for component 'hp2' which has the pointer component '%pnested%ptop'
      x3a = t3(0)(modulevar3)
      !ERROR: The externally visible object 'modulevar4' may not be used in a pure procedure as the value for component 'hp3' which has the pointer component '%has_pointer2%pnested%ptop'
      x4a = t4(0)(modulevar4)
      !ERROR: A coindexed object may not be used in a pure procedure as the value for component 'hp1' which has the pointer component '%ptop'
      x2a = t2(0)(co2a[1])
      !ERROR: A coindexed object may not be used in a pure procedure as the value for component 'hp2' which has the pointer component '%pnested%ptop'
      x3a = t3(0)(co3a[1])
      !ERROR: A coindexed object may not be used in a pure procedure as the value for component 'hp3' which has the pointer component '%has_pointer2%pnested%ptop'
      x4a = t4(0)(co4a[1])
    end subroutine subr
  end subroutine

  pure integer function pf1(dummy3)
    real, pointer :: dummy3
    type(t1(0)) :: x1
    pf1 = 0
    !ERROR: Externally visible object 'dummy3' may not be associated with pointer component 'pt1' in a pure procedure
    x1 = t1(0)(dummy3)
   contains
    pure subroutine subr(dummy3a)
      real, pointer :: dummy3a
      type(t1(0)) :: x1a
      !ERROR: Externally visible object 'dummy3' may not be associated with pointer component 'pt1' in a pure procedure
      x1a = t1(0)(dummy3)
      x1a = t1(0)(dummy3a)
    end subroutine
  end function

  impure real function ipf1(dummy1, dummy2, dummy3, dummy4)
    real, target :: local1
    type(t1(0)) :: x1
    type(t2(0)) :: x2
    type(t3(0)) :: x3
    type(t4(0)) :: x4
    real, intent(in), target :: dummy1
    real, intent(inout), target :: dummy2
    real, pointer :: dummy3
    real, intent(inout), target :: dummy4[*]
    real, target :: commonvar1
    common /cblock/ commonvar1
    ipf1 = 0.
    x1 = t1(0)(local1)
    x1 = t1(0)(usedfrom1)
    x1 = t1(0)(modulevar1)
    x1 = t1(0)(commonvar1)
    !WARNING: Pointer target is not a definable variable [-Wpointer-to-undefinable]
    !BECAUSE: 'dummy1' is an INTENT(IN) dummy argument
    x1 = t1(0)(dummy1)
    x1 = t1(0)(dummy2)
    x1 = t1(0)(dummy3)
! TODO when semantics handles coindexing:
! TODO x1 = t1(0)(dummy4[0])
    x1 = t1(0)(dummy4)
    x2 = t2(0)(has_pointer1(modulevar1))
    x3 = t3(0)(has_pointer2(has_pointer1(modulevar1)))
    x4 = t4(0)(has_pointer3(has_pointer1(modulevar1)))
    x2 = t2(0)(modulevar2)
    x3 = t3(0)(modulevar3)
    x4 = t4(0)(modulevar4)
  end function ipf1
end module module1
