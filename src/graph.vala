namespace GNode{
	public class Graph : GLib.Object{

		public string title{ get; private set;}
		public Gee.ArrayList<Node> nodes{ public get; private set;}
		public Gee.ArrayList<Link> edges{ public get; private set;}
		public Graph(string? title){
			if(title == null){
				this.title = "";
			} else this.title = title;
			this.nodes = new Gee.ArrayList<Node>();
			this.edges = new Gee.ArrayList<Link>();

		}

		public signal void state_changed();

		public bool is_connected(){
			if( nodes.size != 0){
				Node first = nodes.get(0);
				var checked = new Gee.HashSet<Node>();
				traverse(first,checked);
				return checked.contains_all(nodes);			}
			else{ return false;}
		}

		private void traverse(Node node, Gee.HashSet<Node> checked){
			if(!checked.contains(node)){
				checked.add(node);
				foreach(Node adj in node.get_adjacency_list()){
					traverse(adj,checked);
				}
			}

		}

		public bool is_planar(){
			if(edges.size <= (3* nodes.size - 6)){
				return true;
			}	
			if(nodes.size == 2 && is_connected ()){
				return true;
			}

			return false;
		}
		
		public void add_node(Node node){
			if(!nodes.contains(node)){
				nodes.add(node);
				state_changed();
			}
		}

		public void self_loop(Node node, Link edge){

		}


		/*
		 * Returns the minimal spanning tree, if the graph is connected
		 * if not, returns the minimal spanning forest
		 */
		public Gee.ArrayList<Link> spanning_tree(){
			return kruskal();
		}

		public Gee.ArrayList<Node> container_set(Node node, Gee.ArrayList<Gee.ArrayList<Node>> sets) {
			foreach (Gee.ArrayList<Node> arr in sets) {
				if (arr.contains(node)) {
					return arr;
				}
			}
			return new Gee.ArrayList<Node>();
		}


		public Gee.ArrayList<Link> kruskal(){

			var path = new Gee.ArrayList<Link>();
			var sorteds = new Gee.ArrayList<Link>();
			var sets = new Gee.ArrayList<Gee.ArrayList<Node>>();
			sorteds.add_all(edges);
			stdout.printf("Sort added\n");
			sorteds.sort((a,b)=>{ 
				if(a.weight > b.weight){ 
					return 1;
				}else if(a.weight < b.weight){ 
					return -1;
				} else{ 
					return 0;
				}
			});


			foreach (Node nod in nodes) {
				var to_add = new Gee.ArrayList<Node>();
				to_add.add(nod);
				sets.add(to_add);
			}
			foreach (Link e in sorteds) {
				Gee.ArrayList<Node> a = container_set(e.src, sets);
				Gee.ArrayList<Node> b = container_set(e.dst, sets);
				if (a != b) {
					path.add(e);
					a.add_all(b);
					sets.remove(b);
				}
			}
			state_changed();
			return path;
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


			foreach (GNode.Link edge in edges){
				edge.draw(ctx);
			}
			foreach (GNode.Node node in nodes){
				node.draw(ctx);
			}

		}

		public uint similar_edges(Link edge){
			uint res = 0;
			foreach (Link e in edges){
				if(edge != e){
					if(e.contains(edge.src) && e.contains(edge.dst)){
						res++;
					}
				}
			}
			return res;
		}

		public void remove_node(Node node){
			foreach (Node e in nodes){
				e.siege(node);
			}

			nodes.remove(node);
			state_changed();
		}


	}
}