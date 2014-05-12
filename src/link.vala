namespace GNode{
	public class Link : GLib.Object{

		public Node? src{ get; private set;}
		public Node? dst{ get; private set;}
		public double weight { get; private set;}
		private uint8 unlinked;
		private Graph parent ;
		public bool selected;

		public Link(Node src, Node dst, double weight, Graph parent){
			this.weight = weight;
			this.src = src;
			this.dst = dst;
			unlinked = 0;
			this.selected = false;
		}

		public bool contains (Node node){
			return (node == src || node == dst);
		}

		public Node? get_pair(Node node){
			if(node == src){
				return dst;
			} else if (node == dst){
				return src; 
			}
			return null;
		}

		public void draw(Cairo.Context ctx){
			if(selected){
				ctx.set_source_rgba(1, 0.9, 0.9, 1);

			}else{
				ctx.set_source_rgba(0.0, 0.0, 0.8, 0.6);
			}
			ctx.set_line_width(6.0);

			if(src ==dst){
				uint howmuch = parent.similar_edges(this) + 1;
				ctx.move_to(src.x+(howmuch*20),src.y+(howmuch*20));
				ctx.arc(src.x+(howmuch*20), src.y+(howmuch*20), howmuch*20, 0, 2.0*3.14);

			}else{
				ctx.move_to(src.x, src.y);
				if(parent.similar_edges(this) > 0){
					uint howmuch = parent.similar_edges(this);
					if(howmuch % 2 == 0){
						ctx.curve_to(src.x,src.y,  dst.x + (howmuch * 20),  src.y  + (howmuch * 20) , dst.x, dst.y);
					}else{
						ctx.curve_to(src.x,src.y,  src.x  + (howmuch * 20),  dst.y + (howmuch * 20), src.x, src.y);
					}

				}else{
					ctx.line_to(dst.x, dst.y);
				}
			}
			ctx.stroke();
		}

		public bool clicked(double xc, double yc){
			if(src != dst){

			}else{

			}

			return false;
		}

		public string to_string(){
			return "Edge of weight " + weight.to_string() + " from " + src.label + " to " + dst.label;
		}

		public void unlink(Node node){
			if(node == src){
				src = null;
				unlinked++;
			} else if (node == dst){
				dst = null;
				unlinked++; 
			}
			if(unlinked == 2){
				parent.remove_edge(this);
				this.unref();
			}
		}
	}
}