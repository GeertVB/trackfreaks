package
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Util2D
	{
		public function Util2D()
		{
		}
		
		public static function distanceFromPointToRectangle(_p: Point, r: Rectangle) : Number {
			if (_p.x < r.left) {
				if (_p.y < r.top) {
					return Point.distance(_p, r.topLeft);
				} else if (_p.y > r.bottom) {
					return Point.distance(_p, new Point(r.left, r.bottom));
				} else {
					return r.left - _p.x;
				}
			} else if (_p.x > r.right) {
				if (_p.y < r.top) {
					return Point.distance(_p, new Point(r.right, r.top));
				} else if (_p.y > r.bottom) {
					return Point.distance(_p, r.bottomRight);
				} else {
					return _p.x - r.right;
				}
			} else {
				if (_p.y < r.top) {
					return r.top - _p.y;
				} else if (_p.y > r.bottom) {
					return r.bottom - _p.y;
				} else {
					return 0;
				}
			}
		}
		
		

		

	}
}