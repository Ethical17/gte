$PBExportHeader$w_gtelaf069c.srw
forward
global type w_gtelaf069c from window
end type
type cb_2 from commandbutton within w_gtelaf069c
end type
type em_from from editmask within w_gtelaf069c
end type
type st_5 from statictext within w_gtelaf069c
end type
type st_1 from statictext within w_gtelaf069c
end type
type cb_1 from commandbutton within w_gtelaf069c
end type
type ddlb_1 from dropdownlistbox within w_gtelaf069c
end type
type dw_1 from datawindow within w_gtelaf069c
end type
end forward

global type w_gtelaf069c from window
integer width = 3671
integer height = 2132
boolean titlebar = true
string title = "(W_Gtelaf069c) Extra Wage Summary"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
event ue_option ( )
cb_2 cb_2
em_from em_from
st_5 st_5
st_1 st_1
cb_1 cb_1
ddlb_1 ddlb_1
dw_1 dw_1
end type
global w_gtelaf069c w_gtelaf069c

type variables
long ll_emp_cd
datetime ld_lfrom
date ld_to_day
string ls_slip_ty
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();choose case gs_ueoption
	case "PRINT"
				OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
				this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
				this.dw_1.modify("datawindow.print.preview = no")
	case "SAVEAS"
				this.dw_1.SaveAs()	
//	case "PDF"
//			this.dw_1.SaveAs("c:\reports\Extra_Wages.pdf",pdf!,true)		
//	case "PSR"
//			this.dw_1.saveas("c:\reports\Extra_Wages.psr",PSReport!,true)	
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

on w_gtelaf069c.create
this.cb_2=create cb_2
this.em_from=create em_from
this.st_5=create st_5
this.st_1=create st_1
this.cb_1=create cb_1
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.em_from,&
this.st_5,&
this.st_1,&
this.cb_1,&
this.ddlb_1,&
this.dw_1}
end on

on w_gtelaf069c.destroy
destroy(this.cb_2)
destroy(this.em_from)
destroy(this.st_5)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.ddlb_1)
destroy(this.dw_1)
end on

event open;//f_change_menu(this)
dw_1.settransobject(sqlca)
ddlb_1.text = 'Two Hours'

end event

type cb_2 from commandbutton within w_gtelaf069c
integer x = 1943
integer y = 12
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

type em_from from editmask within w_gtelaf069c
integer x = 1390
integer y = 16
integer width = 270
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm"
end type

type st_5 from statictext within w_gtelaf069c
integer x = 763
integer y = 24
integer width = 608
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Year/Month [YYYY-MM]"
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtelaf069c
integer x = 18
integer y = 24
integer width = 142
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Type"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelaf069c
integer x = 1669
integer y = 12
integer width = 261
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
boolean default = true
end type

event clicked;IF LenA(em_from.text) <> 7 THEN 
	messagebox("Wrong format of given 'YEAR/MONTH' " ," Please correct and then run again ")
	em_from.setfocus()
elseif ddlb_1.text <> 'Two Hours' and ddlb_1.text <> 'More Than Two Hours'  and ddlb_1.text <> 'Essential Services' then
	messagebox("Type Is Wrong" ," Given Type is Wrong Please Check..!")
	ddlb_1.setfocus()
else
	double ld_cla
	long l_days
	string m_text,m_frdt,m_slip_type
	m_frdt = LeftA(em_from.text,4)+RightA(em_from.text,2)
	
	
	setpointer(hourglass!)
	
  
		dw_1.retrieve(m_frdt)

end if	
end event

type ddlb_1 from dropdownlistbox within w_gtelaf069c
integer x = 169
integer y = 16
integer width = 571
integer height = 400
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
string item[] = {"Two Hours","More Than Two Hours","Essential Services"}
end type

type dw_1 from datawindow within w_gtelaf069c
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 18
integer y = 124
integer width = 3534
integer height = 1888
string dataobject = "dw_Gtelaf069c"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
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

