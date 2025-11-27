**Problem III-18.** The electromotive force $\mathcal{E}$ in a circuit $C$ is equal to the
circulation of the electric field $\mathbf{E}$ around the circuit:

$$
\mathcal{E} = \oint_C \mathbf{E} \cdot \hat{\mathbf{t}} \, ds
$$

Faraday discovered that in a stationary circuit an electromotive force is induced by a 
changing magnetic flux. That is,

$$
\mathcal{E} = - \frac{d \Phi}{dt}
$$

where

$$
\Phi = \iint_S \mathbf{B} \cdot \hat{\mathbf{n}} \, dS
$$

$t$ is time (don't confuse it with the tangent vector $\hat{\mathbf{t}}$) and $S$ is
any capping surface of $C$. Use this information and Stokes' theorem to derive the
equation

$$
\nabla \times \mathbf{E} = - \frac{\partial \mathbf{B}}{\partial t}
$$

which is one of Maxwell's equations.

:::expandable
**Solution.** [Click to Expand]

Since $\mathcal{E} = \oint_C \mathbf{E} \cdot \hat{\mathbf{t}} \\, ds$, then for any
capping surface $S$ of $C$, we have:

$$
\mathcal{E} = \iint_S \nabla \times \mathbf{E} \cdot \hat{\mathbf{n}} \, dS \tag{1}
$$

Differentiating $\Phi = \iint_S \mathbf{B} \cdot \hat{\mathbf{n}} \\, dS$ with respect to $t$, we have:

$$
\frac{d \Phi}{d t} = \iint_S \frac{\partial \mathbf{B}}{\partial t} \cdot \hat{\mathbf{n}} \, dS
$$

Where we used the fact that $S$ is stationary, so $\hat{\mathbf{n}}$ does not depend on $t$.

From the problem statement we know that $\mathcal{E} = - \dfrac{d \Phi}{dt}$. Then, we have:

$$
\mathcal{E} = - \iint_S \frac{\partial \mathbf{B}}{\partial t} \cdot \hat{\mathbf{n}} \, dS \tag{2}
$$

Putting (1) and (2) together, we have:

$$
\iint_S \nabla \times \mathbf{E} \cdot \hat{\mathbf{n}} \, dS = - \iint_S \frac{\partial \mathbf{B}}{\partial t} \cdot \hat{\mathbf{n}} \, dS
$$

Since this is true for any capping surface $S$ of $C$, we have:

$$
\nabla \times \mathbf{E} = - \frac{\partial \mathbf{B}}{\partial t}
$$
::::
