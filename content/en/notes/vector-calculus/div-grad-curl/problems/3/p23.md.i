**Problem III-23.**
**(a)** Let $C$ be a closed curve lying in the $xy$-plane. What condition must the
function $v{F}$ satisfy in order that

:::math
oint[C] v{F} dot unit{t} \, ds = A
:::

where $A$ is the area enclosed by $C$?

:::expandable
**Solution.** [Click to Expand]

Using the 2-dimensional Stokes' theorem, we have:

:::math
oint[C] F_x \, dx + F_y \, dy = iint[R] ( pd(F_y, x) - pd(F_x, y) ) \, dx \, dy
:::

So, in order for the line integral to be equal to the area enclosed by $C$, we need:

:::math
pd(F_y, x) - pd(F_x, y) = 1
:::

or equivalently:

:::math
\nabla cross v{F} = v{k}
:::
::::

**(b)** Give some examples of functions $v{F}$ having the property described in part (a).

:::expandable
**Solution.** [Click to Expand]

- $v{F} = v{i} y + 2 v{j} x$
- $v{F} = unit{e}_theta \dfrac{r}{2}$ (cylendrical coordinates)
::::

**(c)** Use line integrals to find formulas for the area of
- a rectangle
- a right triangle
- a circle

:::expandable
**A Rectangle.** [Click to Expand]

Let $v{F} = v{i} y + 2 v{j} x$ and consider the rectangle below:

:::figure III-23a.png
:::

Then, we have:

:::math align
int[C_1] v{F} dot unit{t} \, ds &= 0
int[C_2] v{F} dot unit{t} \, ds &= int[0..a] 2 dot b \, dy = 2 a b
int[C_3] v{F} dot unit{t} \, ds &= int[b..0] a \, dx = - a b
int[C_4] v{F} dot unit{t} \, ds &= 0
:::

Putting together, we have:

:::math
oint[C_1 + C_2 + C_3 + C_4] v{F} dot unit{t} \, ds = 2 a b - a b = a b
:::

::::

:::expandable
**A Right Triangle.** [Click to Expand]

Let $v{F} = v{i} y + 2 v{j} x$ and consider the right triangle below:

:::figure III-23b.jpg
:::

Then, we have:

:::math align
int[C_1] v{F} dot unit{t} \, ds &= 0
int[C_3] v{F} dot unit{t} \, ds &= 0
:::

For $C_2$, note that $y = \dfrac{b}{a} (a - x)$, so $dy = -\dfrac{b}{a} \, dx$.

Then, we have:

:::math align
int[C_2] v{F} dot unit{t} \, ds &= int[C_2] (y \, dx + 2 x \, dy)
&= int[0..a] ( \dfrac{b}{a} (a - x) \, dx - 2 x \dfrac{b}{a} \, dx )
&= int[0..a] ( \dfrac{b}{a} (a - 3 x) ) \, dx
&= \frac{ab}{2}
:::

::::

:::expandable
**A Circle.** [Click to Expand]

Let $v{F} = unit{e}_theta \dfrac{r}{2}$. We have $ds = r \, dtheta$ and $unit{t} = unit{e}_theta$.

Then, we have:

:::math align
oint[C] v{F} dot unit{t} \, ds &= oint[C] ( \frac{r}{2} ) r \, dtheta
&= \frac{r^2}{2} int[0..2pi]  \, dtheta = pi r^2
:::

::::

**(d)** Show that the area enclosed by the plane curve $C$ is the magnitude of

:::math
\frac{1}{2} oint[C] v{r} cross unit{t} \, ds
:::

where $v{r} = v{i} x + v{j} y$.

:::expandable
**Solution.** [Click to Expand]

We have $unit{t} = v{i} dd(x, s) + v{j} dd(y, s)$, then:

:::math align
v{r} cross unit{t} &= v{k} ( x dd(y, s) - y dd(x, s) )
&= v{k} ( (-y v{i} + x v{j}) dot unit{t} )
:::

Then, we have:

:::math
\frac{1}{2} oint[C] v{r} cross unit{t} \, ds = \frac{v{k}}{2} oint[C] (-y v{i} + x v{j}) dot unit{t} \, ds
:::

Since $\nabla cross (-y v{i} + x v{j}) = 2 v{k}$, then by Stokes' theorem we have:

:::math
oint[C] (-y v{i} + x v{j}) dot unit{t} \, ds = 2 A
:::

Then, we have:

:::math
\frac{1}{2} oint[C] v{r} cross unit{t} \, ds = A v{k}
:::

which has a magnitude of $A$.

::::
