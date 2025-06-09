$PBExportHeader$w_zoom.srw
$PBExportComments$Zoom control Window
forward
global type w_zoom from window
end type
type cb_reset from commandbutton within w_zoom
end type
type st_1 from statictext within w_zoom
end type
type st_percent from statictext within w_zoom
end type
type cb_close from commandbutton within w_zoom
end type
type hsb_zoom from hscrollbar within w_zoom
end type
end forward

global type w_zoom from window
integer x = 759
integer y = 1052
integer width = 1390
integer height = 444
boolean titlebar = true
string title = "Zoom Control"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 79741120
boolean center = true
cb_reset cb_reset
st_1 st_1
st_percent st_percent
cb_close cb_close
hsb_zoom hsb_zoom
end type
global w_zoom w_zoom

type variables
DataWindow  vi_DC           // Data Window Pointer
end variables

on w_zoom.create
this.cb_reset=create cb_reset
this.st_1=create st_1
this.st_percent=create st_percent
this.cb_close=create cb_close
this.hsb_zoom=create hsb_zoom
this.Control[]={this.cb_reset,&
this.st_1,&
this.st_percent,&
this.cb_close,&
this.hsb_zoom}
end on

on w_zoom.destroy
destroy(this.cb_reset)
destroy(this.st_1)
destroy(this.st_percent)
destroy(this.cb_close)
destroy(this.hsb_zoom)
end on

type cb_reset from commandbutton within w_zoom
integer x = 709
integer y = 224
integer width = 210
integer height = 84
integer taborder = 2
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Reset"
end type

event clicked;hsb_zoom.position = 100
hsb_zoom.TriggerEvent (Moved!)
end event

type st_1 from statictext within w_zoom
integer x = 814
integer y = 24
integer width = 110
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "%"
boolean focusrectangle = false
end type

type st_percent from statictext within w_zoom
integer x = 530
integer y = 24
integer width = 274
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "?"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_zoom
integer x = 466
integer y = 224
integer width = 210
integer height = 84
integer taborder = 1
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
boolean default = true
end type

event clicked;Close (Parent)
end event

type hsb_zoom from hscrollbar within w_zoom
integer x = 69
integer y = 112
integer width = 1221
integer height = 64
integer minposition = 30
integer maxposition = 300
integer position = 100
end type

event constructor;vi_dc = Message.PowerObjectParm														// Set DC pointer
IF Upper(String(vi_dc.Object.DataWindow.Print.Preview)) = 'YES' THEN		// Preview mode?
	This.position = Integer(vi_dc.object.DataWindow.Print.Preview.Zoom)		// Set ScrollBar position
else
	This.position = Integer(vi_dc.object.DataWindow.Zoom)							// Set ScrollBar position
END IF
This.TriggerEvent(Moved!)
end event

event moved;IF Upper(String(vi_dc.Object.DataWindow.Print.Preview)) = 'YES' THEN		// Preview mode?
	vi_dc.object.DataWindow.Print.Preview.Zoom = (This.position)				// Set Zoom
else
	vi_dc.object.DataWindow.Zoom = (This.position)
END IF

st_percent.text = String (This.Position)

end event

event lineright;This.Position ++
This.TriggerEvent (Moved!)
end event

event lineleft;This.Position --
This.TriggerEvent (Moved!)
end event

event pageright;This.Position = This.Position + 10
This.TriggerEvent (Moved!)
end event

event pageleft;This.Position = This.Position - 10
This.TriggerEvent (Moved!)
end event

