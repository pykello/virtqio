**Problem III-2.**
In the text we obtained the result

:::math
(\nabla cross v{F})_z = pd(F_y, x) - pd(F_x, y)
:::

by integrating over a small rectanglular path. As an example of the fact that this result
is independent of the path, rederive it, using a triangular path.

:::expandable
**Solution.** [Click to Expand]

:::figure III-2.png
:::

Assume the force $v{F}$ is given by:

:::math
v{F} = F_x v{i} + F_y v{j} + F_z v{k}
:::

In the text on page 68 we saw that:

:::math
int[C] v{F} dot unit{t} \, ds = int[C] (F_x \, dx + F_y \, dy + F_z \, dz)
:::

Then for $C_1$, we have:

:::math align
int[C_1] v{F} dot unit{t} \, ds &= int[y + Delta y / 2..y - Delta y / 2] F_y(x - \frac{Delta x}{2} , u) \, du
& \approx -F_y(x - \frac{Delta x}{2} , y) Delta y
:::

and for $C_2$, we have:

:::math align
int[C_2] v{F} dot unit{t} \, ds &= int[x - Delta x / 2..x + Delta x / 2] F_x(u, y - \frac{Delta y}{2}) \, du
& \approx F_x(x, y - \frac{Delta y}{2}) Delta x
:::

and for $C_3$, we have:

:::math align
int[C_3] v{F} dot unit{t} \, ds &= int[C_3] ( F_x \, dx + F_y \, dy )
&= int[x + Delta x / 2..x - Delta x / 2] F_x(u, y(u)) \, du + int[y - Delta y / 2..y + Delta y / 2] F_y(x(u), u) \, du
& \approx -F_x(x, y) Delta x + F_y(x, y) Delta y
:::

Thus, we have:

:::math align
int[C_1+C_2+C_3] v{F} &dot unit{t} \, ds \approx
&Delta y ( F_y(x, y) - F_y(x - \frac{Delta x}{2}, y) ) +
&Delta x ( F_x(x, y - \frac{Delta y}{2}) - F_x(x, y) )
:::

Since $Delta A = \dfrac{Delta x Delta y}{2}$, we have:

:::math align
\frac{1}{Delta A} int[C_1+C_2+C_3] v{F} &dot unit{t} \, ds \approx
& \frac{F_y(x, y) - F_y(x - \frac{Delta x}{2}, y)} {Delta x / 2} -
&\frac{F_x(x, y) - F_x(x, y - \frac{Delta y}{2})}{Delta y / 2}
:::

So, we have:

:::math
lim[Delta A -> 0] \frac{1}{Delta A} int[C_1+C_2+C_3] v{F} dot unit{t} \, ds =
pd(F_y, x) - pd(F_x, y)
:::
::::
