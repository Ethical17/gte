$PBExportHeader$w_gtehrr023_fb.srw
forward
global type w_gtehrr023_fb from window
end type
type em_1 from editmask within w_gtehrr023_fb
end type
type ddlb_1 from dropdownlistbox within w_gtehrr023_fb
end type
type st_1 from statictext within w_gtehrr023_fb
end type
type cb_1 from commandbutton within w_gtehrr023_fb
end type
type cb_2 from commandbutton within w_gtehrr023_fb
end type
type st_2 from statictext within w_gtehrr023_fb
end type
type dw_1 from datawindow within w_gtehrr023_fb
end type
end forward

global type w_gtehrr023_fb from window
integer width = 3579
integer height = 2360
boolean titlebar = true
string title = "(Gtehrr023) - Payment For Bank"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_1 em_1
ddlb_1 ddlb_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
st_2 st_2
dw_1 dw_1
end type
global w_gtehrr023_fb w_gtehrr023_fb

type variables
string ls_emp_type,ls_division
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

on w_gtehrr023_fb.create
this.em_1=create em_1
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.dw_1=create dw_1
this.Control[]={this.em_1,&
this.ddlb_1,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.st_2,&
this.dw_1}
end on

on w_gtehrr023_fb.destroy
destroy(this.em_1)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)
this.dw_1.modify("datawindow.print.preview = yes")
em_1.text = string(today(),'YYYYMM')
end event

type em_1 from editmask within w_gtehrr023_fb
integer x = 626
integer y = 20
integer width = 238
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "YYYYMM"
end type

type ddlb_1 from dropdownlistbox within w_gtehrr023_fb
integer x = 1326
integer y = 20
integer width = 727
integer height = 572
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string item[] = {"AE - All","ST- Staff","SS - Sub Staff","AT - Apperentice"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_gtehrr023_fb
integer x = 887
integer y = 36
integer width = 402
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Employee Type"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtehrr023_fb
integer x = 2368
integer y = 12
integer width = 279
integer height = 104
integer taborder = 50
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

type cb_2 from commandbutton within w_gtehrr023_fb
integer x = 2089
integer y = 12
integer width = 279
integer height = 104
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;dw_1.settransobject(sqlca)
dw_1.show()

if isnull(em_1.text) or len(em_1.text) <=0 then
	messagebox('Error','Please Enter Current Year Month as (YYYYMM)')
	return 1
end if

ls_emp_type = left(ddlb_1.text,2)

dw_1.settransobject(sqlca)
dw_1.retrieve(long(left(em_1.text,4)),long(right(em_1.text,2)),ls_emp_type)

if dw_1.getrow() = 0 then
	messagebox('Information!','No Data Found For This Perid !!!')
	return 1
end if
end event

type st_2 from statictext within w_gtehrr023_fb
integer x = 27
integer y = 36
integer width = 581
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year Month(YYYYMM)"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gtehrr023_fb
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 9
integer y = 124
integer width = 3520
integer height = 2104
string title = "none"
string dataobject = "dw_gtehrr023_fb"
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

