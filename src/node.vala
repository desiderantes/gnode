namespace GNode{
	public class Node : GLib.Object{
		
		public string label { get; private set;}
		private Graph graph;
		public double x{ get; private set;}
		public double y{ get; private set;}
		private uint radius = 1;
		public Gee.ArrayList<Link> edges { get; private owned set;}
		public uint degree{ get{
			return edges.size;
		}}
		
		public Node (string label, Graph parent, double x, double y){
			this.label = label;
			this.graph = parent;
			this.edges = new Gee.ArrayList<Link>();
			this.x = x;
			this.y = y;
			
		}
		
		public void connect_from (Node source, Link edge ){
			edges.add(edge);
			if(source == this){
				graph.self_loop(this, edge);
			}
		}
		
		public void connect_to (Node dest, double weigth){
			Link edge = new Link(this, dest, weigth, graph);
			edges.add(edge);
			graph.add_edge(edge);
			
		}
		
		public void siege (Node next){
			foreach (Link edge in edges){
				if(edge.get_pair(this) == next){
					this.unlink(edge);
					next.unlink(edge);
				}
			}
		}
		
		public void draw(Cairo.Context ctx){
			ctx.set_source_rgba (0,0,0,0);
			ctx.set_line_width (3.0);
			ctx_move_to(x, y);
			ctx.arc (x, y, 5.0, 0, 2*Math.PI);
			ctx.stroke_preserve();
			ctx.fill ();
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