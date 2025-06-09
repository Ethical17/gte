$PBExportHeader$w_gtelar017a.srw
forward
global type w_gtelar017a from window
end type
type rb_4 from radiobutton within w_gtelar017a
end type
type st_4 from statictext within w_gtelar017a
end type
type ddlb_3 from dropdownlistbox within w_gtelar017a
end type
type rb_3 from radiobutton within w_gtelar017a
end type
type rb_2 from radiobutton within w_gtelar017a
end type
type rb_1 from radiobutton within w_gtelar017a
end type
type st_1 from statictext within w_gtelar017a
end type
type ddlb_4 from dropdownlistbox within w_gtelar017a
end type
type ddlb_1 from dropdownlistbox within w_gtelar017a
end type
type cb_2 from commandbutton within w_gtelar017a
end type
type st_2 from statictext within w_gtelar017a
end type
type st_3 from statictext within w_gtelar017a
end type
type cb_1 from commandbutton within w_gtelar017a
end type
type gb_1 from groupbox within w_gtelar017a
end type
type ddlb_2 from dropdownlistbox within w_gtelar017a
end type
type dw_4 from datawindow within w_gtelar017a
end type
type dw_1 from datawindow within w_gtelar017a
end type
type dw_2 from datawindow within w_gtelar017a
end type
type dw_3 from datawindow within w_gtelar017a
end type
end forward

global type w_gtelar017a from window
integer width = 4667
integer height = 2908
boolean titlebar = true
string title = "(Gtelar017) - Labour Bonus"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
rb_4 rb_4
st_4 st_4
ddlb_3 ddlb_3
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
st_1 st_1
ddlb_4 ddlb_4
ddlb_1 ddlb_1
cb_2 cb_2
st_2 st_2
st_3 st_3
cb_1 cb_1
gb_1 gb_1
ddlb_2 ddlb_2
dw_4 dw_4
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
end type
global w_gtelar017a w_gtelar017a

type variables
long ll_pbno
string ls_type, ls_yrmn,ls_division,ls_divisionnm
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
elseif rb_2.checked then
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
elseif rb_3.checked then
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_3)
		case "PRINTPREVIEW"
				this.dw_3.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_3.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_3)
			SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_3.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_3.setredraw(false)
				this.dw_3.setfilter(gs_filtertext)
				this.dw_3.filter()
				this.dw_3.groupcalc()
				if this.dw_3.rowcount() > 0 then;
					this.dw_3.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_3.setredraw(false)
				this.dw_3.setsort(gs_sorttext)
				this.dw_3.sort()
				this.dw_3.groupcalc()
				if this.dw_3.rowcount() > 0 then;
					this.dw_3.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose
elseif rb_4.checked then
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_4)
		case "PRINTPREVIEW"
				this.dw_4.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_4.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_4)
			SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_4.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_4.setredraw(false)
				this.dw_4.setfilter(gs_filtertext)
				this.dw_4.filter()
				this.dw_4.groupcalc()
				if this.dw_4.rowcount() > 0 then;
					this.dw_4.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_4.setredraw(false)
				this.dw_4.setsort(gs_sorttext)
				this.dw_4.sort()
				this.dw_4.groupcalc()
				if this.dw_4.rowcount() > 0 then;
					this.dw_4.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose	
end if
end event

event open;//dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_3.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_4.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)

dw_3.hide()
dw_2.hide()
dw_1.show()
setpointer(hourglass!)

ddlb_1.reset()

declare c1 cursor for
select distinct to_char(LBP_STARTDATE,'YYYY') from FB_LABBONUSPERIOD order by 1 desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_yrmn;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_yrmn)
		fetch c1 into:ls_yrmn;
	loop
	close c1;
end if

ddlb_3.reset()
ddlb_3.additem('ALL')

declare c2 cursor for
select FIELD_NAME||' ('||FIELD_ID||')' from FB_FIELD where nvl(FIELD_ACTIVE_IND,'Y') = 'Y' order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_division;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(ls_division)
		fetch c2 into:ls_division;
	loop
	close c2;
end if

ddlb_3.text = 'ALL'
setpointer(arrow!)

