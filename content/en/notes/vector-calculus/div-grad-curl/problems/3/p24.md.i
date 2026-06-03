**Problem III-24.** **(a)** There is an important theorem in vector calculus that says $\nabla dot v{G} = 0$ if and only if $v{G} = \nabla cross v{H}$.
To prove this we note first of all that $v{G} = \nabla cross v{H}$ implies $\nabla dot v{G} = 0$ (see problem III-7).

To show that $\nabla dot v{G} = 0$ implies $v{G} = \nabla cross v{H}$,
the simplest procedure is to give $v{H}$:

:::math align
H_x &= 0
H_y &= int[x_0..x] G_z(x', y, z) \, dx'
H_z &= - int[x_0..x] G_y(x', y, z) \, dx' + int[y_0..y] G_x(x_0, y', z) \, dy'
:::

where $x_0$ and $y_0$ are arbitrary constants. Show by direct calculation that if $\nabla dot v{G} = 0$, then $v{G} = \nabla cross v{H}$.

:::expandable
**Solution.** [Click to Expand]

Since $\nabla dot v{G} = 0$, then:

:::math
pd(G_x, x) = - pd(G_y, y) - pd(G_z, z) #tag 1
:::

We have:

:::math align
\nabla cross v{H} &= v{i} ( pd(H_z, y) - pd(H_y, z) ) + v{j} ( pd(H_x, z) - pd(H_z, x) ) + v{k} ( pd(H_y, x) - pd(H_x, y) )
&= v{i} ( pd(H_z, y) - pd(H_y, z) ) + v{j} ( 0 - pd(H_z, x) ) + v{k} ( pd(H_y, x) - 0 )
:::

We have:

:::math align
pd(H_y, x) &= G_z(x, y, z)
pd(H_y, z) &= int[x_0..x] pd(G_z(x', y, z), z) \, dx'
pd(H_z, x) &= - G_y(x, y, z)
pd(H_z, y) &= - int[x_0..x] pd(G_y(x', y, z), y) \, dx' + G_x(x_0, y, z)
:::

As a direct consequence, we have:

:::math align
(\nabla cross v{H})_y &= G_y(x, y, z)
(\nabla cross v{H})_z &= G_z(x, y, z)
:::

To calculate $(\nabla cross v{H})_x$, we have:

:::math
(\nabla cross v{H})_x = int[x_0..x] ( - pd(G_y(x', y, z), y) - pd(G_z(x', y, z), z) ) \, dx' + G_x(x_0, y, z)
:::

Using (1), we have:

:::math
(\nabla cross v{H})_x = int[x_0..x] pd(G_x(x', y, z), x) \, dx' + G_x(x_0, y, z)
:::

Then using the fundamental theorem of calculus, we have:

:::math
(\nabla cross v{H})_x = G_x(x, y, z) - G_x(x_0, y, z) + G_x(x_0, y, z) = G_x(x, y, z)
:::

::::

**(b)** Is the vector function $v{H}$ specified in part (a) unique? That is, can we
alter it in any way without invalidating the relation $v{G} = \nabla cross v{H}$?

:::expandable
**Solution.** [Click to Expand]

No, the vector function $v{H}$ is not unique. For example, adding constants to the components of $v{H}$ does not change the value of $\nabla cross v{H}$.
::::
