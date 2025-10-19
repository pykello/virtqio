# Special Topcic: Lorentz Transformation

Layout of the physical world can be described in two equivalent ways:
- Using events and intervals between them.
- Or isolated events described by their spacetime coordinates (latticework of recording clocks).

**Lorentz transformation** translates event description from lattice of one inertial
frame to that of another inertial frame.

### L.2 Faster than light?

If I fly at 4/5 the speed of light and fire a bullet that observe to fly forward at
4/5 the speed of light, isn't the bullet flying at 8/5 the speed of light relative
to the observer on the ground?

No. Velocities don't simply add. The speed the observer will measure will be 40/41
the speed of light.

How did we get this result? Using **Lorentz transformation**.

Space and time separations between two events typically don't have the same values in
different inertial frames.

Here the events are:
- Event 1: bullet is fired
- Event 2: bullet strikes a target ahead

Using the invariance of the spacetime interval, we can calculate the separations in
the frame of a passenger on the bullet. But to get the separations in the frame of
the observer on the ground, we need **Lorentz coordinate transformation equations**.

### L.3 First Steps

**Goal.** Find $t$ and $x$ given $t'$, when $x' = 0$.

Assume we have a rocket moving at speed $v_\text{rel}$ relative to the observer in the lab.
Take the spatial origins of the two frames to coincide at time $0$.

Let a spark occur at the origin of the rocket frame ($x' = 0$) at time $t$ of the lab frame.

Since the rocket is moving at speed $v_\text{rel}$ relative to the lab frame,
the spark will occur at position $x = v_\text{rel} t$.

Now, using the invariance of the spacetime interval, we can calculate $t'$,

$$
t' = t \left( 1 - v_\text{rel}^2 \right)^{1/2}
$$

Or

$$
t = \frac{t'}{\left( 1 - v_\text{rel}^2 \right)^{1/2}}
$$

We define the **time stretch factor** as

$$
\gamma = \frac{1}{\left( 1 - v_\text{rel}^2 \right)^{1/2}}
$$

So we have $t = \gamma t'$ (when $x' = 0$).

Then, we have $x = v_\text{rel} \gamma t'$ (when $x' = 0$).

### L.4 Form of the Lorentz Transformation

In this section the book argues that the general form of the transformation must be linear.

That is, the general form should be:

$$
t = B x' + D t' \\\
x = G x' + H t'
$$

Why? since we are free to choose any event as the reference event. See the book for more details.

### L.5 Completing the Derivation

[TODO]

