**Problem III-8.** In the text we obtained the $z$-component of $\nabla \times \mathbf{F}$ 
in cylindrical coordinates. Proceeding the same way, obtain the $\theta$- and $r$-components.

:::expandable
**Solution ($\theta$-component).** [Click to Expand]

Using the path shown in the figure, we'll yield the $\theta$-component of $\nabla \times \mathbf{F}$ in cylindrical coordinates.

 ![](III-8a.jpg)

Viewed from above:

 ![](III-8b.jpg)

For $C_1$, we have $\hat{\mathbf{t}} = \hat{\mathbf{e}_r}$ and $ds = dr$. Then:

$$
\begin{align*}
\int_{C_1} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{r - \Delta r / 2}^{r + \Delta r / 2} F_r(u, \theta, z - \frac{\Delta z}{2}) \\, du \\\\[1em]
&\approx F_r(r, \theta, z - \frac{\Delta z}{2}) \Delta r
\end{align*}
$$

For $C_2$, we have $\hat{\mathbf{t}} = \mathbf{\mathbf{e}_z}$ and $ds = dz$. Then:

$$
\begin{align*}
\int_{C_2} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{z - \Delta z / 2}^{z + \Delta z / 2} F_z(r + \Delta r / 2, \theta, u) \\, du \\\\[1em]
&\approx F_z(r + \frac{\Delta r}{2}, \theta, z) \Delta z
\end{align*}
$$

For $C_3$, we have $\hat{\mathbf{t}} = -\hat{\mathbf{e}_r}$ and $ds = -dr$. Then:

$$
\begin{align*}
\int_{C_3} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{r + \Delta r / 2}^{r - \Delta r / 2} (-F_r(u, \theta, z + \frac{\Delta z}{2})) \\, (-du) \\\\[1em]
&\approx -F_r(r, \theta, z + \frac{\Delta z}{2}) \Delta r
\end{align*}
$$

For $C_4$, we have $\hat{\mathbf{t}} = -\hat{\mathbf{e}_z}$ and $ds = -dz$. Then:

$$
\begin{align*}
\int_{C_4} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{z + \Delta z / 2}^{z - \Delta z / 2} (-F_z(r - \Delta r / 2, \theta, u)) \\, (-du) \\\\[1em]
&\approx -F_z(r - \frac{\Delta r}{2}, \theta, z) \Delta z
\end{align*}
$$

Then, we have:

$$
\begin{align*}
\int_{C_1 + C_2 + C_3 + C_4} \mathbf{F} &\cdot \hat{\mathbf{t}} \\, ds \approx \\\\[0.5em]
&\Delta r \left( F_r(r, \theta, z - \frac{\Delta z}{2}) - F_r(r, \theta, z + \frac{\Delta z}{2}) \right) + \\\\[0.5em]
&\Delta z \left( F_z(r + \frac{\Delta r}{2}, \theta, z) - F_z(r - \frac{\Delta r}{2}, \theta, z) \right)
\end{align*}
$$

Since $\Delta A = \Delta r \Delta z$, we have:

$$
\begin{align*}
\frac{1}{\Delta A} \int_{C_1 + C_2 + C_3 + C_4} \mathbf{F} &\cdot \hat{\mathbf{t}} \\, ds \approx \\\\[0.5em]
& \frac{F_r(r, \theta, z - \dfrac{\Delta z}{2}) - F_r(r, \theta, z + \dfrac{\Delta z}{2})}
{\Delta z} - \\\\[0.5em]
&\frac{F_z(r + \dfrac{\Delta r}{2}, \theta, z) - F_z(r - \dfrac{\Delta r}{2}, \theta, z)}{\Delta r}
\end{align*}
$$

So, $\theta$-component of $\nabla \times \mathbf{F}$ is:

$$
\lim_{\Delta A \to 0} \frac{1}{\Delta A} \int_{C_1 + C_2 + C_3 + C_4} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds =
\frac{\partial F_r}{\partial z} - \frac{\partial F_z}{\partial r}
$$

::::

