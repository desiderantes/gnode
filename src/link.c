/* link.c generated by valac 0.24.0, the Vala compiler
 * generated from link.vala, do not modify */


#include <glib.h>
#include <glib-object.h>
#include <float.h>
#include <math.h>
#include <cairo.h>


#define GNODE_TYPE_LINK (gnode_link_get_type ())
#define GNODE_LINK(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GNODE_TYPE_LINK, GNodeLink))
#define GNODE_LINK_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GNODE_TYPE_LINK, GNodeLinkClass))
#define GNODE_IS_LINK(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GNODE_TYPE_LINK))
#define GNODE_IS_LINK_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GNODE_TYPE_LINK))
#define GNODE_LINK_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GNODE_TYPE_LINK, GNodeLinkClass))

typedef struct _GNodeLink GNodeLink;
typedef struct _GNodeLinkClass GNodeLinkClass;
typedef struct _GNodeLinkPrivate GNodeLinkPrivate;

#define GNODE_TYPE_NODE (gnode_node_get_type ())
#define GNODE_NODE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GNODE_TYPE_NODE, GNodeNode))
#define GNODE_NODE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GNODE_TYPE_NODE, GNodeNodeClass))
#define GNODE_IS_NODE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GNODE_TYPE_NODE))
#define GNODE_IS_NODE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GNODE_TYPE_NODE))
#define GNODE_NODE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GNODE_TYPE_NODE, GNodeNodeClass))

typedef struct _GNodeNode GNodeNode;
typedef struct _GNodeNodeClass GNodeNodeClass;

#define GNODE_TYPE_GRAPH (gnode_graph_get_type ())
#define GNODE_GRAPH(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GNODE_TYPE_GRAPH, GNodeGraph))
#define GNODE_GRAPH_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GNODE_TYPE_GRAPH, GNodeGraphClass))
#define GNODE_IS_GRAPH(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GNODE_TYPE_GRAPH))
#define GNODE_IS_GRAPH_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GNODE_TYPE_GRAPH))
#define GNODE_GRAPH_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GNODE_TYPE_GRAPH, GNodeGraphClass))

typedef struct _GNodeGraph GNodeGraph;
typedef struct _GNodeGraphClass GNodeGraphClass;
#define _g_object_unref0(var) ((var == NULL) ? NULL : (var = (g_object_unref (var), NULL)))

struct _GNodeLink {
	GObject parent_instance;
	GNodeLinkPrivate * priv;
};

struct _GNodeLinkClass {
	GObjectClass parent_class;
};

struct _GNodeLinkPrivate {
	GNodeNode* src;
	GNodeNode* dst;
	gdouble _weight;
	guint8 unlinked;
	GNodeGraph* parent;
};


static gpointer gnode_link_parent_class = NULL;

GType gnode_link_get_type (void) G_GNUC_CONST;
GType gnode_node_get_type (void) G_GNUC_CONST;
GType gnode_graph_get_type (void) G_GNUC_CONST;
#define GNODE_LINK_GET_PRIVATE(o) (G_TYPE_INSTANCE_GET_PRIVATE ((o), GNODE_TYPE_LINK, GNodeLinkPrivate))
enum  {
	GNODE_LINK_DUMMY_PROPERTY,
	GNODE_LINK_WEIGHT
};
GNodeLink* gnode_link_new (GNodeNode* src, GNodeNode* dst, gdouble weight, GNodeGraph* parent);
GNodeLink* gnode_link_construct (GType object_type, GNodeNode* src, GNodeNode* dst, gdouble weight, GNodeGraph* parent);
static void gnode_link_set_weight (GNodeLink* self, gdouble value);
gboolean gnode_link_contains (GNodeLink* self, GNodeNode* node);
GNodeNode* gnode_link_get_pair (GNodeLink* self, GNodeNode* node);
void gnode_link_draw (GNodeLink* self, cairo_t* ctx);
void gnode_link_unlink (GNodeLink* self, GNodeNode* node);
void gnode_graph_remove_edge (GNodeGraph* self, GNodeLink* edge);
gdouble gnode_link_get_weight (GNodeLink* self);
static void gnode_link_finalize (GObject* obj);
static void _vala_gnode_link_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec);
static void _vala_gnode_link_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec);


static gpointer _g_object_ref0 (gpointer self) {
	return self ? g_object_ref (self) : NULL;
}


