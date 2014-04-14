namespace GNode{
	public class Graph : GLib.Object{

		public string title{ get; private set;}
		public Gee.ArrayList<Node> nodes{ public get; private set;}
		public Gee.ArrayList<Link> edges{ public get; private set;}
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


		/*
		 * Returns the minimal spanning tree, if the graph is connected
		 * if not, returns the minimal spanning forest
		 */
		public Gee.ArrayList<Link> spanning_tree(){

			var path = new Gee.ArrayList<Link>();
			var sorteds = new Gee.LinkedList<Link>();
			sorteds.add_all(edges);
			sorteds.sort((a,b)=>{ 
				if(a.weight > b.weight){ 
					return -1;
				}else if(a.weight < b.weight){ 
					return 1;
				} else{ 
					return 0;
				}
			});
			Link e = sorteds.peek();
			while (!sorteds.is_empty){
				e = sorteds.poll();
				Node start = e.src;
        		Node end = e.dst;
        		bool delete_ok = false;
				var checked = new Gee.ArrayList<Node>();
				var queue = new Gee.LinkedList<Node>();
				checked.add(start);
				queue.offer(start);
				while(!queue.is_empty){
					Node tmp = queue.poll();
					if (tmp == end){
						delete_ok = true;
						break;
					}

					var edge_list = tmp.edges;
					foreach (Link link in edge_list){
						if(link != e){
							if(!checked.contains(link.dst)){
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
					if(e.contains(edge.src) && edge.contains(edge.dst)){
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