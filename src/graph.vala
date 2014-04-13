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

		/*
		 * Returns the minimal spanning tree, if the graph is connected
		 * if not, returns the minimal spanning forest
		 */
		public Gee.ArrayList<Link> spanning_tree(Node src, Node dst){

			var path = new Gee.ArrayList<Link>();
			var sorteds = new Gee.ArrayQueue<Link>();
			sorteds.add_all(edges);
			sorteds.sort((a,b)=>{ 
				if(a.weight > b.weight()){ 
					return -1;
				}else if(a.weight) < b.weight){ 
					return 1;
				} else{ 
					return 0;
				}
			});
			Link e = sorteds.peek();
			while (!sorteds.is_empty()){
				e = sorteds.poll();
				Node start = e.src;
        		Node end = e.dst;
        		bool delete_ok = false;
				var checked = new Gee.ArrayList<Node>();
				var queue = new Gee.LinkedList<Node>();
				checked.add(start);
				queue.offer(start);
				while(!queue.is_empty()){
					Node tmp = queue.poll();
					if (tmp == end){
						delete_ok = true;
						break;
					}

					var edge_list = tmp.edges;
					foreach (Link link in edges){
						if(link != e){
							if(!checked.contains(link.dst){
								queue.offer(link.dst);
								checked.add(link.dst);
							}
						}
					}
				}

				if(!delete_ok){
					sorteds.offer(e);
				}
			}
			
			
			state_changed();
			path.add_all(sorteds);
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
			ctx.paint();
			
			foreach (GNode.Link edge in edges){
				edge.draw(ctx);
			}
			foreach (GNode.Node node in nodes){
				node.draw(ctx);
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