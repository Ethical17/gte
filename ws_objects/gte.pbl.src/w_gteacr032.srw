$PBExportHeader$w_gteacr032.srw
forward
global type w_gteacr032 from window
end type
type st_1 from statictext within w_gteacr032
end type
type ddlb_1 from dropdownlistbox within w_gteacr032
end type
type st_3 from statictext within w_gteacr032
end type
type em_2 from editmask within w_gteacr032
end type
type em_1 from editmask within w_gteacr032
end type
type st_2 from statictext within w_gteacr032
end type
type cb_1 from commandbutton within w_gteacr032
end type
type dw_1 from datawindow within w_gteacr032
end type
end forward

global type w_gteacr032 from window
integer width = 4818
integer height = 2392
boolean titlebar = true
string title = "(Gteflr005) - Reverse Charges"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
ddlb_1 ddlb_1
st_3 st_3
em_2 em_2
em_1 em_1
st_2 st_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteacr032 w_gteacr032

type variables
n_cst_powerfilter iu_powerfilter
string ls_division,ls_bank
string ls_bank_cd,ls_gl_cd,ls_sgl_cd,ls_bnm
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

on w_gteacr032.create
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.em_2=create em_2
this.em_1=create em_1
this.st_2=create st_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.ddlb_1,&
this.st_3,&
this.em_2,&
this.em_1,&
this.st_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteacr032.destroy
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")


end event

type st_1 from statictext within w_gteacr032
boolean visible = false
integer x = 2615
integer y = 36
integer width = 201
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "State :"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteacr032
boolean visible = false
integer x = 2802
integer y = 32
integer width = 978
integer height = 376
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string item[] = {"Assam - 18AAACT8466A5Z8","West Bengal - 19AAACT8466A1ZA","Tripua - 16AAACT8466A1ZG"}
end type

type st_3 from statictext within w_gteacr032
integer x = 759
integer y = 36
integer width = 407
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Year Month :"
boolean focusrectangle = false
end type

type em_2 from editmask within w_gteacr032
integer x = 1170
integer y = 40
integer width = 219
integer height = 72
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
maskdatatype maskdatatype = datemask!
string mask = "YYYYMM"
end type

type em_1 from editmask within w_gteacr032
integer x = 526
integer y = 40
integer width = 219
integer height = 72
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
maskdatatype maskdatatype = datemask!
string mask = "YYYYMM"
end type

type st_2 from statictext within w_gteacr032
integer x = 23
integer y = 36
integer width = 485
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Year Month :"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gteacr032
integer x = 1422
integer y = 40
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;

if isnull(em_1.text) or em_1.text='000000' then
	messagebox('Warning','Please Enter The Year Month !!!')
	return 
end if

if isnull(em_2.text) or em_2.text='000000' then
	messagebox('Warning','Please Enter The Year Month !!!')
	return 
end if

if long(em_1.text) > long(em_2.text) then
	messagebox('Warning','From Year Month can not be greater than To Year Month!!!')
	return 
end if 

//if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
//	messagebox('Warning','Please Select A State !!!')
//	return 
//end if


dw_1.show()
dw_1.settransobject(sqlca)
dw_1.retrieve(em_1.text,em_2.text,right(ddlb_1.text,15))


if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Parameter')
	return 1
end if
end event

type dw_1 from datawindow within w_gteacr032
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 136
integer width = 4485
integer height = 2088
string dataobject = "dw_gteacr032"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