:::expandable
**Solution ($r$-component).** [Click to Expand]

Using the path shown in the figure, we'll yield the $r$-component of $\nabla \times \mathbf{F}$ in cylindrical coordinates.

 ![](III-8c.jpg)

For $C_1$, we have $\hat{\mathbf{t}} = \hat{\mathbf{e}_\theta}$ and $ds = r d\theta$. Then:

$$
\begin{align*}
\int_{C_1} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{\theta - \Delta \theta / 2}^{\theta + \Delta \theta / 2} F_\theta(r, u, z - \frac{\Delta z}{2}) \\, r \\, du \\\\[1em]
&\approx F_\theta(r, \theta, z - \frac{\Delta z}{2}) r \Delta \theta
\end{align*}
$$

For $C_2$, we have $\hat{\mathbf{t}} = \hat{\mathbf{e}_z}$ and $ds = dz$. Then:

$$
\begin{align*}
\int_{C_2} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{z - \Delta z / 2}^{z + \Delta z / 2} F_z(r, \theta + \frac{\Delta \theta}{2}, u) \\, du \\\\[1em]
&\approx F_z(r, \theta + \frac{\Delta \theta}{2}, z) \Delta z
\end{align*}
$$

For $C_3$, we have $\hat{\mathbf{t}} = -\hat{\mathbf{e}_\theta}$ and $ds = -r d\theta$. Then:

$$
\begin{align*}
\int_{C_3} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{\theta + \Delta \theta / 2}^{\theta - \Delta \theta / 2} (-F_\theta(r, u, z + \frac{\Delta z}{2})) \\, (-r \\, du) \\\\[1em]
&\approx -F_\theta(r, \theta, z + \frac{\Delta z}{2}) r \Delta \theta
\end{align*}
$$

For $C_4$, we have $\hat{\mathbf{t}} = -\hat{\mathbf{e}_z}$ and $ds = -dz$. Then:

$$
\begin{align*}
\int_{C_4} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_{z + \Delta z / 2}^{z - \Delta z / 2} (-F_z(r, \theta - \frac{\Delta \theta}{2}, u)) \\, (-du) \\\\[1em]
&\approx -F_z(r, \theta - \frac{\Delta \theta}{2}, z) \Delta z
\end{align*}
$$

Then, we have:

$$
\begin{align*}
\int_{C_1 + C_2 + C_3 + C_4} \mathbf{F} &\cdot \hat{\mathbf{t}} \\, ds \approx \\\\[0.5em]
&r \\, \Delta \theta \left( F_\theta(r, \theta, z - \frac{\Delta z}{2}) - F_\theta(r, \theta, z + \frac{\Delta z}{2}) \right) + \\\\[0.5em]
&\Delta z \left( F_z(r, \theta + \frac{\Delta \theta}{2}, z) - F_z(r, \theta - \frac{\Delta \theta}{2}, z) \right)
\end{align*}
$$

Since $\Delta A = r \Delta \theta \Delta z$, we have:

$$
\begin{align*}
\frac{1}{\Delta A} \int_{C_1 + C_2 + C_3 + C_4} \mathbf{F} &\cdot \hat{\mathbf{t}} \\, ds \approx \\\\[0.5em]
& \frac{F_z(r, \theta + \dfrac{\Delta \theta}{2}, z) - F_z(r, \theta - \dfrac{\Delta \theta}{2}, z)}
{r \\, \Delta \theta} - \\\\[0.5em]
&\frac{F_\theta(r, \theta, z + \dfrac{\Delta z}{2}) - F_\theta(r, \theta, z - \dfrac{\Delta z}{2})}{\Delta z}
\end{align*}
$$

So, $r$-component of $\nabla \times \mathbf{F}$ is:

$$
\lim_{\Delta A \to 0} \frac{1}{\Delta A} \int_{C_1 + C_2 + C_3 + C_4} \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds =
\frac{1}{r} \\, \frac{\partial F_z}{\partial \theta} - \frac{\partial F_{\theta}}{\partial z}
$$

::::
