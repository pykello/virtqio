**Problem III-18.** The electromotive force $cal{E}$ in a circuit $C$ is equal to the
circulation of the electric field $v{E}$ around the circuit:

:::math
cal{E} = oint[C] v{E} dot unit{t} \, ds
:::

Faraday discovered that in a stationary circuit an electromotive force is induced by a
changing magnetic flux. That is,

:::math
cal{E} = - dd(Phi, t)
:::

where

:::math
Phi = iint[S] v{B} dot unit{n} \, dS
:::

$t$ is time (don't confuse it with the tangent vector $unit{t}$) and $S$ is
any capping surface of $C$. Use this information and Stokes' theorem to derive the
equation

:::math
\nabla cross v{E} = - pd(v{B}, t)
:::

which is one of Maxwell's equations.

:::expandable
**Solution.** [Click to Expand]

Since $cal{E} = oint[C] v{E} dot unit{t} \, ds$, then for any
capping surface $S$ of $C$, we have:

:::math
cal{E} = iint[S] \nabla cross v{E} dot unit{n} \, dS #tag 1
:::

Differentiating $Phi = iint[S] v{B} dot unit{n} \, dS$ with respect to $t$, we have:

:::math
dd(Phi, t) = iint[S] pd(v{B}, t) dot unit{n} \, dS
:::

Where we used the fact that $S$ is stationary, so $unit{n}$ does not depend on $t$.

From the problem statement we know that $cal{E} = - dd(Phi, t)$. Then, we have:

:::math
cal{E} = - iint[S] pd(v{B}, t) dot unit{n} \, dS #tag 2
:::

Putting (1) and (2) together, we have:

:::math
iint[S] \nabla cross v{E} dot unit{n} \, dS = - iint[S] pd(v{B}, t) dot unit{n} \, dS
:::

Since this is true for any capping surface $S$ of $C$, we have:

:::math
\nabla cross v{E} = - pd(v{B}, t)
:::
::::
