## Matrix inversion is usually a costly computation and there may be some benefit to 
## caching the inverse of a matrix rather than compute it repeatedly. These functions 
## will use matrix object for caching and avoid expensive re-somutation

## This function creates a special "matrix" object that can cache its inverse.
## Creates a list containing a function to :- 
## - set the value of the matrix
## - get the value of the matrix
## - set the inverse value of the matrix
## - get the inverse value of the matrix

makeCacheMatrix <- function(x = matrix()) {
    mat1 <- NULL
    
    # set value of matri
    set <- function(y) {
    x <<- y
    mat1 <<- NULL
    }
    
    # get the value of matrix
    get<-function() x
    
    ## set values
    setmat<-function(solve) mat1 <<- solve
    getmat<-function() mat1
    list(set=set, get=get,setmat=setmat,getmat=getmat)
}


## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
## If the inverse has already been calculated (and the matrix has not changed), 
## then the cachesolve retrieves the inverse from the cache.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    mat<-x$getmat()
    
    ## check if there is a match in cache; return cached value
    if(!is.null(mat)){
      message("getting cached data")
      return(mat)
    }
    
    ## compute if the cache doesn't exist
    mydata<-x$get()
    mat<-solve(mydata, ...)
    x$setmat(mat)
    return(mat)
}
