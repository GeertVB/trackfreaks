package
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class NearestNeighbor
	{
		
		private var _a: Array = new Array();
		private var _d: Number = Number.MAX_VALUE;
		
		public static function find(qt: QuadTree, p: Point) : Point {
			return new NearestNeighbor().findNearestNeighbor(qt, p);
		}

		public function findNearestNeighbor(qt: QuadTree, p: Point) : Point {
			var result: Point = null;
			
			this.addPotentialCandidate(qt, p);

			while (hasCandidates()) {
				var qt: QuadTree = popNearestCandidate();
				if (qt.isLeaf()) {
					for each(var pt: Point in qt._points) {
						var ptd: Number = Point.distance(p, pt);
						if (ptd < _d) {
							_d = ptd;
							result = pt;
							removeRedundantCandidates();
						}
					}
				} else {
					addPotentialCandidate(qt._neQuadTree, p);
					addPotentialCandidate(qt._seQuadTree, p);
					addPotentialCandidate(qt._nwQuadTree, p);
					addPotentialCandidate(qt._swQuadTree, p);
				}
			}
			
			return result;
		}
		
		public function addPotentialCandidate(qt: QuadTree, p: Point) : void {
			if (qt != null && !qt.isEmpty()) {
				var d: Number = Util2D.distanceFromPointToRectangle(p, qt._bounds);
				if (d < _d) {
					addCandidate(d, qt);
				}
			}
		}
		
		public function removeRedundantCandidates() : void {
			while (_a.length > 0 && _a[0].d > _d) {
				_a.shift();
			}
		}
		
		public function hasCandidates() : Boolean {
			return _a.length > 0;
		}
		
		public function addCandidate(d: Number, qt: QuadTree) : void {
			var a: Array = new Array();
			while (_a.length > 0 && _a[0].d >= d) {
				a.push(_a.shift());
			}
			a.push({d: d, qt: qt});
			while (_a.length > 0) {
				a.push(_a.shift());
			}
			_a = a;
		}
		
		public function popNearestCandidate() : QuadTree {
			return _a.pop().qt;
		}
		

	}
}