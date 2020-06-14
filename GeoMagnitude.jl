#=
DESCRIPTION: Composing a Structure with primary variables and the derived ones
AUTHOR: ZhisongLi@Shanghai Jiao Tong University
TIME: 2020-06-14
EMAIL: lizhisong@sjtu.edu.cn, for bug(s) report only.
ACADEMIC LITERATURE(S):

UPDATE HISTORY:
    yyyy-mm-dd:
=#

#=
    For a two-dimensional Boussinesq model, only 2D variables are defined.
    Here, all variables are blocked in a structure.

    I compose such a structure in favor of adopting nested layers later.

    The function of Struct is similar with the MODULE in Fortran or CLASS in C++.
    It is the setup for Object Oriented Programming (OOP)
=#
mutable struct Layers
    # Limits and steps of coordinates
    xmin::Float64
    xmax::Float64
    dx::Float64
    ymin::Float64
    ymax::Float64
    dy::Float64
    Nx::Int32
    Ny::Int32
    x::Array{Float64,1}
    y::Array{Float64,1}

    # basic variables
    eta::Array{Float64,2} # water elevation from MSL
    dep::Array{Float64,2} # water depth from MSL
    u::Array{Float64,2}   # horizontal velocity
    v::Array{Float64,2}   # horizontal velocity
    w::Array{Float64,2}   # vertical velocity at sea surface. it depends on velocity profile. Madsen2002, WangBL2005
    Magnitude::Array{Float64,2}  # GeoMagnitude at z=1km above the sea surface. refer WangBL and ETH GeoMagnitude

    # Internal function to derive and initilize variables.
    function Layers(xmin, xmax, dx, ymin, ymax, dy)
		x=collect(xmin:dx:xmax)
        y=collect(ymin:dy:ymax)
        Nx=length(x)
        Ny=length(y)
        eta=zeros(Float64, Nx, Ny)
        dep=zeros(Float64, Nx, Ny)
        u=zeros(Float64, Nx, Ny)
        v=zeros(Float64, Nx, Ny)
        w=zeros(Float64, Nx, Ny)
        Magnitude=zeros(Float64, Nx, Ny)
		new(xmin, xmax, dx, ymin, ymax, dy, Nx, Ny, x, y, eta, dep, u, v, w, Magnitude)
	end
end


L0=Layers(100, 130, 1/60, 0, 30, 1/60)

println("Dimension along Longtitude is $(L0.Nx), ")
println("Dimension along Latitude   is $(L0.Ny).")
