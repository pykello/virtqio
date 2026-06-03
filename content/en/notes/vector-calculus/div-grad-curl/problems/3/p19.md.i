**Problem III-19.** Determine the value of the line integral $\int_C v{F} \cdot unit{t} \\, ds$, where

$$
v{F} = (e^{-y} - z e^{-x}) v{i} + (e^{-z} - x e^{-y}) v{j} + (e^{-x} - y e^{-z}) v{k}
$$

and $C$ is the path

$$
\begin{cases}
x = \dfrac{1}{\ln 2} \ln(1 + p), \\
y = \sin(\dfrac{\pi p}{2}), \\
z = \dfrac{1 - e^p}{1 - e},
\end{cases}
\quad 0 <= p <= 1
$$

from $(0, 0, 0)$ to $(1, 1, 1)$.

:::expandable
**Solution.** [Click to Expand]

Since $\nabla \times v{F} = 0$, the line integral is independent of the path taken.

Then we can use:
 - $C_1$: straight segment from $(0, 0, 0)$ to $(1, 0, 0)$,
 - $C_2$: straight segment from $(1, 0, 0)$ to $(1, 1, 0)$,
 - $C_3$: straight segment from $(1, 1, 0)$ to $(1, 1, 1)$.

Then we have:

$$
\begin{align*}
\int_{C_1} v{F} \cdot unit{t} \, ds &= \int_{0}^{1} e^0 \, dx = 1 \\[1em]
\int_{C_2} v{F} \cdot unit{t} \, ds &= \int_{0}^{1} (1 - e^{-y}) \, dy = e^{-1} \\[1em]
\int_{C_3} v{F} \cdot unit{t} \, ds &= \int_{0}^{1} (e^{-1} - e^{-z}) \, dz = 2 e^{-1} - 1
\end{align*}
$$

Then, we have:

$$
\int_C v{F} \cdot unit{t} \, ds =  \int_{C_1 + C_2 + C_3} v{F} \cdot unit{t} \, ds = 3 e^{-1}
$$

::::
