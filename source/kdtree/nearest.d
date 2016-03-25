
module kdtree.nearest;

import kdtree.node;
import kdtree.point;

KDPoint!(k, T) *nearest(size_t k, T)(KDNode!(k, T) *root, KDPoint!(k, T) neighbour) if(k > 0)
{
    KDPoint!(k, T) *nearest = null;
    double nearestDistance = double.max;

    void nearestImpl(KDNode!(k, T) *current, KDPoint!(k, T) point, size_t depth = 0)
    {
        if(current !is null)
        {
            auto axis = depth % k;

            double distance = current.point.distanceSq(point);
            double distanceAxis = (current.point[axis] - point[axis]) ^^ 2;

            if(nearest is null || distance < nearestDistance)
            {
                nearestDistance = distance;
                nearest = &current.point;
            }

            if(nearestDistance > 0)
            {
                auto next = distanceAxis > 0 ? current.left : current.right;
                nearestImpl(next, point, depth + 1);

                if(distanceAxis <= nearestDistance)
                {
                    next = distanceAxis > 0 ? current.right : current.left;
                    nearestImpl(next, point, depth + 1);
                }
            }
        }
    }

    return nearestImpl(root, neighbour), nearest;
}
