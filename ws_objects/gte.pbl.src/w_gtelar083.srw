$PBExportHeader$w_gtelar083.srw
forward
global type w_gtelar083 from window
end type
type cb_2 from commandbutton within w_gtelar083
end type
type dw_1 from datawindow within w_gtelar083
end type
end forward

global type w_gtelar083 from window
integer width = 2363
integer height = 2780
boolean titlebar = true
string title = "gtelar083 -Labour Exception Report"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_2 cb_2
dw_1 dw_1
end type
global w_gtelar083 w_gtelar083

type variables
string ls_item_ty,ls_frym, ls_toym
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();	choose case gs_ueoption
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

on w_gtelar083.create
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.dw_1}
end on

on w_gtelar083.destroy
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)
dw_1.retrieve()

 if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found')
	
end if


end event

type cb_2 from commandbutton within w_gtelar083
integer x = 750
integer y = 28
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_gtelar083
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 152
integer width = 2181
integer height = 2080
integer taborder = 30
string dataobject = "dw_gtelar083"
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

event clicked;//if row > 0 then
//	dw_2.show()
//	ls_frym =dp_1.text
//     ls_toym =dp_2.text
//
//	dw_2.settransobject(sqlca)
//	dw_2.retrieve(ls_frym,ls_toym,dw_1.getitemstring(row,'sup_id'))	
//end if
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

