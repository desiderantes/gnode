namespace GNode{

	[GtkTemplate (ui = "/ui/gnode.ui")]
	public class Window : Gtk.ApplicationWindow{

		[GtkChild]
		private Gtk.Menu menu;
		[GtkChild]
		private Gtk.TreeStore treestore;
		[GtkChild]
		private Gtk.TreeView view;
		[GtkChild]
		private Gtk.Notebook notebook;
		[GtkChild]
		private Gtk.DrawingArea node_area;
		private Graph graph;
		private bool adding_node;
		private bool adding_edge;
		private bool cheapest_path;
		private Gee.ArrayList<Link> cheap_path;

		public Window( App parent ){
			graph = new Graph("New Graph");
			this.application = parent;
			setup_treeview();
			node_area.add_events (Gdk.EventMask.BUTTON_PRESS_MASK);
			adding_node = false;
			adding_edge = false;
			cheap_path = null;
			graph.add_node (new GNode.Node("test1", graph, 120,120));
			graph.add_node (new GNode.Node("test2", graph, 200,200));
			cheapest_path = false;
			node_area.queue_draw();
		}

		private void setup_treeview () {

			Gtk.TreeIter root;
			Gtk.TreeIter info_iter;
			Gtk.TreeIter value_iter;

			treestore.append (out root, null);
			treestore.set (root, 0, graph.title, -1);

			treestore.append (out info_iter, root);
			treestore.set (info_iter, 0, "Basic Info", -1);

			treestore.append (out value_iter, info_iter);
			treestore.set (value_iter, 0, "Connected", 1, graph.is_connected().to_string(), -1);
			treestore.append (out value_iter, info_iter);
			treestore.set (value_iter, 0, "Heart of Darkness", 1, "$4.99", -1);
			treestore.append (out value_iter, info_iter);
			treestore.set (value_iter, 0, "Ulysses", 1, "$26.09", -1);
			treestore.append (out value_iter, info_iter);
			treestore.set (value_iter, 0, "Effective Vala", 1, "$38.99", -1);


			view.expand_all ();
		}
		[GtkCallback]
		public void on_add_node(){

		}
		[GtkCallback]
		public void on_add_edge(){

		}
		[GtkCallback]
		public void on_remove_node(){

		}
		[GtkCallback]
		public void on_remove_edge(){

		}
		[GtkCallback]
		public bool node_draw(Cairo.Context ctx){

			graph.draw(ctx);
			if(adding_node){



			}else if(adding_edge){

			} else if (cheapest_path){

			}




			return true;
		}






	}

}