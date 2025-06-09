$PBExportHeader$w_gtehrr028.srw
forward
global type w_gtehrr028 from window
end type
type st_1 from statictext within w_gtehrr028
end type
type ddlb_2 from dropdownlistbox within w_gtehrr028
end type
type ddlb_1 from dropdownlistbox within w_gtehrr028
end type
type cb_2 from commandbutton within w_gtehrr028
end type
type st_3 from statictext within w_gtehrr028
end type
type cb_1 from commandbutton within w_gtehrr028
end type
type dw_1 from datawindow within w_gtehrr028
end type
end forward

global type w_gtehrr028 from window
integer width = 4571
integer height = 2608
boolean titlebar = true
string title = "(Gtehrr007) - Employee Bonus"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
ddlb_2 ddlb_2
ddlb_1 ddlb_1
cb_2 cb_2
st_3 st_3
cb_1 cb_1
dw_1 dw_1
end type
global w_gtehrr028 w_gtehrr028

type variables
long ll_pbno
string ls_type, ls_yrmn
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_1)
		case "PRINTPREVIEW"
				this.dw_1.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_1.modify("datawindow.print.preview = no")
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

event open;//dw_1.modify("t_co.text = '"+gs_co_name+"'")
//dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)

setpointer(hourglass!)

ddlb_1.reset()

declare c1 cursor for
select distinct to_char(EBP_STARTDATE,'YYYY') from FB_EMPBONUSPERIOD where lbs_emp_type not in ('LP','LO','LT') order by 1 desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_yrmn;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_yrmn)
		fetch c1 into:ls_yrmn;
	loop
	close c1;
end if


setpointer(arrow!)
end event

on w_gtehrr028.create
this.st_1=create st_1
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.st_3=create st_3
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.ddlb_2,&
this.ddlb_1,&
this.cb_2,&
this.st_3,&
this.cb_1,&
this.dw_1}
end on

on w_gtehrr028.destroy
destroy(this.st_1)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type st_1 from statictext within w_gtehrr028
integer x = 1006
integer y = 40
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Employee Type:"
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_gtehrr028
integer x = 1435
integer y = 28
integer width = 677
integer height = 508
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "ALL"
boolean sorted = false
string item[] = {"ALL - ALL","EXE - Executive","ST  - Staff","SS  - Sub Staff"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_1 from dropdownlistbox within w_gtehrr028
integer x = 571
integer y = 28
integer width = 411
integer height = 520
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_gtehrr028
integer x = 2149
integer y = 24
integer width = 265
integer height = 100
integer taborder = 40
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


setpointer(hourglass!)

if isnull(ddlb_1.text) or ddlb_1.text='0000' then
	messagebox('Warning','Please Bonus Year !!!')
	return 
end if

dw_1.retrieve(ddlb_1.text,left(ddlb_2.text,3))
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if

end event

type st_3 from statictext within w_gtehrr028
integer x = 27
integer y = 40
integer width = 549
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bonus Year (YYYY) : "
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtehrr028
integer x = 2409
integer y = 24
integer width = 265
integer height = 100
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

type dw_1 from datawindow within w_gtehrr028
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 132
integer width = 4507
integer height = 2344
string title = "none"
string dataobject = "dw_gtehrr028"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
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

