$PBExportHeader$w_gtelar059.srw
forward
global type w_gtelar059 from window
end type
type st_1 from statictext within w_gtelar059
end type
type ddlb_3 from dropdownlistbox within w_gtelar059
end type
type ddlb_2 from dropdownlistbox within w_gtelar059
end type
type ddlb_1 from dropdownlistbox within w_gtelar059
end type
type cb_2 from commandbutton within w_gtelar059
end type
type st_2 from statictext within w_gtelar059
end type
type st_3 from statictext within w_gtelar059
end type
type cb_1 from commandbutton within w_gtelar059
end type
type dw_1 from datawindow within w_gtelar059
end type
end forward

global type w_gtelar059 from window
integer width = 4667
integer height = 2620
boolean titlebar = true
string title = "(Gtelar059) - Bonus Slip"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
ddlb_3 ddlb_3
ddlb_2 ddlb_2
ddlb_1 ddlb_1
cb_2 cb_2
st_2 st_2
st_3 st_3
cb_1 cb_1
dw_1 dw_1
end type
global w_gtelar059 w_gtelar059

type variables
long ll_pbno
string ls_type, ls_yrmn
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

event open;//dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dw_1.settransobject(sqlca)
setpointer(hourglass!)
//if gs_garden_snm = 'MB' then
//	rb_4.visible = true
//else
//	rb_4.visible = false
//end if

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
select distinct b.ls_id from FB_EMPLOYEE a,FB_LABOURSHEET b 
where a.ls_id = b.ls_id and b.ls_id is not null order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_3.text = 'ALL'
setpointer(arrow!)
end event

on w_gtelar059.create
this.st_1=create st_1
this.ddlb_3=create ddlb_3
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.st_3=create st_3
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.ddlb_3,&
this.ddlb_2,&
this.ddlb_1,&
this.cb_2,&
this.st_2,&
this.st_3,&
this.cb_1,&
this.dw_1}
end on

on w_gtelar059.destroy
destroy(this.st_1)
destroy(this.ddlb_3)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type st_1 from statictext within w_gtelar059
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

type ddlb_3 from dropdownlistbox within w_gtelar059
integer x = 2491
integer y = 28
integer width = 297
integer height = 636
integer taborder = 30
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

type ddlb_2 from dropdownlistbox within w_gtelar059
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
string item[] = {"AL - ALL","LP - Permanent ","LT - Temporary","LO - Outside"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
ls_type = left(ddlb_2.text,2)
setpointer(hourglass!)

ddlb_3.reset()
ddlb_3.additem('ALL')

declare c2 cursor for
select distinct b.ls_id from FB_EMPLOYEE a,FB_LABOURSHEET b 
where a.ls_id = b.ls_id and emp_type = decode(nvl(:ls_type,'AL'),'AL',emp_type,:ls_type) and b.ls_id is not null order by 1;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ll_pbno;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(string(ll_pbno))
		fetch c2 into:ll_pbno;
	loop
	close c2;
end if

ddlb_3.text = 'ALL'
setpointer(arrow!)
end event

type ddlb_1 from dropdownlistbox within w_gtelar059
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

type cb_2 from commandbutton within w_gtelar059
integer x = 2885
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

	dw_1.retrieve(ddlb_1.text,left(ddlb_2.text,2),ddlb_3.text,gs_garden_snm)
	if dw_1.rowcount() = 0 then
		messagebox('Alert!','No Data Found !!!')
		setpointer(arrow!)
		return 1
	end if	
setpointer(arrow!)

end event

type st_2 from statictext within w_gtelar059
integer x = 2135
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

type st_3 from statictext within w_gtelar059
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

type cb_1 from commandbutton within w_gtelar059
integer x = 3145
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

type dw_1 from datawindow within w_gtelar059
integer y = 132
integer width = 4521
integer height = 2344
integer taborder = 50
string dataobject = "dw_gtelar059"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

