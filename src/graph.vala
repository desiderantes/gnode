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

		public signal void state_changed();

		public bool is_connected(){
			if( nodes.size != 0){Node first = nodes.get(0);
				var traversed = new Gee.ArrayList<Node>();
				traversed.add(first);
				return traverse_nodes(first, traversed);}
			else{ return false;}
		}

		public void add_node(Node node){
			if(!nodes.contains(node)){
				nodes.add(node);
				state_changed();
			}
		}

		public void self_loop(Node node, Link edge){

		}

		private bool traverse_nodes(Node first, Gee.ArrayList<Node> visited){
			return false;
		}

		public void remove_link(Link edge){
			edges.remove(edge);
			state_changed();
		}


		public Gee.ArrayList<Link> shortest_path(Node src, Node dst){

			var previous = new new HashMap<Node, Node?>();
			var path = new Gee.ArrayList<Link>();
			var distance = new HashMap<Node, double>();
			var stack = new Gee.PriorityQueue<Node>((a,b)=>{ 
				if(a.degree() > b.degree()){ 
					return 1;
				}else if(a.degree() < b.degree()){ 
					return -1;
				} else{ 
					return 0;
				}
			});

			
			distance.set(src, 0);
			stack.add(src);
			while (stack.size() != 0){
				Node u = stack.poll();
				for (Link edge in u.edges){
					
				}
			}
			state_changed();
			return path;

		}

		private void chill(){

		}

		public void remove_edge(Link edge){
			edges.remove(edge);
			state_changed();
		}

		public void add_edge(Link edge){
			edges.add(edge);
			state_changed();
		}


		public void draw(Cairo.Context ctx){
			if (ctx == null)
				return;
			ctx.set_source_rgba(1, 1, 1, 1);
			/* blank screen */
			ctx.paint();

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
			state_changed();
		}


	}
}