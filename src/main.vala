namespace GNode {

	public class App : Gtk.Application {
		
		public App() {
			Object (application_id: "com.nongnu.gnode",
				flags: ApplicationFlags.FLAGS_NONE);
		}

		protected override void activate () {
			GNode.Window window = new GNode.Window (this);
			window.show_all ();
			window.destroy.connect (Gtk.main_quit);
		}
	
		public static int main (string[] args) {
			Gtk.init (ref args);
			App app = new App ();
			return app.run (args);
		}
	}
}
