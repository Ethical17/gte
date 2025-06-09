$PBExportHeader$w_gtehrr030.srw
forward
global type w_gtehrr030 from window
end type
type dw_2 from datawindow within w_gtehrr030
end type
type rb_2 from radiobutton within w_gtehrr030
end type
type rb_1 from radiobutton within w_gtehrr030
end type
type ddlb_1 from dropdownlistbox within w_gtehrr030
end type
type st_3 from statictext within w_gtehrr030
end type
type cb_1 from commandbutton within w_gtehrr030
end type
type cb_2 from commandbutton within w_gtehrr030
end type
type dw_1 from datawindow within w_gtehrr030
end type
type gb_1 from groupbox within w_gtehrr030
end type
end forward

global type w_gtehrr030 from window
integer width = 5248
integer height = 2296
boolean titlebar = true
string title = "(Gtelar018) - Arear Payment Register"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dw_2 dw_2
rb_2 rb_2
rb_1 rb_1
ddlb_1 ddlb_1
st_3 st_3
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
gb_1 gb_1
end type
global w_gtehrr030 w_gtehrr030

type variables
string ls_dt
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

on w_gtehrr030.create
this.dw_2=create dw_2
this.rb_2=create rb_2
this.rb_1=create rb_1
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.dw_2,&
this.rb_2,&
this.rb_1,&
this.ddlb_1,&
this.st_3,&
this.cb_1,&
this.cb_2,&
this.dw_1,&
this.gb_1}
end on

on w_gtehrr030.destroy
destroy(this.dw_2)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

setpointer(hourglass!)

DECLARE c1 CURSOR FOR  
select distinct to_char(AP_STARTDATE,'dd/mm/yyyy')||'-'||to_char(AP_ENDDATE,'dd/mm/yyyy')||' ('||ap_id||')' from FB_EMP_ARREARPERIOD
WHERE nvl(AP_CONFIRM,0) = 1
order by 1;

open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_dt;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_dt)
		fetch c1 into :ls_dt;
	loop
	close c1;
end if

dw_1.visible = true
dw_2.visible = false

setpointer(arrow!)

end event

type dw_2 from datawindow within w_gtehrr030
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer y = 124
integer width = 2766
integer height = 2056
integer taborder = 30
string dataobject = "dw_gtehrr030a"
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

type rb_2 from radiobutton within w_gtehrr030
integer x = 2085
integer y = 32
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Summary"
end type

event clicked;if rb_1.checked then
	dw_1.visible = true
	dw_2.visible = false
elseif rb_2.checked then
	dw_1.visible = false
	dw_2.visible = true
end if
end event

type rb_1 from radiobutton within w_gtehrr030
integer x = 1797
integer y = 32
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail"
boolean checked = true
end type

event clicked;if rb_1.checked then
	dw_1.visible = true
	dw_2.visible = false
elseif rb_2.checked then
	dw_1.visible = false
	dw_2.visible = true
end if
end event

type ddlb_1 from dropdownlistbox within w_gtehrr030
integer x = 485
integer y = 20
integer width = 1166
integer height = 856
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_gtehrr030
integer x = 9
integer y = 32
integer width = 471
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Start && End Date : "
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtehrr030
integer x = 2523
integer y = 16
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
setpointer(hourglass!)

if isnull(ddlb_1.text) then
	messagebox('Warning!','Please Select Start & End Date !!!')
	return 1
end if

if rb_1.checked then
	dw_1.retrieve(left(right(ddlb_1.text,13),12))
elseif rb_2.checked then
	dw_2.retrieve(left(right(ddlb_1.text,13),12))
end if

if dw_1.rowcount( ) = 0 and dw_2.rowcount( ) = 0 then
	messagebox('Warning!','No Data Found!!!')
	return 1
end if


setpointer(arrow!)
end event

type cb_2 from commandbutton within w_gtehrr030
integer x = 2789
integer y = 16
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_gtehrr030
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 5129
integer height = 2056
string dataobject = "dw_gtehrr030"
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

type gb_1 from groupbox within w_gtehrr030
integer x = 1696
integer width = 795
integer height = 116
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

