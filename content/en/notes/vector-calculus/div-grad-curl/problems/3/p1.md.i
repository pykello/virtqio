**Problem III-1.**
Use an argument like the one given in the text for the Coulomb force to
show that $int[C] v{F} dot unit{t} \, ds = 0$ is independent
of path for any central force $v{F}$.

:::expandable
**Solution.** [Click to Expand]

If $v{F}$ is a central force, then for any point $P$ in space, the force is in
the radial direction and its magnitude depends only on the distance $r$ from the origin:

:::math
v{F} = F_r(r) unit{e}_r
:::

Then we have:

:::math align
F_x &= F_r(r) \sin phi \cos theta
F_y &= F_r(r) \sin phi \sin theta
F_z &= F_r(r) \cos phi
:::

and since:

:::math align
x &= r \sin phi \cos theta
y &= r \sin phi \sin theta
z &= r \cos phi
:::

We have:

:::math align
dx &= \sin phi \cos theta \, dr + r \cos phi \cos theta \, dphi - r \sin phi \sin theta \, dtheta
dy &= \sin phi \sin theta \, dr + r \cos phi \sin theta \, dphi + r \sin phi \cos theta \, dtheta
dz &= \cos phi \, dr - r \sin phi \, dphi
:::

Then:

:::math align
F_x \, dx &+ F_y \, dy + F_z \, dz =
& F_r(r) (\sin^2 phi \cos^2 theta + \sin^2 phi \sin^2 theta + \cos^2 phi) \, dr +
& F_r(r) (r \sin phi \cos phi \cos^2 theta + r \sin phi \cos phi \sin^2 theta - r \sin phi \cos phi) \, dphi +
& F_r(r) (-r \sin^2 phi \sin theta \cos theta + r \sin^2 phi \sin theta \cos theta) \, dtheta
:::

Which simplifies to:

:::math
F_x \, dx + F_y \, dy + F_z \, dz = F_r(r) \, dr
:::

On page 68 we saw that:

:::math
int[C] v{F} dot unit{t} \, ds = int[C] (F_x \, dx + F_y \, dy + F_z \, dz)
:::

Thus, we have:

:::math align
int[C] v{F} dot unit{t} \, ds &= int[C] F_r(r) \, dr
&= int[r_1..r_2] F_r(r) \, dr
:::

which is independent of the path taken and depends only on the initial and final radius.

::::
