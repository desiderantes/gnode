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
		private Gtk.Dialog node_dialog;
		[GtkChild]
		private Gtk.Dialog edge_dialog;
		[GtkChild]
		private Gtk.DrawingArea node_area;
		private Graph graph;
		private bool adding_node;
		private bool adding_edge;
		private bool removing_node;
		private bool removing_edge;
		private bool has_spanning_tree;
		private Gee.ArrayList<Link> spanning_tree;
		private Gee.ArrayList<ulong> handlers;
		private Node to_link[2];
		[GtkChild]
		private Gtk.ListStore edge_list;
		[GtkChild]
		private Gtk.ComboBox node_combo;
		[GtkChild]
		private Gtk.Entry weight_entry;

		public Window( App parent ){
			graph = new Graph("New Graph");
			this.application = parent;
			view.insert_column_with_attributes (-1, "Info", new Gtk.CellRendererText (), "text", 0, null);
			view.insert_column_with_attributes (-1, "Value", new Gtk.CellRendererText (), "text", 1, null);
			setup_treeview();
			node_area.add_events (Gdk.EventMask.BUTTON_PRESS_MASK);
			graph.state_changed.connect(setup_treeview);
			handlers = new Gee.ArrayList<ulong>();
			adding_node = false;
			adding_edge = false;
			spanning_tree = new Gee.ArrayList<Link>();
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
			treestore.set (value_iter, 0, "Number of nodes", 1, graph.nodes.size.to_string(), -1);
			treestore.append (out value_iter, info_iter);
			treestore.set (value_iter, 0, "Number of edges", 1, graph.edges.size.to_string(), -1);
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
			disconnect_handlers();
			GLib.print ("Whoah thanks!");
			uint context_id = bar.get_context_id ("add_node");
			bar.push (context_id, "Double click on an empty space on the right surface to add a node");
			adding_node = true;
			handlers.add(node_area.button_press_event.connect(node_adding));
			
		}
		[GtkCallback]
		public void on_add_edge(){
			disconnect_handlers();
			GLib.print ("Dude wut?");
			uint context_id = bar.get_context_id ("add_edge");
			bar.push (context_id, "Click on two nodes to add an edge between them");
			handlers.add(node_area.button_press_event.connect(edge_adding));
			adding_edge = true;
		}
		[GtkCallback]
		public void on_remove_node(){
			disconnect_handlers();
			GLib.print ("Stop pls");
			uint context_id = bar.get_context_id ("remove_node");
			bar.push (context_id, "Click on a node to delete it, and its edges");
			handlers.add(node_area.button_press_event.connect(node_removing));
			removing_node = true;
		}
		[GtkCallback]
		public void on_remove_edge(){
			disconnect_handlers();
			GLib.print ("That makes me moist");
			uint context_id = bar.get_context_id ("remove_edge");
			bar.push (context_id, "Select an edge to remove from teh given list");
			edge_removing();
			removing_edge = true;
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

		public bool node_adding(Gdk.EventButton event){
			bool ok = true;
			
			foreach (Node node in graph.nodes){
				if (node.clicked(event.x,event.y)){
					ok = false;
					break;
				}
			}

			if(ok){		
				graph.add_node(new Node("Node #" + graph.nodes.size.to_string(), graph, event.x, event.y));
				node_area.queue_draw();
			}

			return true;
		}

		public bool node_removing(Gdk.EventButton event){
			foreach (Node node in graph.nodes){
				if (node.clicked(event.x,event.y)){
					graph.remove_node(node);
					break;
				}
			}
			node_area.queue_draw();
			return true;
		}

		public bool edge_adding(Gdk.EventButton event){
			foreach (Node node in graph.nodes){
				if (node.clicked(event.x,event.y)){
					if(to_link[0] == null){
						to_link[0] = node;
						node.selected = true;
						node_area.queue_draw();
					}else if(to_link[1] == null){
						to_link[1] = node;
						node.selected = true;
						node_area.queue_draw();
						edge_dialog.show();
						
					}
					break;
				}
			}
			return true;
		}

  
		public bool edge_removing(){
			edge_list.clear();
			Gtk.TreeIter iter;

	
			foreach(Link edge in graph.edges){
					edge_list.append (out iter);
					edge_list.set (iter, 0,edge);	
			}
			node_dialog.show();
			return true;
		}
		
		[GtkCallback]
		public void weight_add(){
			edge_dialog.hide();
			if(to_link[0] != null && to_link[1] != null){
				to_link[0].connect_to(to_link[1], double.parse (weight_entry.text));
				to_link[0].selected = false;
				to_link[1].selected = false;
				node_area.queue_draw();
			}
			to_link[0] = null;
			to_link[1] = null;
			weight_entry.set_text("");
			disconnect_handlers();
		}

		[GtkCallback]
		public void edge_remove(){
			Link edge = graph.edges.get(node_combo.active);
			graph.remove_edge(edge);
			node_dialog.hide();
			node_area.queue_draw();
		}
		
		private void disconnect_handlers(){
			foreach (ulong handler in handlers){
				node_area.disconnect(handler);
				handlers.remove(handler);
			}
			adding_node = false;
			adding_edge = false;
			removing_node = false;
			removing_edge = false;
			
		}
		[GtkCallback]
		public void get_spanning_tree(){
			GLib.print("Testing spanning_tree");
			spanning_tree.add_all(graph.spanning_tree());
			foreach (Link edge in spanning_tree){
				edge.selected = true;
			}
			graph.state_changed.connect(invalidate_spanning);
		}
		
		public void invalidate_spanning(){
			foreach (Link edge in spanning_tree){
				edge.selected = false;
			}
			graph.state_changed.disconnect(invalidate_spanning);
			node_area.queue_draw();
		}



	}

}