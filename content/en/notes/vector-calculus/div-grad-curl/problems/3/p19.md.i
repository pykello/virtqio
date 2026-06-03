**Problem III-19.** Determine the value of the line integral $int[C] v{F} dot unit{t} \, ds$, where

:::math
v{F} = (e^{-y} - z e^{-x}) v{i} + (e^{-z} - x e^{-y}) v{j} + (e^{-x} - y e^{-z}) v{k}
:::

and $C$ is the path

:::math plain
\begin{cases}
x = \dfrac{1}{\ln 2} \ln(1 + p), \\
y = \sin(\dfrac{pi p}{2}), \\
z = \dfrac{1 - e^p}{1 - e},
\end{cases}
\quad 0 <= p <= 1
:::

from $(0, 0, 0)$ to $(1, 1, 1)$.

:::expandable
**Solution.** [Click to Expand]

Since $\nabla cross v{F} = 0$, the line integral is independent of the path taken.

Then we can use:
 - $C_1$: straight segment from $(0, 0, 0)$ to $(1, 0, 0)$,
 - $C_2$: straight segment from $(1, 0, 0)$ to $(1, 1, 0)$,
 - $C_3$: straight segment from $(1, 1, 0)$ to $(1, 1, 1)$.

Then we have:

:::math align
int[C_1] v{F} dot unit{t} \, ds &= int[0..1] e^0 \, dx = 1
int[C_2] v{F} dot unit{t} \, ds &= int[0..1] (1 - e^{-y}) \, dy = e^{-1}
int[C_3] v{F} dot unit{t} \, ds &= int[0..1] (e^{-1} - e^{-z}) \, dz = 2 e^{-1} - 1
:::

Then, we have:

:::math
int[C] v{F} dot unit{t} \, ds =  int[C_1 + C_2 + C_3] v{F} dot unit{t} \, ds = 3 e^{-1}
:::

::::