GNodeLink* gnode_link_construct (GType object_type, GNodeNode* src, GNodeNode* dst, gdouble weight, GNodeGraph* parent) {
	GNodeLink * self = NULL;
	gdouble _tmp0_ = 0.0;
	GNodeNode* _tmp1_ = NULL;
	GNodeNode* _tmp2_ = NULL;
	GNodeNode* _tmp3_ = NULL;
	GNodeNode* _tmp4_ = NULL;
	g_return_val_if_fail (src != NULL, NULL);
	g_return_val_if_fail (dst != NULL, NULL);
	g_return_val_if_fail (parent != NULL, NULL);
	self = (GNodeLink*) g_object_new (object_type, NULL);
	_tmp0_ = weight;
	gnode_link_set_weight (self, _tmp0_);
	_tmp1_ = src;
	_tmp2_ = _g_object_ref0 (_tmp1_);
	_g_object_unref0 (self->priv->src);
	self->priv->src = _tmp2_;
	_tmp3_ = dst;
	_tmp4_ = _g_object_ref0 (_tmp3_);
	_g_object_unref0 (self->priv->dst);
	self->priv->dst = _tmp4_;
	self->priv->unlinked = (guint8) 0;
	return self;
}


GNodeLink* gnode_link_new (GNodeNode* src, GNodeNode* dst, gdouble weight, GNodeGraph* parent) {
	return gnode_link_construct (GNODE_TYPE_LINK, src, dst, weight, parent);
}


gboolean gnode_link_contains (GNodeLink* self, GNodeNode* node) {
	gboolean result = FALSE;
	gboolean _tmp0_ = FALSE;
	GNodeNode* _tmp1_ = NULL;
	GNodeNode* _tmp2_ = NULL;
	g_return_val_if_fail (self != NULL, FALSE);
	g_return_val_if_fail (node != NULL, FALSE);
	_tmp1_ = node;
	_tmp2_ = self->priv->src;
	if (_tmp1_ == _tmp2_) {
		_tmp0_ = TRUE;
	} else {
		GNodeNode* _tmp3_ = NULL;
		GNodeNode* _tmp4_ = NULL;
		_tmp3_ = node;
		_tmp4_ = self->priv->dst;
		_tmp0_ = _tmp3_ == _tmp4_;
	}
	result = _tmp0_;
	return result;
}


GNodeNode* gnode_link_get_pair (GNodeLink* self, GNodeNode* node) {
	GNodeNode* result = NULL;
	GNodeNode* _tmp0_ = NULL;
	GNodeNode* _tmp1_ = NULL;
	g_return_val_if_fail (self != NULL, NULL);
	g_return_val_if_fail (node != NULL, NULL);
	_tmp0_ = node;
	_tmp1_ = self->priv->src;
	if (_tmp0_ == _tmp1_) {
		GNodeNode* _tmp2_ = NULL;
		GNodeNode* _tmp3_ = NULL;
		_tmp2_ = self->priv->dst;
		_tmp3_ = _g_object_ref0 (_tmp2_);
		result = _tmp3_;
		return result;
	} else {
		GNodeNode* _tmp4_ = NULL;
		GNodeNode* _tmp5_ = NULL;
		_tmp4_ = node;
		_tmp5_ = self->priv->dst;
		if (_tmp4_ == _tmp5_) {
			GNodeNode* _tmp6_ = NULL;
			GNodeNode* _tmp7_ = NULL;
			_tmp6_ = self->priv->src;
			_tmp7_ = _g_object_ref0 (_tmp6_);
			result = _tmp7_;
			return result;
		}
	}
	result = NULL;
	return result;
}


void gnode_link_draw (GNodeLink* self, cairo_t* ctx) {
	g_return_if_fail (self != NULL);
	g_return_if_fail (ctx != NULL);
}


void gnode_link_unlink (GNodeLink* self, GNodeNode* node) {
	GNodeNode* _tmp0_ = NULL;
	GNodeNode* _tmp1_ = NULL;
	guint8 _tmp6_ = 0U;
	g_return_if_fail (self != NULL);
	g_return_if_fail (node != NULL);
	_tmp0_ = node;
	_tmp1_ = self->priv->src;
	if (_tmp0_ == _tmp1_) {
		guint8 _tmp2_ = 0U;
		_g_object_unref0 (self->priv->src);
		self->priv->src = NULL;
		_tmp2_ = self->priv->unlinked;
		self->priv->unlinked = _tmp2_ + 1;
	} else {
		GNodeNode* _tmp3_ = NULL;
		GNodeNode* _tmp4_ = NULL;
		_tmp3_ = node;
		_tmp4_ = self->priv->dst;
		if (_tmp3_ == _tmp4_) {
			guint8 _tmp5_ = 0U;
			_g_object_unref0 (self->priv->dst);
			self->priv->dst = NULL;
			_tmp5_ = self->priv->unlinked;
			self->priv->unlinked = _tmp5_ + 1;
		}
	}
	_tmp6_ = self->priv->unlinked;
	if (((gint) _tmp6_) == 2) {
		GNodeGraph* _tmp7_ = NULL;
		_tmp7_ = self->priv->parent;
		gnode_graph_remove_edge (_tmp7_, self);
		g_object_unref ((GObject*) self);
	}
}


