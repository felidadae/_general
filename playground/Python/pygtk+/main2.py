import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk
from gi.repository import GdkPixbuf
import numpy
from PIL import Image

class PixbufWindow(Gtk.Window):

    def __init__(self):
        Gtk.Window.__init__(self, title="CellRendererPixbuf Example")

        self.set_default_size(600, 600)

        w=300
        h=300
        # pil_image = Image.new(size=(w,w), mode="RGB", color=(250,250,250))

        dddd = bytearray([255]*400*400*3)
        # for i in range(400):
        # 	d[i*400*3:(i+1)*400*3] = i%255dddd

        pixbuf = GdkPixbuf.Pixbuf.new_from_data(
        	data=dddd,
        	colorspace=GdkPixbuf.Colorspace.RGB, 
        	has_alpha='RGB',
        	bits_per_sample=8, 
        	width=w, 
        	height=h,
        	rowstride=w*3)
        
        image = Gtk.Image.new_from_pixbuf(pixbuf)
        image.set_size_request(w,w)
        self.add(image)

win = PixbufWindow()
win.connect("delete-event", Gtk.main_quit)
win.show_all()
Gtk.main()
