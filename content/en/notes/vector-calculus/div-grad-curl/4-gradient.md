# The Gradient

### Line Integrals and the Gradient

We looked at the relationship between
1. $oint[C] v{F} dot unit{t} \, ds = 0$ for any closed curve $C$.
2. $\nabla cross v{F} = 0$.

Two results:

* First implies second
  - also equivalent to saying that the line integral of $v{F} dot unit{t}$ is path-independent.
* Second implies first
  - if $v{F}$ is smooth in a simply connected region.

There's a third way to express this:

3. $v{F}$ is gradient of a scalar field $psi$.

That is, if there's a scalar function $psi$ such that

:::math
F_x = pd(psi, x), \quad
F_y = pd(psi, y), \quad
F_z = pd(psi, z)
:::

then line integral of $v{F} dot unit{t}$ is path-independent.

($=>$) Proving if $v{F}$ is gradient of some scalar function $psi$, then line integral is path-independent:

To show this, first note that using the chain rule, we have:

:::math
v{F} dot unit{t} = pd(psi, x) dd(x, s) + pd(psi, y) dd(y, s) + pd(psi, z) dd(z, s) = dd(psi, s)
:::

then using the Fundamental Theorem of Calculus, we have:

:::math
int[C] v{F} dot unit{t} \, ds = int[C] dd(psi, s) \, ds = psi(x_1, y_1, z_1) - psi(x_0, y_0, z_0)
:::

($\impliedby$) Now, we prove the converse: if line integral is path-independent, then $v{F}$ is a gradient of some scalar function $psi$.

Fix $(x_0, y_0, z_0)$ and define $psi(x, y, z)$ as:

:::math
psi(x, y, z) = int[(x_0, y_0, z_0)..(x, y, z)] v{F} dot unit{t} \, ds
:::

Since the line integral is path-independent, we can change the path to:
- from $P_0=(x_0, y_0, z_0)$ to $P_1=(a, y, z)$, where $a$ is some constant,
- then from $P_1$ to $P=(x, y, z)$.

Then:

:::math align
psi(x, y, z) &= int[P_0..P_1] v{F} dot unit{t} \, ds + int[P_1..P] v{F} dot unit{t} \, ds
&= int[P_0..P_1] v{F} dot unit{t} \, ds + int[P_1..P] F_x(x', y, z) \, dx'
:::

Since the first term on the right-hand side is independent of $x$, when we differentiate $psi$ with respect to $x$, we have:

:::math
pd(psi, x) = F_x(x, y, z)
:::

Similarly, we can show that:

:::math
pd(psi, y) = F_y(x, y, z), \quad
pd(psi, z) = F_z(x, y, z)
:::

------------

This can be written as:

:::math align
v{F} &= v{i} pd(psi, x) + v{j} pd(psi, y) + v{k} pd(psi, z)
&= ( v{i} pd(\partial, x) + v{j} pd(\partial, y) + v{k} pd(\partial, z) ) psi = \nabla psi
:::

which we read "**del psi**". This operator is called the **gradient**.

The gradient of $psi$ is a _vector function_ of position.

--------------

Similarly, if $v{F} = \nabla psi$ under suitable conditions, then $\nabla cross v{F} = 0$:

:::math align
(\nabla cross v{F})_x &= pd(F_z, y) - pd(F_y, z) = pd(\partial, y) ( pd(psi, z) ) - pd(\partial, z) ( pd(psi, y) )
&= pd2(psi, y, z) - pd2(psi, z, y) = 0
:::

The last equality holds if $psi$ and its first and second derivatives are continuous.

The other components can be shown similarly to be zero.

-----------------

The converse: If $\nabla cross v{F} = 0$ in a simply connected region, then $v{F}$ is a gradient of some scalar function $psi$.

-----------------

In normal circumstances, where our functions have continuous first derivatives and the
regions are simply connected, then the three conditions are equivalent:

1. $oint[C] v{F} dot unit{t} \, ds = 0$ independent of path.
2. $\nabla cross v{F} = 0$.
3. $v{F} = \nabla psi$ for some scalar function $psi$.

### Finding the Electrostatic Field

As we saw, differential form of Gauss' Law is:

:::math
\nabla dot v{E} = \frac{rho}{eps_0}
:::

It is not very useful, since it is **one equation with three unknowns** ($E_x$, $E_y$, and $E_z$).

Since $v{E}$ is a gradient of some scalar function, we can define **electrostatic potential** $Phi$ such that:

:::math
v{E} = - \nabla Phi
:::

Substituting this into Gauss' Law, we have:

:::math
pd(\partial^2 Phi, x^2) + pd(\partial^2 Phi, y^2) + pd(\partial^2 Phi, z^2) = -\frac{rho}{eps_0}
\qquad\text{(IV-5)}
:::

We define the **Laplacian** operator as:

:::math
\nabla^2 = \nabla dot \nabla = pd(\partial^2, x^2) + pd(\partial^2, y^2) + pd(\partial^2, z^2)
\qquad\text{(IV-6)}
:::

Then (IV-5) can be written as:

:::math
\nabla^2 Phi = -\frac{rho}{eps_0}
\qquad\text{(IV-7)}
:::

This is called the **Poisson's equation**. It is a linear, second-order partial differential equation in **one unknown**, the scalar function $Phi$.

At any point in space where there is no charge, $rho = 0$, then (IV-7) becomes:

:::math
\nabla^2 Phi = 0
:::

This is called the **Laplace's equation**.

### Directional Derivatives and the Gradient

The rate of change of the function $f$ in the direction of a unit vector $unit{u}$ is given by the **directional derivative**:

:::math
dd(f, s) = unit{u} dot \nabla f
:::

The book gives an argument on how to derive this using the Taylor expansion.

It follows from this that the gradient of a scalar function $f$ is the vector that points in the direction of greatest increase of $f$, and its magnitude is the rate of increase in that direction.
