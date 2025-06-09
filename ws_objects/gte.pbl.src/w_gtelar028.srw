$PBExportHeader$w_gtelar028.srw
forward
global type w_gtelar028 from window
end type
type rb_1 from radiobutton within w_gtelar028
end type
type rb_2 from radiobutton within w_gtelar028
end type
type em_2 from editmask within w_gtelar028
end type
type st_4 from statictext within w_gtelar028
end type
type em_1 from editmask within w_gtelar028
end type
type st_3 from statictext within w_gtelar028
end type
type cb_1 from commandbutton within w_gtelar028
end type
type cb_2 from commandbutton within w_gtelar028
end type
type st_2 from statictext within w_gtelar028
end type
type dw_1 from datawindow within w_gtelar028
end type
type ddlb_2 from dropdownlistbox within w_gtelar028
end type
type gb_1 from groupbox within w_gtelar028
end type
type dw_2 from datawindow within w_gtelar028
end type
end forward

global type w_gtelar028 from window
integer width = 4210
integer height = 2312
boolean titlebar = true
string title = "(Gtelar028) - Overtime Details"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
rb_1 rb_1
rb_2 rb_2
em_2 em_2
st_4 st_4
em_1 em_1
st_3 st_3
cb_1 cb_1
cb_2 cb_2
st_2 st_2
dw_1 dw_1
ddlb_2 ddlb_2
gb_1 gb_1
dw_2 dw_2
end type
global w_gtelar028 w_gtelar028

type variables
long ll_pbno
string ls_temp, ls_kamid, ls_emp
datetime ld_dt
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();if rb_1.checked then
	choose case gs_ueoption
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
else
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_2)
		case "PRINTPREVIEW"
				this.dw_2.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_2.modify("datawindow.print.preview = no")
		case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_2)
			SetPointer (Arrow!)						
	case "SAVEAS"
				this.dw_2.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked				
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_2.setredraw(false)
				this.dw_2.setfilter(gs_filtertext)
				this.dw_2.filter()
				this.dw_2.groupcalc()
				if this.dw_2.rowcount() > 0 then;
					this.dw_2.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_2.setredraw(false)
				this.dw_2.setsort(gs_sorttext)
				this.dw_2.sort()
				this.dw_2.groupcalc()
				if this.dw_2.rowcount() > 0 then;
					this.dw_2.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose	
end if

end event

on w_gtelar028.create
this.rb_1=create rb_1
this.rb_2=create rb_2
this.em_2=create em_2
this.st_4=create st_4
this.em_1=create em_1
this.st_3=create st_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.dw_1=create dw_1
this.ddlb_2=create ddlb_2
this.gb_1=create gb_1
this.dw_2=create dw_2
this.Control[]={this.rb_1,&
this.rb_2,&
this.em_2,&
this.st_4,&
this.em_1,&
this.st_3,&
this.cb_1,&
this.cb_2,&
this.st_2,&
this.dw_1,&
this.ddlb_2,&
this.gb_1,&
this.dw_2}
end on

on w_gtelar028.destroy
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.em_2)
destroy(this.st_4)
destroy(this.em_1)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.ddlb_2)
destroy(this.gb_1)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")


//setpointer(hourglass!)
//ddlb_2.additem('ALL')
//
//declare c2 cursor for
//select distinct initcap(Emp_name)||' ('||OT_EMP_ID||')' from fb_overtime,fb_employee where OT_EMP_ID = emp_id(+)  order by 1;
//
//open c2;
//
//IF sqlca.sqlcode = 0 THEN 
//	fetch c2 into :ls_emp;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_2.additem(ls_emp)
//		fetch c2 into:ls_emp;
//	loop
//	close c2;
//end if
//
//ddlb_2.text = 'ALL'
//
//setpointer(Arrow!)
end event

type rb_1 from radiobutton within w_gtelar028
integer x = 32
integer y = 44
integer width = 251
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail"
boolean checked = true
end type

event clicked;dw_2.hide()
dw_1.show()
end event

type rb_2 from radiobutton within w_gtelar028
integer x = 293
integer y = 44
integer width = 311
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Summary"
end type

event clicked;dw_1.hide()
dw_2.show()
end event

type em_2 from editmask within w_gtelar028
integer x = 1897
integer y = 32
integer width = 306
integer height = 92
integer taborder = 30
integer textsize = -10
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
string mask = "dd/mm/yyyy"
end type

event modified;setpointer(hourglass!)
ddlb_2.additem('ALL')

declare c2 cursor for
select distinct initcap(Emp_name)||' ('||OT_EMP_ID||')' from fb_overtime,fb_employee
where OT_EMP_ID = emp_id(+)  and OT_DT between to_date(:em_1.text,'dd/mm/yyyy') and to_date(:em_2.text,'dd/mm/yyyy')
order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_emp;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_emp)
		fetch c2 into:ls_emp;
	loop
	close c2;
end if

ddlb_2.text = 'ALL'

setpointer(Arrow!)
end event

type st_4 from statictext within w_gtelar028
integer x = 1646
integer y = 44
integer width = 247
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date :"
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtelar028
integer x = 1312
integer y = 32
integer width = 306
integer height = 92
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
string mask = "dd/mm/yyyy"
end type

type st_3 from statictext within w_gtelar028
integer x = 658
integer y = 44
integer width = 654
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date (dd/mm/yyyy) : "
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelar028
integer x = 3323
integer y = 32
integer width = 265
integer height = 100
integer taborder = 50
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

if isnull(em_1.text) or isnull(em_2.text) or em_1.text='00/00/0000' or em_2.text = '00/00/0000' then
	messagebox('Warning','Please Enter From And To Date')
	return 
end if

if Date(em_1.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','From Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(em_2.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','To Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(em_1.text) > Date(em_2.text) then
	messagebox('Alert!','From Date Should Be <= Than To Date !!!')
	return 1
end if

setpointer(hourglass!)

if rb_1.checked then
	dw_1.show()
	dw_2.hide()
	dw_1.retrieve(trim(left(right(ddlb_2.text,8),7)),em_1.text,em_2.text)
	if dw_1.rowcount() = 0 then
		messagebox('Alert!','No Data Found !!!')
		return 1
	end if
else
	dw_1.hide()
	dw_2.show()
	dw_2.retrieve(em_1.text,em_2.text)
	if dw_2.rowcount() = 0 then
		messagebox('Alert!','No Data Found !!!')
		return 1
	end if
end if	
setpointer(arrow!)
end event

type cb_2 from commandbutton within w_gtelar028
integer x = 3589
integer y = 32
integer width = 265
integer height = 100
integer taborder = 60
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

type st_2 from statictext within w_gtelar028
integer x = 2226
integer y = 48
integer width = 210
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Labour"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gtelar028
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 144
integer width = 4160
integer height = 2056
string dataobject = "dw_gtelar028"
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

type ddlb_2 from dropdownlistbox within w_gtelar028
integer x = 2437
integer y = 36
integer width = 873
integer height = 608
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
end type

type gb_1 from groupbox within w_gtelar028
integer x = 5
integer width = 635
integer height = 136
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_2 from datawindow within w_gtelar028
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 144
integer width = 2574
integer height = 2056
string dataobject = "dw_gtelar028a"
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

