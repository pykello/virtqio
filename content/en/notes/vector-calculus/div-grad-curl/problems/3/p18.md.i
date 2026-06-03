**Problem III-18.** The electromotive force $cal{E}$ in a circuit $C$ is equal to the
circulation of the electric field $v{E}$ around the circuit:

$$
cal{E} = \oint_C v{E} \cdot unit{t} \, ds
$$

Faraday discovered that in a stationary circuit an electromotive force is induced by a
changing magnetic flux. That is,

$$
cal{E} = - \frac{d \Phi}{dt}
$$

where

$$
\Phi = \iint_S v{B} \cdot unit{n} \, dS
$$

$t$ is time (don't confuse it with the tangent vector $unit{t}$) and $S$ is
any capping surface of $C$. Use this information and Stokes' theorem to derive the
equation

$$
\nabla \times v{E} = - \frac{\partial v{B}}{\partial t}
$$

which is one of Maxwell's equations.

:::expandable
**Solution.** [Click to Expand]

Since $cal{E} = \oint_C v{E} \cdot unit{t} \\, ds$, then for any
capping surface $S$ of $C$, we have:

$$
cal{E} = \iint_S \nabla \times v{E} \cdot unit{n} \, dS \tag{1}
$$

Differentiating $\Phi = \iint_S v{B} \cdot unit{n} \\, dS$ with respect to $t$, we have:

$$
\frac{d \Phi}{d t} = \iint_S \frac{\partial v{B}}{\partial t} \cdot unit{n} \, dS
$$

Where we used the fact that $S$ is stationary, so $unit{n}$ does not depend on $t$.

From the problem statement we know that $cal{E} = - \dfrac{d \Phi}{dt}$. Then, we have:

$$
cal{E} = - \iint_S \frac{\partial v{B}}{\partial t} \cdot unit{n} \, dS \tag{2}
$$

Putting (1) and (2) together, we have:

$$
\iint_S \nabla \times v{E} \cdot unit{n} \, dS = - \iint_S \frac{\partial v{B}}{\partial t} \cdot unit{n} \, dS
$$

Since this is true for any capping surface $S$ of $C$, we have:

$$
\nabla \times v{E} = - \frac{\partial v{B}}{\partial t}
$$
::::
