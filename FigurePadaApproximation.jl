
println("Loading packages ...")
# using CSV
using PyPlot
using LaTeXStrings
# using DelimitedFiles

println("Preparing data")

function Pada0(kh, order)
    if order==0
        return tanh(kh)/kh
    elseif order==1
        return 1/(1+1/3*kh^2)
    elseif order==2
        return (1+1/15*kh^2)/(1+2/5*kh^2)
    elseif order==3
        return (1+2/21*kh^2)/(1+3/7*kh^2+1/105*kh^4)
    elseif order==4
        return (1+1/9*kh^2+1/945*kh^4)/(1+4/9*kh^2+1/63*kh^4)
    else
        println("Check the second argument.")
        return 0
    end
end


x=0.01pi:0.05pi:8pi
y0=Pada0.(x, 0)
y1=Pada0.(x, 1)
y2=Pada0.(x, 2)
y3=Pada0.(x, 3)
y4=Pada0.(x, 4)

FigureName="../ch01/FigurePadaApproximation"


println("Drawing a Figure ...")

fig = figure("First Plot by Julia and PyPlot", figsize=(13,5))
ax1 = subplot(1,2,1);
ax1.plot(
      x, y0, "k-"
    , x, y1, "b-"
    , x, y2, "r-"
    , x, y3, "m-"
    , x, y4, "g-", linewidth=1.50)

ax1.set_xlabel("kh", fontname="Times New Roman", fontsize=14)
ax1.set_ylabel("c^2/gh", fontname="Times New Roman", fontsize=14)
# ax1.set_title("Linear dispersion", fontname="Times New Roman")
ax1.set_xlim([0, 3pi])
ax1.set_ylim([0, 1])

ax1.set_xticks([0:0.5pi:3pi]...)
# ax1.set_xticklabels(("Tom", "Dick", "Harry", "Sally", "Sue", "Zhisong"))
ax1.set_xticklabels(["0", "0.5pi", "1.0pi", "1.5pi", "2.0pi", "2.5pi", "3.0pi"], fontname="Times New Roman", fontsize=14)
ax1.grid("True")
ax1.legend(["Pade0", "Pade1", "Pade2", "Pade3", "Pade4"], 
loc="upper right", fontsize=14, edgecolor="none", facecolor="none")

# ax1.text(1.0, 60.0, "JJW", fontsize=12,fontname="Times New Roman"
# ,horizontalalignment="right",verticalalignment="bottom")

ax2 = subplot(1,2,2)
ax2.plot(
        x, y0./y0.*100 .-100, "k-"
      , x, y1./y0.*100 .-100, "b-"
      , x, y2./y0.*100 .-100, "r-"
      , x, y3./y0.*100 .-100, "m-"
      , x, y4./y0.*100 .-100, "g-"
      , linewidth=1.50)

        # , x, y3./y0 .-0, "m-"
    # , x, y4./y0 .-0, "g-"

ax2.set_xlabel("kh", fontname="Times New Roman", fontsize=14)
ax2.set_ylabel("Error (%)", fontname="Times New Roman", fontsize=14)
# ax2.set_title("Linear dispersion", fontname="Times New Roman")
ax2.set_xlim([0, 3pi])
ax2.set_ylim([-10, 10])

ax2.set_xticks([0:0.5pi:3pi]...)
# ax2.set_xticklabels(("Tom", "Dick", "Harry", "Sally", "Sue", "Zhisong"))
ax2.set_xticklabels(["0", "0.5pi", "1.0pi", "1.5pi", "2.0pi", "2.5pi", "3.0pi"], fontname="Times New Roman", fontsize=14)
ax2.set_yticks([-10:2:10]...)

ax2.grid("True")
ax2.legend(["Pade0", "Pade1", "Pade2", "Pade3", "Pade4"], 
loc="upper left", fontsize=14, edgecolor="none", facecolor="none")



# PyPlot.grid("True")
fig.tight_layout()

fig.savefig(string(FigureName,".pdf"))
fig.savefig(string(FigureName,".eps"))
fig.savefig(string(FigureName,".png"))

fig.show()
