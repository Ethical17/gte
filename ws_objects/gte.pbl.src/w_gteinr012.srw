$PBExportHeader$w_gteinr012.srw
forward
global type w_gteinr012 from window
end type
type sle_1 from singlelineedit within w_gteinr012
end type
type cb_4 from commandbutton within w_gteinr012
end type
type cb_2 from commandbutton within w_gteinr012
end type
type st_4 from statictext within w_gteinr012
end type
type dw_1 from datawindow within w_gteinr012
end type
end forward

global type w_gteinr012 from window
integer width = 3543
integer height = 2232
boolean titlebar = true
string title = "(W_gteinr012) - Item Stock Details"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
sle_1 sle_1
cb_4 cb_4
cb_2 cb_2
st_4 st_4
dw_1 dw_1
end type
global w_gteinr012 w_gteinr012

type variables
string ls_temp,ls_sp_id
boolean lb_neworder, lb_query
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

on w_gteinr012.create
this.sle_1=create sle_1
this.cb_4=create cb_4
this.cb_2=create cb_2
this.st_4=create st_4
this.dw_1=create dw_1
this.Control[]={this.sle_1,&
this.cb_4,&
this.cb_2,&
this.st_4,&
this.dw_1}
end on

on w_gteinr012.destroy
destroy(this.sle_1)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.st_4)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
setpointer(hourglass!)

end event

type sle_1 from singlelineedit within w_gteinr012
integer x = 352
integer y = 24
integer width = 448
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_gteinr012
integer x = 1129
integer y = 24
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_gteinr012
integer x = 859
integer y = 24
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked;
if  isnull(sle_1.text) or sle_1.text = "" then 
	messagebox('Error At Product ','Please Enter An Category')
	return 1
end if;

ls_sp_id = trim(sle_1.text)
dw_1.show()
dw_1.settransobject(sqlca)
dw_1.retrieve(ls_sp_id)


end event

type st_4 from statictext within w_gteinr012
integer x = 55
integer y = 36
integer width = 302
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Item Code: "
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gteinr012
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 5
integer y = 132
integer width = 3474
integer height = 1960
string dataobject = "dw_gteinr012"
boolean hscrollbar = true
boolean vscrollbar = true
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