ddlb_4.reset()
ddlb_4.additem('ALL')

declare c3 cursor for
select distinct b.ls_id from FB_EMPLOYEE a,FB_LABOURSHEET b 
where a.ls_id = b.ls_id and b.ls_id is not null order by 1;

open c3;

IF sqlca.sqlcode = 0 THEN 
	fetch c3 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_4.additem(string(ll_pbno))
		fetch c3 into:ll_pbno;
	loop
	close c3;
end if

ddlb_4.text = 'ALL'
setpointer(arrow!)
end event

on w_gtelar017a.create
this.rb_4=create rb_4
this.st_4=create st_4
this.ddlb_3=create ddlb_3
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_1=create st_1
this.ddlb_4=create ddlb_4
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.st_3=create st_3
this.cb_1=create cb_1
this.gb_1=create gb_1
this.ddlb_2=create ddlb_2
this.dw_4=create dw_4
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.Control[]={this.rb_4,&
this.st_4,&
this.ddlb_3,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.st_1,&
this.ddlb_4,&
this.ddlb_1,&
this.cb_2,&
this.st_2,&
this.st_3,&
this.cb_1,&
this.gb_1,&
this.ddlb_2,&
this.dw_4,&
this.dw_1,&
this.dw_2,&
this.dw_3}
end on

on w_gtelar017a.destroy
destroy(this.rb_4)
destroy(this.st_4)
destroy(this.ddlb_3)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_1)
destroy(this.ddlb_4)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.ddlb_2)
destroy(this.dw_4)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
end on

type rb_4 from radiobutton within w_gtelar017a
integer x = 3735
integer y = 132
integer width = 265
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "15 + 5"
end type

event clicked;dw_2.hide()
dw_3.hide()
dw_1.hide()
dw_4.show()
end event

type st_4 from statictext within w_gtelar017a
integer x = 2149
integer y = 40
integer width = 251
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Division"
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within w_gtelar017a
integer x = 2382
integer y = 28
integer width = 1166
integer height = 636
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
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

event selectionchanged;
ls_type = left(ddlb_2.text,2)
ls_division = left(right(ddlb_3.text,6),5)
setpointer(hourglass!)

ddlb_4.reset()
ddlb_4.additem('ALL')

declare c2 cursor for
select distinct b.ls_id from FB_EMPLOYEE a,FB_LABOURSHEET b 
where a.ls_id = b.ls_id and emp_type = decode(nvl(:ls_type,'AL'),'AL',emp_type,:ls_type) and 
      	 a.FIELD_ID = decode(nvl(:ls_division,'ALL'),'ALL',a.FIELD_ID,:ls_division) and b.ls_id is not null order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_4.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_4.text = 'ALL'
setpointer(arrow!)
end event

type rb_3 from radiobutton within w_gtelar017a
integer x = 3351
integer y = 132
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
string text = "CheckList"
end type

event clicked;dw_1.hide()
dw_2.hide()
dw_3.show()
dw_4.hide()
end event

type rb_2 from radiobutton within w_gtelar017a
integer x = 3022
integer y = 136
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
dw_3.hide()
dw_2.show()
dw_4.hide()
end event

type rb_1 from radiobutton within w_gtelar017a
integer x = 2743
integer y = 136
integer width = 279
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

event clicked;dw_3.hide()
dw_2.hide()
dw_1.show()
dw_4.hide()
end event

type st_1 from statictext within w_gtelar017a
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

type ddlb_4 from dropdownlistbox within w_gtelar017a
integer x = 3959
integer y = 28
integer width = 297
integer height = 636
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
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

type ddlb_1 from dropdownlistbox within w_gtelar017a
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

type cb_2 from commandbutton within w_gtelar017a
integer x = 4041
integer y = 116
integer width = 265
integer height = 100
integer taborder = 60
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
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)

setpointer(hourglass!)

if isnull(ddlb_1.text) or ddlb_1.text='0000' then
	messagebox('Warning','Please Bonus Year !!!')
	return 
end if
ls_division = left(right(ddlb_3.text,6),5)
if ddlb_3.text = 'ALL' then
	ls_divisionnm = 'ALL'
