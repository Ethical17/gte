$PBExportHeader$w_gtelar054.srw
forward
global type w_gtelar054 from window
end type
type cb_2 from commandbutton within w_gtelar054
end type
type cb_1 from commandbutton within w_gtelar054
end type
type rb_2 from radiobutton within w_gtelar054
end type
type rb_1 from radiobutton within w_gtelar054
end type
type dw_1 from datawindow within w_gtelar054
end type
type gb_1 from groupbox within w_gtelar054
end type
end forward

global type w_gtelar054 from window
integer width = 3936
integer height = 2104
boolean titlebar = true
string title = "(Gtelar054) - Paybook Wise Active Worker"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_2 cb_2
cb_1 cb_1
rb_2 rb_2
rb_1 rb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_gtelar054 w_gtelar054

type variables
long ll_pbno
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_1)
			SetPointer (Arrow!)						
	case "SAVEAS"
			this.dw_1.saveas()
	case "SFILTER"
			iu_powerfilter.checked = NOT iu_powerfilter.checked
			iu_powerfilter.event ue_clicked()
			m_main.m_file.m_filter.checked = iu_powerfilter.checked			
	case "FILTER"
			setnull(gs_filtertext)
			this.dw_1.setredraw(false)
			this.dw_1.setfilter(gs_filtertext)
			this.dw_1.filter()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
	case "SORT"
			setnull(gs_sorttext)
			this.dw_1.setredraw(false)
			this.dw_1.setsort(gs_sorttext)
			this.dw_1.sort()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
end choose

end event

on w_gtelar054.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.rb_2,&
this.rb_1,&
this.dw_1,&
this.gb_1}
end on

on w_gtelar054.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")




end event

type cb_2 from commandbutton within w_gtelar054
integer x = 1275
integer y = 40
integer width = 270
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gtelar054
integer x = 997
integer y = 40
integer width = 270
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;setpointer(hourglass!)

if rb_1.checked then
	dw_1.DataObject = "dw_gtelar054"
else
	dw_1.DataObject = "dw_gtelar054d"
end if
dw_1.settransobject(sqlca)
dw_1.retrieve()
if dw_1.rowcount() = 0 then
	messagebox('Information!','No data Found !!!')
	return 1
end if
setpointer(arrow!)
end event

type rb_2 from radiobutton within w_gtelar054
integer x = 549
integer y = 48
integer width = 366
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail"
end type

type rb_1 from radiobutton within w_gtelar054
integer x = 105
integer y = 64
integer width = 366
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Summary"
boolean checked = true
end type

type dw_1 from datawindow within w_gtelar054
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 172
integer width = 3849
integer height = 1788
string dataobject = "dw_gtelar054"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

type gb_1 from groupbox within w_gtelar054
integer x = 69
integer y = 8
integer width = 887
integer height = 136
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
end type

