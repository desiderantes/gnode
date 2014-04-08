namespace GNode{
	public class Link : GLib.Object{
		
		private Node? src;
		private Node? dst;
		public double weight { get; private set;}
		private uint8 unlinked;
		private Graph parent ;
	
		public Link(Node src, Node dst, double weight, Graph parent){
			this.weight = weight;
			this.src = src;
			this.dst = dst;
			unlinked = 0;
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
			ctx_move_to(src.x, src.y);
			ctx.line_to(dst.x, dst.y);
			ctx.stroke();
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