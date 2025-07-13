**Problem III-19.** Determine the value of the line integral $\int_C \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds$, where

$$
\mathbf{F} = (e^{-y} - z e^{-x}) \mathbf{i} + (e^{-z} - x e^{-y}) \mathbf{j} + (e^{-x} - y e^{-z}) \mathbf{k}
$$

and $C$ is the path

$$
\begin{cases}
x = \dfrac{1}{\ln 2} \ln(1 + p), \\\\
y = \sin\left(\dfrac{\pi p}{2}\right), \\\\
z = \dfrac{1 - e^p}{1 - e},
\end{cases}
\quad 0 \leq p \leq 1
$$

from $(0, 0, 0)$ to $(1, 1, 1)$.

:::expandable
**Solution.** [Click to Expand]

Since $\nabla \times \mathbf{F} = 0$, the line integral is independent of the path taken.

Then we can use:
 - $C_1$: straight segment from $(0, 0, 0)$ to $(1, 0, 0)$,
 - $C_2$: straight segment from $(1, 0, 0)$ to $(1, 1, 0)$,
 - $C_3$: straight segment from $(1, 1, 0)$ to $(1, 1, 1)$.

Then we have:

$$
\begin{align*}
\int_{C_1} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{0}^{1} e^0 \\, dx = 1 \\\\[1em]
\int_{C_2} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{0}^{1} (1 - e^{-y}) \\, dy = e^{-1} \\\\[1em]
\int_{C_3} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{0}^{1} (e^{-1} - e^{-z}) \\, dz = 2 e^{-1} - 1
\end{align*}
$$

Then, we have:

$$
\int_C \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds =  \int_{C_1 + C_2 + C_3} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds = 3 e^{-1}
$$

::::
