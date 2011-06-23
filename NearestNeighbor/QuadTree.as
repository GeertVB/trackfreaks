package
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class QuadTree
	{
		
		private static var maxLevel: int = 8;
		private static var maxPoints: int = 32;
		
		private var _level: int;
		public var _neQuadTree: QuadTree;
		public var _seQuadTree: QuadTree;
		public var _nwQuadTree: QuadTree;
		public var _swQuadTree: QuadTree;
		public var _bounds: Rectangle;
		public var _points: Vector.<Point>;
		
		public function isEmpty() : Boolean {
			return _points != null && _points.length == 0;
		}
		
		public function isLeaf() : Boolean {
			return _points != null;
		}
		
		public function QuadTree(bounds: Rectangle, points: Vector.<Point>, level: int = 0) {
			_bounds = bounds;
			_level = level;
			
			if (level >= maxLevel || points.length <= maxPoints) {
				_points = points;
			} else {
				var midX: Number = _bounds.left + _bounds.width / 2;
				var midY: Number = _bounds.top + _bounds.height / 2;
				
				var neBounds: Rectangle = new Rectangle(midX, _bounds.top, _bounds.width / 2, _bounds.height / 2);
				var seBounds: Rectangle = new Rectangle(midX, midY, _bounds.width / 2, _bounds.height / 2);
				var nwBounds: Rectangle = new Rectangle(_bounds.left, _bounds.top, _bounds.width / 2, _bounds.height / 2);
				var swBounds: Rectangle = new Rectangle(_bounds.left, midY, _bounds.width / 2, _bounds.height / 2);

				var nePoints: Vector.<Point> = new Vector.<Point>();
				var sePoints: Vector.<Point> = new Vector.<Point>();
				var nwPoints: Vector.<Point> = new Vector.<Point>();
				var swPoints: Vector.<Point> = new Vector.<Point>();
				
				for each (var point: Point in points) {
					if (point.x <= midX) {
						if (point.y <= midY) {
							nwPoints.push(point);
						} else {
							swPoints.push(point);
						}
					} else {
						if (point.y <= midY) {
							nePoints.push(point);
						} else {
							sePoints.push(point);
						}
					}
				}
				
				_neQuadTree = new QuadTree(neBounds, nePoints, level + 1);
				_seQuadTree = new QuadTree(seBounds, sePoints, level + 1);
				_nwQuadTree = new QuadTree(nwBounds, nwPoints, level + 1);
				_swQuadTree = new QuadTree(swBounds, swPoints, level + 1);
			}
		}
		
	}
}