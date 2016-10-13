namespace GNode {
	public class AuxNode : Object {
		public Link original;
		public double x;
		public double y;
		public string name { 
			get {
				return ("%s-%s".printf (original.src.label,original.dst.label)).to_string() ;
			}
		}
		public 	Status selected;
		private double radius = 21;
		public Gee.ArrayList<AuxLink> adjacency_list;
		public AuxNode (GNode.Link edge) {
			this.original = edge;
			x = 0;
			y = 0;
			this.selected = Status.NONE;
			adjacency_list = new Gee.ArrayList<AuxLink> ();
		}
		public void draw (Cairo.Context ctx) {
			ctx.save ();
			ctx.set_line_width (3);
			if (selected == Status.BLUE) {
				ctx.set_source_rgba (0.0, 0.24, 0.93, 1);
			} else {
				ctx.set_source_rgba (0.0, 0.85, 0.1, 1);
			}
			ctx.move_to (x, y);
			ctx.arc (x, y, radius, 0, 2*Math.PI);
			ctx.fill_preserve ();
			ctx.stroke ();
			ctx.close_path ();
			ctx.restore ();
			
		}
	}

	public enum Status {
		BLUE,
		GREEN,
		NONE
	}
	
	public class AuxLink: Object {
		public AuxNode src;
		public AuxNode dst;

		public AuxLink (AuxNode src, AuxNode dst) {
			this.src = src;
			this.dst = dst;
			src.adjacency_list.add (this);
			dst.adjacency_list.add (this);
		}

		public AuxNode? get_pair (AuxNode node) {
			if (node == src) {
				return dst;
			} else if (node == dst) {
				return src; 
			}
			return null;
		}

		public void draw (Cairo.Context ctx){
			ctx.set_source_rgba (0.0, 0.0, 0.8, 0.6);
			ctx.set_line_width (6.0);
			ctx.move_to (src.x, src.y);
			uint howmuch = 2;
			if (howmuch % 2 == 0){
				ctx.curve_to (src.x,src.y,  dst.x + (howmuch * 20),  src.y  + (howmuch * 20) , dst.x, dst.y);
			} else {
				ctx.curve_to (src.x,src.y,  src.x  + (howmuch * 20),  dst.y + (howmuch * 20), src.x, src.y);
			}
			ctx.stroke ();
		}
	}
	
	public class AuxGraph : Object {
		public Gee.ArrayList<AuxLink> edges{ public get; private set;}
		public Gee.ArrayList<AuxNode> nodes{ public get; private set;}

		public AuxGraph (){
			edges = new Gee.ArrayList<AuxLink> ();
			nodes = new Gee.ArrayList<AuxNode> ();
		}

		public AuxNode? get_aux_node (Link edge) {
			foreach (AuxNode node in nodes) {
				if (node.original == edge) {
					return node;
				}
			}
			return null;
		}

		public void draw (Cairo.Context ctx) {
				if (ctx == null) {
					return;
				}
				ctx.set_source_rgba (1, 1, 1, 1);
				/* blank screen */
				foreach (AuxLink edge in edges) {
					edge.draw (ctx);
				}
				foreach (AuxNode node in nodes) {
					node.draw (ctx);
				}
			}

		
		public bool is_biconnected () {
			AuxNode first = nodes.get (0);
			first.selected = Status.GREEN;
			mark (first);
			if (check (first)) {
				double y1 = 20.0;
				double y2 = 20.0;
				double x1 = 183.0;
				double x2 = 366.0;
				foreach (AuxNode node in nodes) {
					if (node.selected == Status.GREEN) {
						node.x = x1;
						node.y = y1;
						y1+= 60;
					} else if(node.selected == Status.BLUE) {
						node.x = x2;
						node.y = y2;
						y2+= 60;
					}
				}
				return true;
			} else {
				return false;
			}
		}
		private void mark (AuxNode node) {
			foreach (AuxLink edge in node.adjacency_list) {
				AuxNode pair = edge.get_pair(node);
				if (pair.selected == Status.NONE) {
					if (node.selected == Status.GREEN) {
						pair.selected = Status.BLUE;
					} else if (node.selected == Status.BLUE) {
						pair.selected = Status.GREEN;
					}
				}
				mark (pair);
			}
		}

		private bool check (AuxNode node) {
			foreach (AuxLink edge in node.adjacency_list) {
				AuxNode pair = edge.get_pair (node);
				if (node.selected == Status.GREEN) {
					if (pair.selected == Status.GREEN) {
						return false;
					}
				} else if (node.selected == Status.BLUE) {
					if (pair.selected == Status.BLUE) {
						return false;
					}
				}
				check (pair);
			}
			return true;
		}		
	}
}
