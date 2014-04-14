namespace GNode{
	public class App : Gtk.Application{
		
		public App(){
			Object(application_id: "com.nongnu.gnode",
				flags: ApplicationFlags.FLAGS_NONE);
		}

		protected override void activate () {
			// Create the window of this application and show it
			GNode.Window window = new GNode.Window (this);
			window.show_all ();
		}
	
		public static int main (string[] args) {
			App app = new App ();
			return app.run (args);
		}
		
	
	}

}