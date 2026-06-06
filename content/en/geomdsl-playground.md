# GeomDSL Playground

## Menelaus' Theorem

Menelaus' theorem is a collinearity test for three points on the sidelines of a triangle. It says that a line cuts the three sidelines exactly when the product of the three directed side ratios is fixed.

:::math
D in AB,\quad E in BC,\quad F in CA

D,E,F \text{ collinear}

<=>

\frac{AD}{DB}\frac{BE}{EC}\frac{CF}{FA} = 1
:::

:::geomdsl width=660 alt="Menelaus theorem configuration with a transversal through the three sides of a triangle" caption="The transversal through D, E, and F cuts two sides of the triangle and the extension of the third."
scene(min=(-2.75,-2.35), max=(3.35,2.65), size=(6.8,5.6), grid=false, axes=false, frame=false, ticks=false, tick_labels=false)

include "geomdsl-common.geom"

style triangle_fill = {color: "#dceeff", opacity: 0.45, z: 1}
style side = {color: "#1f2933", weight: 2.0, z: 10}
style extension = {color: "#7a8691", weight: 1.2, pattern: dashed, z: 4}
style transversal = {color: red, weight: 2.1, z: 12}
style cut_point = {color: red, size: 28, z: 20}

A = pt(-2, -1)
B = pt(2, -1)
C = pt(-1, 2)

sides = sidelines(A, B, C)
sideAB = sides[0]
sideBC = sides[1]
sideCA = sides[2]

D = midpoint(A, B)
transversal_line = perpendicular(sideCA, D)
E = intersect(transversal_line, sideBC)
F = intersect(transversal_line, sideCA)

T = polygon(A, B, C)

draw fill(T) @ triangle_fill
draw T @ side
draw LineSegment(B, E) @ extension
draw transversal_line @ transversal

draw marker(A)
draw marker(B)
draw marker(C)
draw marker(D) @ cut_point
draw marker(E) @ cut_point
draw marker(F) @ cut_point

draw point_label(A, "$A$")
draw point_label(B, "$B$")
draw point_label(C, "$C$")
draw point_label(D, "$D$") @ {color: red}
draw point_label(E, "$E$") @ {color: red}
draw point_label(F, "$F$") @ {color: red}
:::

