**Problem III-23.** 
**(a)** Let $C$ be a closed curve lying in the $xy$-plane. What condition must the
function $\mathbf{F}$ satisfy in order that

$$
\oint_C \mathbf{F} \cdot \hat{\mathbf{t}} \, ds = A
$$

where $A$ is the area enclosed by $C$?

:::expandable
**Solution.** [Click to Expand]

Using the 2-dimensional Stokes' theorem, we have:

$$
\oint_C F_x \, dx + F_y \, dy = \iint_R \left( \frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} \right) \, dx \, dy
$$

So, in order for the line integral to be equal to the area enclosed by $C$, we need:

$$
\frac{\partial F_y}{\partial x} - \frac{\partial F_x}{\partial y} = 1
$$

or equivalently:

$$
\nabla \times \mathbf{F} = \mathbf{k}
$$
::::

**(b)** Give some examples of functions $\mathbf{F}$ having the property described in part (a).

:::expandable
**Solution.** [Click to Expand]

- $\mathbf{F} = \mathbf{i} y + 2 \mathbf{j} x$
- $\mathbf{F} = \hat{\mathbf{e}}_\theta \dfrac{r}{2}$ (cylendrical coordinates)
::::

**(c)** Use line integrals to find formulas for the area of
- a rectangle
- a right triangle
- a circle

:::expandable
**A Rectangle.** [Click to Expand]

Let $\mathbf{F} = \mathbf{i} y + 2 \mathbf{j} x$ and consider the rectangle below:

 ![](III-23a.png)

Then, we have:

$$
\begin{align*}
\int_{C_1} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds &= 0 \\[0.8em]
\int_{C_2} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds &= \int_{0}^{a} 2 \cdot b \, dy = 2 a b \\[0.8em]
\int_{C_3} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds &= \int_{b}^{0} a \, dx = - a b \\[0.8em]
\int_{C_4} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds &= 0
\end{align*}
$$

Putting together, we have:

$$
\oint_{C_1 + C_2 + C_3 + C_4} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds = 2 a b - a b = a b
$$

::::

:::expandable
**A Right Triangle.** [Click to Expand]

Let $\mathbf{F} = \mathbf{i} y + 2 \mathbf{j} x$ and consider the right triangle below:

 ![](III-23b.jpg)

Then, we have:

$$
\begin{align*}
\int_{C_1} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds &= 0 \\[0.8em]
\int_{C_3} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds &= 0
\end{align*}
$$

For $C_2$, note that $y = \dfrac{b}{a} (a - x)$, so $dy = -\dfrac{b}{a} \\, dx$.

Then, we have:

$$
\begin{align*}
\int_{C_2} \mathbf{F} \cdot \hat{\mathbf{t}} \, ds &= 
\int_{C_2} (y \, dx + 2 x \, dy) \\[0.8em]
&= \int_{0}^{a} \left( \dfrac{b}{a} (a - x) \, dx - 2 x \dfrac{b}{a} \, dx \right) \\[0.8em]
&= \int_{0}^{a} \left( \dfrac{b}{a} (a - 3 x) \right) \, dx \\[0.8em]
&= \frac{ab}{2}
\end{align*}
$$

::::

:::expandable
**A Circle.** [Click to Expand]

Let $\mathbf{F} = \hat{\mathbf{e}}\_\theta \dfrac{r}{2}$. We have $ds = r \\, d\theta$ and $\hat{\mathbf{t}} = \hat{\mathbf{e}}\_\theta$.

Then, we have:

$$
\begin{align*}
\oint_C \mathbf{F} \cdot \hat{\mathbf{t}} \, ds &= \oint_C \left( \frac{r}{2} \right) r \, d\theta \\[0.8em]
&= \frac{r^2}{2} \int_0^{2\pi}  \, d\theta = \pi r^2
\end{align*}
$$

::::

**(d)** Show that the area enclosed by the plane curve $C$ is the magnitude of

$$
\frac{1}{2} \oint_C \mathbf{r} \times \hat{\mathbf{t}} \, ds
$$

where $\mathbf{r} = \mathbf{i} x + \mathbf{j} y$.

:::expandable
**Solution.** [Click to Expand]

We have $\hat{\mathbf{t}} = \mathbf{i} \dfrac{dx}{ds} + \mathbf{j} \dfrac{dy}{ds}$, then:

$$
\begin{align*}
\mathbf{r} \times \hat{\mathbf{t}} &= \mathbf{k} \left( x \frac{dy}{ds} - y \frac{dx}{ds} \right) \\[0.8em]
&= \mathbf{k} \left( (-y \mathbf{i} + x \mathbf{j}) \cdot \hat{\mathbf{t}} \right)
\end{align*}
$$

Then, we have:

$$
\frac{1}{2} \oint_C \mathbf{r} \times \hat{\mathbf{t}} \, ds = \frac{\mathbf{k}}{2} \oint_C (-y \mathbf{i} + x \mathbf{j}) \cdot \hat{\mathbf{t}} \, ds
$$

Since $\nabla \times (-y \mathbf{i} + x \mathbf{j}) = 2 \mathbf{k}$, then by Stokes' theorem we have:

$$
\oint_C (-y \mathbf{i} + x \mathbf{j}) \cdot \hat{\mathbf{t}} \, ds = 2 A
$$

Then, we have:

$$
\frac{1}{2} \oint_C \mathbf{r} \times \hat{\mathbf{t}} \, ds = A \mathbf{k}
$$

which has a magnitude of $A$.

::::
