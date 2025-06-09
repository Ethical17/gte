$PBExportHeader$w_gtelaf069a.srw
forward
global type w_gtelaf069a from window
end type
type cb_2 from commandbutton within w_gtelaf069a
end type
type em_to from editmask within w_gtelaf069a
end type
type st_2 from statictext within w_gtelaf069a
end type
type em_from from editmask within w_gtelaf069a
end type
type st_5 from statictext within w_gtelaf069a
end type
type st_1 from statictext within w_gtelaf069a
end type
type cb_1 from commandbutton within w_gtelaf069a
end type
type ddlb_1 from dropdownlistbox within w_gtelaf069a
end type
type dw_1 from datawindow within w_gtelaf069a
end type
end forward

global type w_gtelaf069a from window
integer width = 3086
integer height = 2000
boolean titlebar = true
string title = "(W_Gtelaf069a) Employee Wise Details Of Extra work"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowtype windowtype = popup!
windowstate windowstate = maximized!
long backcolor = 67108864
boolean clientedge = true
event ue_option ( )
cb_2 cb_2
em_to em_to
st_2 st_2
em_from em_from
st_5 st_5
st_1 st_1
cb_1 cb_1
ddlb_1 ddlb_1
dw_1 dw_1
end type
global w_gtelaf069a w_gtelaf069a

type variables
long ll_emp_cd, ll_row, ll_col
datetime ld_date
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
	case "PDF"
			this.dw_1.SaveAs("c:\reports\Overtime Summary.pdf",pdf!,true)		
	case "PSR"
			this.dw_1.saveas("c:\reports\Overtime Summary.psr",PSReport!,true)	
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

on w_gtelaf069a.create
this.cb_2=create cb_2
this.em_to=create em_to
this.st_2=create st_2
this.em_from=create em_from
this.st_5=create st_5
this.st_1=create st_1
this.cb_1=create cb_1
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.em_to,&
this.st_2,&
this.em_from,&
this.st_5,&
this.st_1,&
this.cb_1,&
this.ddlb_1,&
this.dw_1}
end on

on w_gtelaf069a.destroy
destroy(this.cb_2)
destroy(this.em_to)
destroy(this.st_2)
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

type cb_2 from commandbutton within w_gtelaf069a
integer x = 2007
integer y = 20
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)
end event

type em_to from editmask within w_gtelaf069a
integer x = 1381
integer y = 24
integer width = 343
integer height = 88
integer taborder = 30
integer textsize = -10
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
string mask = "dd/mm/yyyy"
end type

type st_2 from statictext within w_gtelaf069a
integer x = 1294
integer y = 32
integer width = 91
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "To"
boolean focusrectangle = false
end type

type em_from from editmask within w_gtelaf069a
integer x = 928
integer y = 24
integer width = 334
integer height = 88
integer taborder = 20
integer textsize = -10
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
string mask = "dd/mm/yyyy"
end type

type st_5 from statictext within w_gtelaf069a
integer x = 773
integer y = 32
integer width = 174
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "From [dd/mm/yyyy]"
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtelaf069a
integer x = 14
integer y = 32
integer width = 146
integer height = 76
integer textsize = -10
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

type cb_1 from commandbutton within w_gtelaf069a
integer x = 1737
integer y = 20
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
boolean default = true
end type

event clicked;IF IsDate(em_from.text) = FALSE THEN
	messagebox("Wrong format of given 'FROM' date " ," Please correct and then run again ")
	em_from.setfocus()
elseIF IsDate(em_to.text) = False THEN
	messagebox("Wrong format of given 'TO' date " ," Please correct and then run again ")
	em_to.setfocus()
elseif Date(em_to.text) < Date(em_from.text)   then
	messagebox("Message " ," 'To' date is Small To 'From' Date ")
	em_from.setfocus()
elseif ddlb_1.text <> 'Two Hours' and ddlb_1.text <> 'More Than Two Hours' and ddlb_1.text <> 'Essential Services' then
	messagebox("Type Is Wrong" ," Given Type is Wrong Please Check..!")
	ddlb_1.setfocus()
else
	dw_1.settransobject(Sqlca)
	if ddlb_1.text = 'Two Hours' then
		dw_1.retrieve(DATE(em_from.text),DATE(em_to.text),'T','','')
	elseif ddlb_1.text = 'More Than Two Hours' then
		dw_1.retrieve(DATE(em_from.text),DATE(em_to.text),'M','','')
	else
		dw_1.retrieve(DATE(em_from.text),DATE(em_to.text),'E','','')
	end if
end if	
end event

type ddlb_1 from dropdownlistbox within w_gtelaf069a
integer x = 165
integer y = 20
integer width = 576
integer height = 400
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
string item[] = {"Two Hours","More Than Two Hours","Essential Services"}
end type

type dw_1 from datawindow within w_gtelaf069a
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 9
integer y = 124
integer width = 3013
integer height = 1752
string dataobject = "dw_Gtelaf069a"
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