:::proof[Proof of Menelaus' Theorem]
Work in affine coordinates on triangle $ABC$. Write

:::math
D = (1-u)A + uB,\quad
E = (1-v)B + vC,\quad
F = (1-w)C + wA.
:::

In barycentric coordinates relative to $A,B,C$, these points have coordinate rows

:::math
D = tuple(1-u, u, 0),\quad
E = tuple(0, 1-v, v),\quad
F = tuple(w, 0, 1-w).
:::

Three points are collinear exactly when their barycentric coordinate determinant is zero:

:::math
detmat(1-u, u, 0; 0, 1-v, v; w, 0, 1-w) = 0

<=>

(1-u)(1-v)(1-w) + u v w = 0

<=>

\frac{u}{1-u}\frac{v}{1-v}\frac{w}{1-w} = -1.
:::

The three factors are the directed ratios

:::math
\frac{\overline{AD}}{\overline{DB}},\quad
\frac{\overline{BE}}{\overline{EC}},\quad
\frac{\overline{CF}}{\overline{FA}}.
:::

Thus the directed product is $-1$. In the drawn case, $F$ lies on the extension past $C$, so the usual unsigned version reads

:::math
\frac{AD}{DB}\frac{BE}{EC}\frac{CF}{FA}=1.
:::
:::

## Pascal's Theorem

Pascal's theorem is a projective incidence theorem for six points on a conic. It says that the three intersections of opposite sides of the inscribed hexagon always fall on a single line, called the Pascal line.

:::math
set(A,B,C,D,E,F) subset cal{C}

X = AB inter DE,\quad
Y = BC inter EF,\quad
Z = CD inter FA

=> X,Y,Z \text{ are collinear}.
:::

:::geomdsl width=720 alt="Pascal theorem configuration for a hexagon inscribed in a circle" caption="For a hexagon on a conic, the three opposite-side intersections X, Y, and Z lie on one line."
scene(min=(-4.0,-2.65), max=(3.85,3.55), size=(7.6,5.8), grid=false, axes=false, frame=false, ticks=false, tick_labels=false)

include "geomdsl-common.geom"

style conic = {color: "#7a8691", weight: 1.2, z: 2, samples: 360}
style hexagon = {color: "#1f2933", weight: 1.7, z: 10}
style opposite = {color: "#8795a1", weight: 1.0, pattern: dashed, z: 4}
style pascal = {color: red, weight: 2.0, z: 12}
style pascal_point = {color: red, size: 27, z: 20}
style conic_point = {color: "#111827", size: 21, z: 18}

O = pt(0, 0)
K = Circle(O, 1)

thetaA = pi/10
thetaB = 2*pi/5
thetaC = 3*pi/5
thetaD = 17*pi/20
thetaE = 7*pi/5
thetaF = 19*pi/10

A = curve_at(K, thetaA)
B = curve_at(K, thetaB)
C = curve_at(K, thetaC)
D = curve_at(K, thetaD)
E = curve_at(K, thetaE)
F = curve_at(K, thetaF)

L_ab = secant(K, thetaA, thetaB)
L_bc = secant(K, thetaB, thetaC)
L_cd = secant(K, thetaC, thetaD)
L_de = secant(K, thetaD, thetaE)
L_ef = secant(K, thetaE, thetaF)
L_fa = secant(K, thetaF, thetaA)

X = intersect(L_ab, L_de)
Y = intersect(L_bc, L_ef)
Z = intersect(L_cd, L_fa)

H = polygon(A, B, C, D, E, F)

draw K @ conic
draw H @ hexagon

draw L_ab @ opposite
draw L_bc @ opposite
draw L_cd @ opposite
draw L_de @ opposite
draw L_ef @ opposite
draw L_fa @ opposite

draw line_through(X, Z) @ pascal

draw marker(A) @ conic_point
draw marker(B) @ conic_point
draw marker(C) @ conic_point
draw marker(D) @ conic_point
draw marker(E) @ conic_point
draw marker(F) @ conic_point
draw marker(X) @ pascal_point
draw marker(Y) @ pascal_point
draw marker(Z) @ pascal_point

draw point_label(A, "$A$")
draw point_label(B, "$B$")
draw point_label(C, "$C$")
draw point_label(D, "$D$")
draw point_label(E, "$E$")
draw point_label(F, "$F$")

draw point_label(X, "$X$") @ {color: red}
draw point_label(Y, "$Y$") @ {color: red}
draw point_label(Z, "$Z$") @ {color: red}
:::

:::proof[Proof of Pascal's Theorem]
The statement is projective, so it is enough to prove it for the standard conic

:::math
P(t)=tuple(1,t,t^2).
:::

The line through $P(u)$ and $P(v)$ has equation

:::math
\ell_{uv}:\quad uvX - (u+v)Y + Z = 0,
:::

because substituting $P(u)$ and $P(v)$ makes the left side vanish.

Let the six conic parameters be $a,b,c,d,e,f$. The three opposite-side intersections are

:::math
v{x}=\ell_{ab} cross \ell_{de},\quad
v{y}=\ell_{bc} cross \ell_{ef},\quad
v{z}=\ell_{cd} cross \ell_{fa}.
:::

For example,

:::math
v{x}=pmat(-a-b+d+e; -ab+de; -abd-abe+ade+bde).
:::

Substituting the analogous cyclic formulas for $v{y}$ and $v{z}$ and expanding gives

:::math
detmat(x_1, x_2, x_3; y_1, y_2, y_3; z_1, z_2, z_3)=0.
:::

Hence the homogeneous points $v{x},v{y},v{z}$ are linearly dependent. Linear dependence of three homogeneous point vectors is exactly collinearity, so $X,Y,Z$ lie on one line.
:::
