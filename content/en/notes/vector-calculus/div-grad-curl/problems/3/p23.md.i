**Problem III-23.**
**(a)** Let $C$ be a closed curve lying in the $xy$-plane. What condition must the
function $v{F}$ satisfy in order that

$$
\oint_C v{F} \cdot unit{t} \, ds = A
$$

where $A$ is the area enclosed by $C$?

:::expandable
**Solution.** [Click to Expand]

Using the 2-dimensional Stokes' theorem, we have:

$$
\oint_C F_x \, dx + F_y \, dy = \iint_R ( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} ) \, dx \, dy
$$

So, in order for the line integral to be equal to the area enclosed by $C$, we need:

$$
\frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} = 1
$$

or equivalently:

$$
\nabla \times v{F} = v{k}
$$
::::

**(b)** Give some examples of functions $v{F}$ having the property described in part (a).

:::expandable
**Solution.** [Click to Expand]

- $v{F} = v{i} y + 2 v{j} x$
- $v{F} = unit{e}_\theta \dfrac{r}{2}$ (cylendrical coordinates)
::::

**(c)** Use line integrals to find formulas for the area of
- a rectangle
- a right triangle
- a circle

:::expandable
**A Rectangle.** [Click to Expand]

Let $v{F} = v{i} y + 2 v{j} x$ and consider the rectangle below:

 ![](III-23a.png)

Then, we have:

$$
\begin{align*}
\int_{C_1} v{F} \cdot unit{t} \, ds &= 0 \\[0.8em]
\int_{C_2} v{F} \cdot unit{t} \, ds &= \int_{0}^{a} 2 \cdot b \, dy = 2 a b \\[0.8em]
\int_{C_3} v{F} \cdot unit{t} \, ds &= \int_{b}^{0} a \, dx = - a b \\[0.8em]
\int_{C_4} v{F} \cdot unit{t} \, ds &= 0
\end{align*}
$$

Putting together, we have:

$$
\oint_{C_1 + C_2 + C_3 + C_4} v{F} \cdot unit{t} \, ds = 2 a b - a b = a b
$$

::::

:::expandable
**A Right Triangle.** [Click to Expand]

Let $v{F} = v{i} y + 2 v{j} x$ and consider the right triangle below:

 ![](III-23b.jpg)

Then, we have:

$$
\begin{align*}
\int_{C_1} v{F} \cdot unit{t} \, ds &= 0 \\[0.8em]
\int_{C_3} v{F} \cdot unit{t} \, ds &= 0
\end{align*}
$$

For $C_2$, note that $y = \dfrac{b}{a} (a - x)$, so $dy = -\dfrac{b}{a} \\, dx$.

Then, we have:

$$
\begin{align*}
\int_{C_2} v{F} \cdot unit{t} \, ds &=
\int_{C_2} (y \, dx + 2 x \, dy) \\[0.8em]
&= \int_{0}^{a} ( \dfrac{b}{a} (a - x) \, dx - 2 x \dfrac{b}{a} \, dx ) \\[0.8em]
&= \int_{0}^{a} ( \dfrac{b}{a} (a - 3 x) ) \, dx \\[0.8em]
&= \frac{ab}{2}
\end{align*}
$$

::::

:::expandable
**A Circle.** [Click to Expand]

Let $v{F} = unit{e}_\theta \dfrac{r}{2}$. We have $ds = r \\, d\theta$ and $unit{t} = unit{e}_\theta$.

Then, we have:

$$
\begin{align*}
\oint_C v{F} \cdot unit{t} \, ds &= \oint_C ( \frac{r}{2} ) r \, d\theta \\[0.8em]
&= \frac{r^2}{2} \int_0^{2\pi}  \, d\theta = \pi r^2
\end{align*}
$$

::::

**(d)** Show that the area enclosed by the plane curve $C$ is the magnitude of

$$
\frac{1}{2} \oint_C v{r} \times unit{t} \, ds
$$

where $v{r} = v{i} x + v{j} y$.

:::expandable
**Solution.** [Click to Expand]

We have $unit{t} = v{i} \dfrac{dx}{ds} + v{j} \dfrac{dy}{ds}$, then:

$$
\begin{align*}
v{r} \times unit{t} &= v{k} ( x \frac{dy}{ds} - y \frac{dx}{ds} ) \\[0.8em]
&= v{k} ( (-y v{i} + x v{j}) \cdot unit{t} )
\end{align*}
$$

Then, we have:

$$
\frac{1}{2} \oint_C v{r} \times unit{t} \, ds = \frac{v{k}}{2} \oint_C (-y v{i} + x v{j}) \cdot unit{t} \, ds
$$

Since $\nabla \times (-y v{i} + x v{j}) = 2 v{k}$, then by Stokes' theorem we have:

$$
\oint_C (-y v{i} + x v{j}) \cdot unit{t} \, ds = 2 A
$$

Then, we have:

$$
\frac{1}{2} \oint_C v{r} \times unit{t} \, ds = A v{k}
$$

which has a magnitude of $A$.

::::
