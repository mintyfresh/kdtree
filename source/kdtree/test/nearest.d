
module kdtree.test.nearest;

import kdtree;

unittest
{
    KDPoint!(2, int) result;
    KDNode!(2, int) *root = KDNode!(2, int).build([0, 0], [1, 1], [1, 0], [0, 1]);

    result = *root.nearest([0, 0].kdPoint);
    assert(result == [0, 0].kdPoint);

    result = *root.nearest([1, 1].kdPoint);
    assert(result == [1, 1].kdPoint);

    result = *root.nearest([-3, 5].kdPoint);
    assert(result == [0, 1].kdPoint);

    result = *root.nearest([25, -4].kdPoint);
    assert(result == [1, 0].kdPoint);
}
