# The Gradient

### Line Integrals and the Gradient

We looked at the relationship between
1. $\oint_C v{F} \cdot unit{t} \\, ds = 0$ for any closed curve $C$.
2. $\nabla \times v{F} = 0$.

Two results:

* First implies second
  - also equivalent to saying that the line integral of $v{F} \cdot unit{t}$ is path-independent.
* Second implies first
  - if $v{F}$ is smooth in a simply connected region.

There's a third way to express this:

3. $v{F}$ is gradient of a scalar field $\psi$.

That is, if there's a scalar function $\psi$ such that

$$
F_x = \frac{\partial \psi}{\partial x}, \quad
F_y = \frac{\partial \psi}{\partial y}, \quad
F_z = \frac{\partial \psi}{\partial z}
$$

then line integral of $v{F} \cdot unit{t}$ is path-independent.

($=>$) Proving if $v{F}$ is gradient of some scalar function $\psi$, then line integral is path-independent:

To show this, first note that using the chain rule, we have:

$$
v{F} \cdot unit{t} = \frac{\partial \psi}{\partial x} \frac{dx}{ds} + \frac{\partial \psi}{\partial y} \frac{dy}{ds} + \frac{\partial \psi}{\partial z} \frac{dz}{ds} = \frac{d\psi}{ds}
$$

then using the Fundamental Theorem of Calculus, we have:

$$
\int_C v{F} \cdot unit{t} \, ds = \int_C \frac{d\psi}{ds} \, ds = \psi(x_1, y_1, z_1) - \psi(x_0, y_0, z_0)
$$

($\impliedby$) Now, we prove the converse: if line integral is path-independent, then $v{F}$ is a gradient of some scalar function $\psi$.

Fix $(x_0, y_0, z_0)$ and define $\psi(x, y, z)$ as:

$$
\psi(x, y, z) = \int_{(x_0, y_0, z_0)}^{(x, y, z)} v{F} \cdot unit{t} \, ds
$$

Since the line integral is path-independent, we can change the path to:
- from $P_0=(x_0, y_0, z_0)$ to $P_1=(a, y, z)$, where $a$ is some constant,
- then from $P_1$ to $P=(x, y, z)$.

Then:

$$
\begin{align*}
\psi(x, y, z) &= \int_{P_0}^{P_1} v{F} \cdot unit{t} \, ds + \int_{P_1}^{P} v{F} \cdot unit{t} \, ds
\\
&= \int_{P_0}^{P_1} v{F} \cdot unit{t} \, ds + \int_{P_1}^{P} F_x(x', y, z) \, dx'
\end{align*}
$$

Since the first term on the right-hand side is independent of $x$, when we differentiate $\psi$ with respect to $x$, we have:

$$
\frac{\partial \psi}{\partial x} = F_x(x, y, z)
$$

Similarly, we can show that:

$$
\frac{\partial \psi}{\partial y} = F_y(x, y, z), \quad
\frac{\partial \psi}{\partial z} = F_z(x, y, z)
$$

------------

This can be written as:

$$
\begin{align*}
v{F} &= v{i} \frac{\partial \psi}{\partial x} + v{j} \frac{\partial \psi}{\partial y} + v{k} \frac{\partial \psi}{\partial z}
\\[0.5em]
&= ( v{i} \frac{\partial}{\partial x} + v{j} \frac{\partial}{\partial y}
\+ v{k} \frac{\partial}{\partial z} ) \psi = \nabla \psi
\end{align*}
$$

which we read "**del psi**". This operator is called the **gradient**.

The gradient of $\psi$ is a _vector function_ of position.

--------------

Similarly, if $v{F} = \nabla \psi$ under suitable conditions, then $\nabla \times v{F} = 0$:

$$
\begin{align*}
(\nabla \times v{F})_x &= \frac{\partial F_z}{\partial y} - \frac{\partial F_y}{\partial z} = \frac{\partial}{\partial y} ( \frac{\partial \psi}{\partial z} ) - \frac{\partial}{\partial z} ( \frac{\partial \psi}{\partial y} )
\\[0.5em]
&= \frac{\partial^2 \psi}{\partial y \partial z} - \frac{\partial^2 \psi}{\partial z \partial y} = 0
\end{align*}
$$

The last equality holds if $\psi$ and its first and second derivatives are continuous.

The other components can be shown similarly to be zero.

-----------------

The converse: If $\nabla \times v{F} = 0$ in a simply connected region, then $v{F}$ is a gradient of some scalar function $\psi$.

-----------------

In normal circumstances, where our functions have continuous first derivatives and the
regions are simply connected, then the three conditions are equivalent:

1. $\oint_C v{F} \cdot unit{t} \\, ds = 0$ independent of path.
2. $\nabla \times v{F} = 0$.
3. $v{F} = \nabla \psi$ for some scalar function $\psi$.

### Finding the Electrostatic Field

As we saw, differential form of Gauss' Law is:

$$
\nabla \cdot v{E} = \frac{\rho}{eps_0}
$$

It is not very useful, since it is **one equation with three unknowns** ($E_x$, $E_y$, and $E_z$).

Since $v{E}$ is a gradient of some scalar function, we can define **electrostatic potential** $\Phi$ such that:

$$
v{E} = - \nabla \Phi
$$

Substituting this into Gauss' Law, we have:

$$
\frac{\partial^2 \Phi}{\partial x^2} + \frac{\partial^2 \Phi}{\partial y^2} + \frac{\partial^2 \Phi}{\partial z^2} = -\frac{\rho}{eps_0}
\tag{IV-5}
$$

We define the **Laplacian** operator as:

$$
\nabla^2 = \nabla \cdot \nabla = \frac{\partial^2}{\partial x^2} + \frac{\partial^2}{\partial y^2} + \frac{\partial^2}{\partial z^2}
\tag{IV-6}
$$

Then (IV-5) can be written as:

$$
\nabla^2 \Phi = -\frac{\rho}{eps_0}
\tag{IV-7}
$$

This is called the **Poisson's equation**. It is a linear, second-order partial differential equation in **one unknown**, the scalar function $\Phi$.

At any point in space where there is no charge, $\rho = 0$, then (IV-7) becomes:

$$
\nabla^2 \Phi = 0
$$

This is called the **Laplace's equation**.

### Directional Derivatives and the Gradient

The rate of change of the function $f$ in the direction of a unit vector $unit{u}$ is given by the **directional derivative**:

$$
\frac{df}{ds} = unit{u} \cdot \nabla f
$$

The book gives an argument on how to derive this using the Taylor expansion.

It follows from this that the gradient of a scalar function $f$ is the vector that points in the direction of greatest increase of $f$, and its magnitude is the rate of increase in that direction.
