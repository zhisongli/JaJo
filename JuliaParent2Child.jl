#=
DESCRIPTION: Show Figures
AUTHOR: ZhisongLi@Shanghai Jiao Tong University
TIME: 2020-06-30
EMAIL: lizhisong@sjtu.edu.cn, for bug(s) report only.

UPDATE HISTORY:
    yyyy-mm-dd:
=#
function IDxy(t, t1, t2)
    if t1<minimum(t); println("Check t1!"); end
    if t2>maximum(t); println("Check t2!"); end

    One=ones(Int64, length(t)); One[t .> t1].=0; it1=sum(One)-1;
    One=ones(Int64, length(t)); One[t .> t2].=0; it2=sum(One);
    return it1, it2
end


println("Loading packages ...")
using CSV
using PyPlot
using GR:meshgrid, interp2
# using LaTeXStrings
using DelimitedFiles


println("Preparing data")
FigureName="JuliaParent2Child"

DirIn="INPUT/"
DirOut="FullyBoussinesqEquation21/"

@time(dep=convert(Array, transpose(readdlm(join([DirOut "dep.out"])))))
Nx, Ny=size(dep)
x=readdlm(join([DirIn "Funwave.x"]))[1:Nx]
y=readdlm(join([DirIn "Funwave.y"]))[1:Ny]
X, Y=meshgrid(x, y)

etaID=54
time=Int64(etaID*100-100+5000)
msk=convert(Array, transpose(readdlm(join([DirOut "mask_" string(etaID, pad=4)]))))
eta=convert(Array, transpose(readdlm(join([DirOut "eta_" string(etaID, pad=4)]))))
eta=msk .* eta
hmax=convert(Array, transpose(readdlm(join([DirOut "hmax_" string(etaID, pad=4)]))))
u=convert(Array, transpose(readdlm(join([DirOut "u_" string(etaID, pad=4)]))))
v=convert(Array, transpose(readdlm(join([DirOut "v_" string(etaID, pad=4)]))))


# Box boundaries
xLeft=112.5; xRight=113.4966;
yBottom=20;    yTop=21.15;
ixL, ixR=IDxy(x, xLeft, xRight);
iyB, iyT=IDxy(y, yBottom, yTop);


clf(); close("all");
fig = figure("First Plot by Julia and PyPlot", figsize=(12, 5), clear="True")


subplot(1, 1, 1)
contourf(X, Y, (eta), levels=60, cmap="jet")
plot([xLeft, xLeft], [yBottom, yTop], "k-")
plot([xRight, xRight], [yBottom, yTop], "k-")
plot([xLeft, xRight], [yBottom, yBottom], "k-")
plot([xLeft, xRight], [yTop, yTop], "k-")

xlabel("Latitude"); ylabel("Longtitude")
title(join(["Time=" string(time) "s"])
    , fontname="Times New Roman", loc="left")
colorbar()
contour(X, Y, -(dep), levels=[0], colors="k", linestyles="-")
contour(X, Y, -(dep), levels=[-50], colors="k", linestyles="--")
axis("equal")






fig.tight_layout()
fig.savefig(string(FigureName,".pdf"))
fig.savefig(join(["subLayerRx05Ry005/" FigureName ".pdf"]))
fig.show()
