# kdtree
A k-dimensional tree implementation for D.

## Example Code

```d
import kdtree;

void main()
{
    // Construct a 2-Dimensional tree of integers.
    auto tree = KDNode!(2, int).build([0, 0], [0, 1], [1, 0], [1, 1]);

    // Find the node closest to (-3, 5).
    auto near = tree.nearest([-3, 5].kdPoint);
    assert(near == [0, 1].kdPoint);
}
```

## Caveats

kdtree is currently not intended for altering constructed trees. It's limited to constructing trees from a series of data points and performing nearest-neighbour lookups.

## License

MIT
