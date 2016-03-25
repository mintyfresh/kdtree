
module kdtree.node;

import kdtree.point;

struct KDNode(size_t k, T) if(k > 0)
{
    KDPoint!(k, T) point;

    KDNode!(k, T) *left  = null;
    KDNode!(k, T) *right = null;

    this(KDPoint!(k, T) point)
    {
        this.point = point;
    }

    static KDNode!(k, T) *build(T[k][] points...)
    {
        return build(KDPoint!(k, T).build(points));
    }

    static KDNode!(k, T) *build(KDPoint!(k, T)[] points, size_t depth = 0)
    {
        if(points.length > 1)
        {
            auto axis = depth % k;

            auto sorted = points.sortedOn(axis);
            auto median = sorted[$ / 2];

            auto node = new KDNode!(k, T)(median);

            if(sorted.length / 2 > 0)
            {
                node.left = build(sorted[0 .. $ / 2], depth + 1);
            }
            if(sorted.length / 2 + 1 < sorted.length)
            {
                node.right = build(sorted[$ / 2 + 1 .. $], depth + 1);
            }

            return node;
        }
        else if(points.length == 1)
        {
            return new KDNode!(k, T)(points[0]);
        }
        else
        {
            return null;
        }
    }

    @property
    bool leaf() const
    {
        return left is null && right is null;
    }
}