else
	ls_divisionnm = left(ddlb_3.text,(len(ddlb_3.text) - 7))
end if

if rb_1.checked then
	dw_1.show()
	dw_2.hide()
	dw_3.hide()
	dw_4.hide()
	dw_1.retrieve(ddlb_1.text,left(ddlb_2.text,2),ddlb_4.text,ls_division,ls_divisionnm)
	if dw_1.rowcount() = 0 then
		messagebox('Alert!','No Data Found !!!')
		setpointer(arrow!)
		return 1
	end if
elseif rb_2.checked then
	dw_1.hide()
	dw_2.show()
	dw_3.hide()
	dw_4.hide()
	dw_2.retrieve(ddlb_1.text,left(ddlb_2.text,2),ddlb_4.text,ls_division,ls_divisionnm)
	if dw_2.rowcount() = 0 then
		messagebox('Alert!','No Data Found !!!')
		setpointer(arrow!)
		return 1
	end if
elseif rb_3.checked then
	dw_1.hide()
	dw_2.hide()
	dw_3.show()
	dw_4.hide()
	dw_3.retrieve(ddlb_1.text,left(ddlb_2.text,2),ddlb_4.text,gs_garden_snm,ls_division,ls_divisionnm)
	if dw_3.rowcount() = 0 then
		messagebox('Alert!','No Data Found !!!')
		setpointer(arrow!)
		return 1
	end if
elseif rb_4.checked then
	dw_1.hide()
	dw_2.hide()
	dw_4.show()
	dw_3.hide()
	dw_4.retrieve(ddlb_1.text,left(ddlb_2.text,2),ddlb_4.text,ls_division,ls_divisionnm)
	if dw_4.rowcount() = 0 then
		messagebox('Alert!','No Data Found !!!')
		setpointer(arrow!)
		return 1
	end if	
end if
setpointer(arrow!)

end event

type st_2 from statictext within w_gtelar017a
integer x = 3602
integer y = 40
integer width = 347
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pay Book No."
boolean focusrectangle = false
end type

type st_3 from statictext within w_gtelar017a
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

type cb_1 from commandbutton within w_gtelar017a
integer x = 4302
integer y = 116
integer width = 265
integer height = 100
integer taborder = 90
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

type gb_1 from groupbox within w_gtelar017a
integer x = 2715
integer y = 92
integer width = 1303
integer height = 128
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type ddlb_2 from dropdownlistbox within w_gtelar017a
integer x = 1435
integer y = 28
integer width = 677
integer height = 508
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "ALL"
boolean sorted = false
string item[] = {"AL - ALL","LP - Permanent ","LT - Temporary","LO - Outside"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
//ls_type = left(ddlb_2.text,2)
//setpointer(hourglass!)
//
//ddlb_3.reset()
//ddlb_3.additem('ALL')
//
//declare c2 cursor for
//select distinct b.ls_id from FB_EMPLOYEE a,FB_LABOURSHEET b 
//where a.ls_id = b.ls_id and emp_type = decode(nvl(:ls_type,'AL'),'AL',emp_type,:ls_type) and b.ls_id is not null order by 1;
//
//open c2;
//
//IF sqlca.sqlcode = 0 THEN 
//	fetch c2 into :ll_pbno;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_3.additem(string(ll_pbno))
//		fetch c2 into:ll_pbno;
//	loop
//	close c2;
//end if
//
//ddlb_3.text = 'ALL'
//setpointer(arrow!)
end event

type dw_4 from datawindow within w_gtelar017a
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 232
integer width = 4581
integer height = 2520
integer taborder = 80
string title = "none"
string dataobject = "dw_gtelar017bf_mt"
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

type dw_1 from datawindow within w_gtelar017a
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 232
integer width = 4581
integer height = 2520
string title = "none"
string dataobject = "dw_gtelar017_mt"
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

type dw_2 from datawindow within w_gtelar017a
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 232
integer width = 4576
integer height = 2520
integer taborder = 70
string dataobject = "dw_gtelar017s_mt"
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

type dw_3 from datawindow within w_gtelar017a
integer y = 228
integer width = 3630
integer height = 2524
integer taborder = 80
string dataobject = "dw_gtelar017cl"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

