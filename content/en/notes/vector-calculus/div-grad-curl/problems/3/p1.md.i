**Problem III-1.**
Use an argument like the one given in the text for the Coloumb force to
show that $\int_C \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds = 0$ is independent
of path for any central force $\mathbf{F}$.

:::expandable
**Solution.** [Click to Expand]

If $\mathbf{F}$ is a central force, then for any point $P$ in space, the force is in
the radial direction and its magnitude depends only on the distance $r$ from the origin:

$$
\mathbf{F} = F_r(r) \hat{\mathbf{e}}_r
$$

Then we have:

$$
\begin{align*}
F_x &= F_r(r) \sin \phi \cos \theta \\\\
F_y &= F_r(r) \sin \phi \sin \theta \\\\
F_z &= F_r(r) \cos \phi
\end{align*}
$$

and since:

$$
\begin{align*}
x &= r \sin \phi \cos \theta \\\\
y &= r \sin \phi \sin \theta \\\\
z &= r \cos \phi
\end{align*}
$$

We have:

$$
\begin{align*}
dx &= \sin \phi \cos \theta \\, dr + r \cos \phi \cos \theta \\, d\phi - r \sin \phi \sin \theta \\, d\theta \\\\
dy &= \sin \phi \sin \theta \\, dr + r \cos \phi \sin \theta \\, d\phi + r \sin \phi \cos \theta \\, d\theta \\\\
dz &= \cos \phi \\, dr - r \sin \phi \\, d\phi
\end{align*}
$$

Then:

$$
\begin{align*}
F_x \\, dx &+ F_y \\, dy + F_z \\, dz = \\\\
& F_r(r) (\sin^2 \phi \cos^2 \theta + \sin^2 \phi \sin^2 \theta + \cos^2 \phi) \\, dr + \\\\
& F_r(r) (r \sin \phi \cos \phi \cos^2 \theta + r \sin \phi \cos \phi \sin^2 \theta - r \sin \phi \cos \phi) \\, d\phi + \\\\
& F_r(r) (-r \sin^2 \phi \sin \theta \cos \theta + r \sin^2 \phi \sin \theta \cos \theta) \\, d\theta
\end{align*}
$$

Which simplifies to:

$$
F_x \\, dx + F_y \\, dy + F_z \\, dz = F_r(r) \\, dr
$$

On page 68 we saw that:

$$
\int_C \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds = \int_C (F_x \\, dx + F_y \\, dy + F_z \\, dz) 
$$

Thus, we have:

$$
\begin{align*}
\int_C \mathbf{F} \cdot \hat{\mathbf{t}} \\, ds &= \int_C F_r(r) \\, dr \\\\
 &= \int_{r_1}^{r_2} F_r(r) \\, dr
\end{align*}
$$

which is independent of the path taken and depends only on the initial and final radius.

::::
