namespace GNode{
	public class Graph : GLib.Object{

		public string title{ get; private set;}
		private Gee.ArrayList<Node> nodes{ public get; private set;}
		private Gee.ArrayList<Link> edges{ public get; private set;}
		public Graph(string? title){
			if(title == null){
				this.title = "";
			}
			this.nodes = new Gee.ArrayList<Node>();
			this.edges = new Gee.ArrayList<Link>();
			
		}
		
		public bool is_connected(){
			Node first = nodes.get(0);
			var traversed = new Gee.ArrayList<Node>();
			traversed.add(first);
			return traverse_nodes(first, traversed);
		}
		
		public void add_node(Node node){
			if(!nodes.contains(node)){
				nodes.add(node);
			}
		}
		
		public void self_loop(Node node, Link edge){
		
		}
		
		private bool traverse_nodes(Node first, Gee.ArrayList<Node> visited){
			return false;
		}
		
		public void remove_link(Link edge){
			edges.remove(edge);
		}
		
		
		public Gee.ArrayList<Link> shortest_path(Node src, Node dst){
			return new Gee.ArrayList<Link>();
		}
		
		public void remove_edge(Link edge){
			edges.remove(edge);
		}
		
		public void add_edge(Link edge){
			edges.add(edge);
		}
		
		
		public void draw(Cairo.Context ctx){
			foreach (GNode.Node node in nodes){
				node.draw(ctx);
			}
			foreach (GNode.Link edge in edges){
				edge.draw(ctx);
			}

			ctx.paint ();
			           

		}
		
		public void remove_node(Node node){
			foreach (Link e in node.edges){
				e.get_pair(node).unlink(e);
				node.unlink(e);
			}

			nodes.remove(node);			
		}
	
	
	}
}