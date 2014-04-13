namespace GNode{
	public class Node : GLib.Object{
		
		public string label { get; private set;}
		private Graph graph;
		public bool selected;
		public double x{ get; private set;}
		public double y{ get; private set;}
		private uint radius = 1;
		public Gee.ArrayList<Link> edges { get; private set;}
		public uint degree{ get{
			return edges.size;
		}}
		
		public Node (string label, Graph parent, double x, double y){
			this.label = label;
			this.graph = parent;
			this.edges = new Gee.ArrayList<Link>();
			this.x = x;
			this.y = y;
			this.selected = false;
			
		}

		public Gee.ArrayList<Node> get_adjacency_list() {
			var adjacency = new Gee.ArrayList<Node>();
			foreach (Link edge in edges){
				adjacency.add(edge.get_pair(this));
			}
			return adjacency;
		}
		
		public void connect_from (Node source, Link edge ){
			edges.add(edge);
			if(source == this){
				graph.self_loop(this, edge);
			}
		}
		
		public void connect_to (Node dest, double weigth){
			GNode.Link edge = new GNode.Link(this, dest, weigth, graph);
			edges.add(edge);
			graph.add_edge(edge);
			
		}
		
		public void siege (Node next){
			foreach (GNode.Link edge in edges){
				if(edge.get_pair(this) == next){
					this.unlink(edge);
					next.unlink(edge);
				}
			}
		}
		
		public void draw(Cairo.Context ctx){
			ctx.save ();

			ctx.set_tolerance (0.1);
			ctx.set_line_join (Cairo.LineJoin.ROUND);
			ctx.set_line_width (9);
			if(selected){
				ctx.set_source_rgba(0.0, 0.0, 0.8, 0.6);
			}else{
				ctx.set_source_rgba(0.3, 0.9, 0.9, 1);
			}

			ctx.move_to(x, y);
			ctx.arc (x, y, 7, 0, 2*Math.PI);
			ctx.fill_preserve();
			ctx.stroke();
			ctx.close_path ();
			ctx.restore();
			
		}

		public bool clicked(Gdk.Point click){
			double dist = Math.sqrt(Math.pow((click.x - x),2) + Math.pow((click.y - y),2));
			return  dist< radius;
		}
		
		public void unlink(Link edge){
			edge.unlink(this);
			edges.remove(edge);
		}
		

	}
}