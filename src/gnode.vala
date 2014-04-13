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
		private Gtk.Statusbar bar;
		[GtkChild]
		private Gtk.DrawingArea node_area;
		private Graph graph;
		private bool adding_node;
		private bool adding_edge;
		private bool has_spanning_tree;
		private Gee.ArrayList<Link>? spanning_tree;

		public Window( App parent ){
			graph = new Graph("New Graph");
			this.application = parent;
			view.insert_column_with_attributes (-1, "Info", new Gtk.CellRendererText (), "text", 0, null);
			view.insert_column_with_attributes (-1, "Value", new Gtk.CellRendererText (), "text", 1, null);
			setup_treeview();
			graph.state_changed.connect(setup_treeview);
			
			adding_node = false;
			adding_edge = false;
			spanning_tree = null;
			graph.add_node (new GNode.Node("test1", graph, 10,10));
			graph.add_node (new GNode.Node("test2", graph, node_area.get_allocated_width ()/2 + 30,200));
			has_spanning_tree = false;
			node_area.queue_draw();
		}

		private void setup_treeview () {
			
			treestore.clear();
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
			treestore.set (value_iter, 0, "Spanning Tree found", 1, has_spanning_tree.to_string(), -1);
			treestore.append (out value_iter, info_iter);
			treestore.set (value_iter, 0, "Adding Node", 1, adding_node.to_string(), -1);
			treestore.append (out value_iter, info_iter);
			treestore.set (value_iter, 0, "Adding Edge", 1, adding_edge.to_string(), -1);

			if(has_spanning_tree){
				Gtk.TreeIter span_iter;
				treestore.append (out info_iter, root);
				treestore.set (info_iter, 0, "Spanning Tree", -1);

				treestore.append (out value_iter, info_iter);
				treestore.set (value_iter, 0, "You just lost", 1, "The Game", -1);
			}
			
			view.expand_all ();
		}
		[GtkCallback]
		public void on_add_node(){
			node_area.add_events (Gdk.EventMask.BUTTON_PRESS_MASK);
			GLib.print ("Whoah thanks!");
			uint context_id = bar.get_context_id ("add_node");
			bar.push (context_id, "Double click on an empty space on the right surface to add a node");
			
		}
		[GtkCallback]
		public void on_add_edge(){
			node_area.add_events (Gdk.EventMask.BUTTON_PRESS_MASK);
			GLib.print ("Dude wut?");
			uint context_id = bar.get_context_id ("add_edge");
			bar.push (context_id, "Click on two nodes to add an edge between them");
		}
		[GtkCallback]
		public void on_remove_node(){
			node_area.add_events (Gdk.EventMask.BUTTON_PRESS_MASK);
			GLib.print ("Stop pls");
			uint context_id = bar.get_context_id ("remove_node");
			bar.push (context_id, "Click on a node to delete it, and its edges");
		}
		[GtkCallback]
		public void on_remove_edge(){
			node_area.add_events (Gdk.EventMask.BUTTON_PRESS_MASK);
			GLib.print ("That makes me moist");
			uint context_id = bar.get_context_id ("remove_edge");
			bar.push (context_id, "Click on an edge to remove it");
		}
		[GtkCallback]
		public bool node_draw(Cairo.Context ctx){

			graph.draw(ctx);
			if(adding_node){



			}else if(adding_edge){

			} else if (has_spanning_tree){

			}




			return true;
		}






	}

}