gdouble gnode_link_get_weight (GNodeLink* self) {
	gdouble result;
	gdouble _tmp0_ = 0.0;
	g_return_val_if_fail (self != NULL, 0.0);
	_tmp0_ = self->priv->_weight;
	result = _tmp0_;
	return result;
}


static void gnode_link_set_weight (GNodeLink* self, gdouble value) {
	gdouble _tmp0_ = 0.0;
	g_return_if_fail (self != NULL);
	_tmp0_ = value;
	self->priv->_weight = _tmp0_;
	g_object_notify ((GObject *) self, "weight");
}


static void gnode_link_class_init (GNodeLinkClass * klass) {
	gnode_link_parent_class = g_type_class_peek_parent (klass);
	g_type_class_add_private (klass, sizeof (GNodeLinkPrivate));
	G_OBJECT_CLASS (klass)->get_property = _vala_gnode_link_get_property;
	G_OBJECT_CLASS (klass)->set_property = _vala_gnode_link_set_property;
	G_OBJECT_CLASS (klass)->finalize = gnode_link_finalize;
	g_object_class_install_property (G_OBJECT_CLASS (klass), GNODE_LINK_WEIGHT, g_param_spec_double ("weight", "weight", "weight", -G_MAXDOUBLE, G_MAXDOUBLE, 0.0, G_PARAM_STATIC_NAME | G_PARAM_STATIC_NICK | G_PARAM_STATIC_BLURB | G_PARAM_READABLE));
}


static void gnode_link_instance_init (GNodeLink * self) {
	self->priv = GNODE_LINK_GET_PRIVATE (self);
}


static void gnode_link_finalize (GObject* obj) {
	GNodeLink * self;
	self = G_TYPE_CHECK_INSTANCE_CAST (obj, GNODE_TYPE_LINK, GNodeLink);
	_g_object_unref0 (self->priv->src);
	_g_object_unref0 (self->priv->dst);
	_g_object_unref0 (self->priv->parent);
	G_OBJECT_CLASS (gnode_link_parent_class)->finalize (obj);
}


GType gnode_link_get_type (void) {
	static volatile gsize gnode_link_type_id__volatile = 0;
	if (g_once_init_enter (&gnode_link_type_id__volatile)) {
		static const GTypeInfo g_define_type_info = { sizeof (GNodeLinkClass), (GBaseInitFunc) NULL, (GBaseFinalizeFunc) NULL, (GClassInitFunc) gnode_link_class_init, (GClassFinalizeFunc) NULL, NULL, sizeof (GNodeLink), 0, (GInstanceInitFunc) gnode_link_instance_init, NULL };
		GType gnode_link_type_id;
		gnode_link_type_id = g_type_register_static (G_TYPE_OBJECT, "GNodeLink", &g_define_type_info, 0);
		g_once_init_leave (&gnode_link_type_id__volatile, gnode_link_type_id);
	}
	return gnode_link_type_id__volatile;
}


static void _vala_gnode_link_get_property (GObject * object, guint property_id, GValue * value, GParamSpec * pspec) {
	GNodeLink * self;
	self = G_TYPE_CHECK_INSTANCE_CAST (object, GNODE_TYPE_LINK, GNodeLink);
	switch (property_id) {
		case GNODE_LINK_WEIGHT:
		g_value_set_double (value, gnode_link_get_weight (self));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}


static void _vala_gnode_link_set_property (GObject * object, guint property_id, const GValue * value, GParamSpec * pspec) {
	GNodeLink * self;
	self = G_TYPE_CHECK_INSTANCE_CAST (object, GNODE_TYPE_LINK, GNodeLink);
	switch (property_id) {
		case GNODE_LINK_WEIGHT:
		gnode_link_set_weight (self, g_value_get_double (value));
		break;
		default:
		G_OBJECT_WARN_INVALID_PROPERTY_ID (object, property_id, pspec);
		break;
	}
}


