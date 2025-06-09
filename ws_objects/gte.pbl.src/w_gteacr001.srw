$PBExportHeader$w_gteacr001.srw
forward
global type w_gteacr001 from window
end type
type dp_2 from datepicker within w_gteacr001
end type
type dp_1 from datepicker within w_gteacr001
end type
type st_1 from statictext within w_gteacr001
end type
type ddlb_2 from dropdownlistbox within w_gteacr001
end type
type rb_2 from radiobutton within w_gteacr001
end type
type rb_1 from radiobutton within w_gteacr001
end type
type ddlb_1 from dropdownlistbox within w_gteacr001
end type
type cb_2 from commandbutton within w_gteacr001
end type
type cb_1 from commandbutton within w_gteacr001
end type
type st_6 from statictext within w_gteacr001
end type
type st_5 from statictext within w_gteacr001
end type
type st_3 from statictext within w_gteacr001
end type
type em_3 from editmask within w_gteacr001
end type
type gb_1 from groupbox within w_gteacr001
end type
type dw_2 from datawindow within w_gteacr001
end type
type dw_5 from datawindow within w_gteacr001
end type
type dw_3 from datawindow within w_gteacr001
end type
type dw_6 from datawindow within w_gteacr001
end type
type dw_1 from datawindow within w_gteacr001
end type
type dw_4 from datawindow within w_gteacr001
end type
end forward

global type w_gteacr001 from window
integer width = 4201
integer height = 2292
boolean titlebar = true
string title = "(W_gteacr001) Voucher Printing"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dp_2 dp_2
dp_1 dp_1
st_1 st_1
ddlb_2 ddlb_2
rb_2 rb_2
rb_1 rb_1
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
st_6 st_6
st_5 st_5
st_3 st_3
em_3 em_3
gb_1 gb_1
dw_2 dw_2
dw_5 dw_5
dw_3 dw_3
dw_6 dw_6
dw_1 dw_1
dw_4 dw_4
end type
global w_gteacr001 w_gteacr001

type variables
string ls_vou_ty,ls_temp,ls_temp1,ls_vouno, ls_frdt, ls_todt
long ll_user_level
end variables

event ue_option();if ddlb_1.text ='Journal' then 	
	choose case gs_ueoption
		case "PRINT"
				IF gs_garden_snm <> 'SP' and gs_garden_snm <> 'AB' and gs_garden_snm <> 'MR' and gs_garden_snm <> 'LP'  and gs_garden_snm <> 'AD'  and gs_garden_snm <> 'MH'  and gs_garden_snm <> 'DR'  then
					OpenWithParm(w_print,this.dw_1)
				end if
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
elseif ddlb_1.text ='Cash Payment' then 
	choose case gs_ueoption
		case "PRINT"
				IF gs_garden_snm <> 'SP' and gs_garden_snm <> 'AB' and gs_garden_snm <> 'MR' and gs_garden_snm <> 'LP'  and gs_garden_snm <> 'AD'  and gs_garden_snm <> 'MH'  and gs_garden_snm <> 'DR' then
					OpenWithParm(w_print,this.dw_2)
				end if
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
elseif ddlb_1.text ='Cash Receipt' then 	
	choose case gs_ueoption
		case "PRINT"
				IF gs_garden_snm <> 'SP' and gs_garden_snm <> 'AB' and gs_garden_snm <> 'MR' and gs_garden_snm <> 'LP'  and gs_garden_snm <> 'AD'  and gs_garden_snm <> 'MH'  and gs_garden_snm <> 'DR' then
					OpenWithParm(w_print,this.dw_3)
				end if
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
elseif ddlb_1.text ='Bank Payment' then 
	choose case gs_ueoption
		case "PRINT"
				IF gs_garden_snm <> 'SP' and gs_garden_snm <> 'AB' and gs_garden_snm <> 'MR' and gs_garden_snm <> 'LP'  and gs_garden_snm <> 'AD'  and gs_garden_snm <> 'MH'  and gs_garden_snm <> 'DR' then
					OpenWithParm(w_print,this.dw_4)
				end if
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
elseif ddlb_1.text ='Bank Receipt' then 
	choose case gs_ueoption
		case "PRINT"
				IF gs_garden_snm <> 'SP' and gs_garden_snm <> 'AB' and gs_garden_snm <> 'MR' and gs_garden_snm <> 'LP'  and gs_garden_snm <> 'AD'  and gs_garden_snm <> 'MH'  and gs_garden_snm <> 'DR'  then
					OpenWithParm(w_print,this.dw_5)
				end if
		case "PRINTPREVIEW"
				this.dw_5.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_5.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_5)
			SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_5.saveas()
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_5.setredraw(false)
				this.dw_5.setfilter(gs_filtertext)
				this.dw_5.filter()
				this.dw_5.groupcalc()
				if this.dw_5.rowcount() > 0 then;
					this.dw_5.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_5.setredraw(false)
				this.dw_5.setsort(gs_sorttext)
				this.dw_5.sort()
				this.dw_5.groupcalc()
				if this.dw_5.rowcount() > 0 then;
					this.dw_5.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose
elseif ddlb_1.text ='Expense' then 
	choose case gs_ueoption
		case "PRINT"
				IF gs_garden_snm <> 'SP' and gs_garden_snm <> 'AB' and gs_garden_snm <> 'MR' and gs_garden_snm <> 'LP'  and gs_garden_snm <> 'AD'  and gs_garden_snm <> 'MH'  and gs_garden_snm <> 'DR'  then
					OpenWithParm(w_print,this.dw_6)
				end if
		case "PRINTPREVIEW"
				this.dw_6.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_6.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_6)
			SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_6.saveas()
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_6.setredraw(false)
				this.dw_6.setfilter(gs_filtertext)
				this.dw_6.filter()
				this.dw_6.groupcalc()
				if this.dw_6.rowcount() > 0 then;
					this.dw_6.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_6.setredraw(false)
				this.dw_6.setsort(gs_sorttext)
				this.dw_6.sort()
				this.dw_6.groupcalc()
				if this.dw_6.rowcount() > 0 then;
					this.dw_6.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose	
end if;	
end event

on w_gteacr001.create
this.dp_2=create dp_2
this.dp_1=create dp_1
this.st_1=create st_1
this.ddlb_2=create ddlb_2
this.rb_2=create rb_2
this.rb_1=create rb_1
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_6=create st_6
this.st_5=create st_5
this.st_3=create st_3
this.em_3=create em_3
this.gb_1=create gb_1
this.dw_2=create dw_2
this.dw_5=create dw_5
this.dw_3=create dw_3
this.dw_6=create dw_6
this.dw_1=create dw_1
this.dw_4=create dw_4
this.Control[]={this.dp_2,&
this.dp_1,&
this.st_1,&
this.ddlb_2,&
this.rb_2,&
this.rb_1,&
this.ddlb_1,&
this.cb_2,&
this.cb_1,&
this.st_6,&
this.st_5,&
this.st_3,&
this.em_3,&
this.gb_1,&
this.dw_2,&
this.dw_5,&
this.dw_3,&
this.dw_6,&
this.dw_1,&
this.dw_4}
end on

on w_gteacr001.destroy
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.ddlb_2)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.em_3)
destroy(this.gb_1)
destroy(this.dw_2)
destroy(this.dw_5)
destroy(this.dw_3)
destroy(this.dw_6)
destroy(this.dw_1)
destroy(this.dw_4)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_3.modify("t_co.text = '"+gs_co_name+"'")
dw_3.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_4.modify("t_co.text = '"+gs_co_name+"'")
dw_4.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_5.modify("t_co.text = '"+gs_co_name+"'")
dw_5.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

this.tag = Message.StringParm
ll_user_level = long(this.tag)

dw_1.settransobject( sqlca);
dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))

if len(gs_vou_no) > 0 then
	ddlb_2.text = gs_vou_no
	choose case gs_opt
	case 'CRV'
		ddlb_1.text ='Cash Receipt'
	case 'CPV'
		ddlb_1.text ='Cash Payment'
	case 'BRV'
		ddlb_1.text ='Bank Receipt'
	case 'BPV'
		ddlb_1.text ='Bank Payment'
	case 'JV'
		ddlb_1.text ='Journal' 
	case 'EXPV'	
		ddlb_1.text ='Expense'
	end choose
	rb_2.checked=true
	cb_1.postevent(clicked!)
end if
end event

event close;setnull(gs_vou_no)
end event

type dp_2 from datepicker within w_gteacr001
integer x = 1746
integer y = 40
integer width = 366
integer height = 88
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-06-04"), Time("14:29:01.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gteacr001
integer x = 1285
integer y = 40
integer width = 366
integer height = 88
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-06-04"), Time("14:29:01.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gteacr001
integer x = 1659
integer y = 52
integer width = 69
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To"
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_gteacr001
integer x = 2912
integer y = 32
integer width = 677
integer height = 744
integer taborder = 60
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

type rb_2 from radiobutton within w_gteacr001
integer x = 2309
integer y = 44
integer width = 283
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Selective"
end type

event clicked;if ddlb_1.text ='Journal' then 
	ls_vou_ty='JV'
elseif ddlb_1.text ='Expense' then 
	ls_vou_ty='EXPV'		
elseif ddlb_1.text ='Cash Payment' then 
	ls_vou_ty='CPV'
elseif ddlb_1.text ='Cash Receipt' then 
	ls_vou_ty='CRV'
elseif ddlb_1.text ='Bank Payment' then 
	ls_vou_ty='BPV'
elseif ddlb_1.text ='Bank Receipt' then 
	ls_vou_ty='BRV'
else
	messagebox('Error :','Please Select a valid Voucher Type')
end if

ddlb_2.enabled  = True
ddlb_2.reset()

if isnull(dp_1.text) or isnull(dp_2.text) or dp_1.text='00/00/0000' or dp_2.text = '00/00/0000' then
	messagebox('Warning','Please Enter From And To Date')
	return 
end if

if Date(dp_1.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','From Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(dp_2.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','To Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(dp_1.text) > Date(dp_2.text) then
	messagebox('Alert!','From Date Should Be <= Than To Date !!!')
	return 1
end if
ls_frdt = dp_1.text
ls_todt = dp_2.text
//ls_temp =  (left(em_6.text,4)+right(em_6.text,2))
 
setpointer(hourglass!)
dw_1.settransobject(sqlca)

declare c1 cursor for
select distinct VH_VOU_NO 
from  fb_vou_head
where VH_VOU_DATE between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') and VH_VOU_TYPE=:ls_vou_ty
order by 1 asc;

open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_vouno;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(string(ls_vouno))
		fetch c1 into :ls_vouno;
	loop
	close c1;
end if

setpointer(arrow!)
end event

type rb_1 from radiobutton within w_gteacr001
integer x = 2139
integer y = 44
integer width = 183
integer height = 76
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "All"
boolean checked = true
end type

event clicked;ddlb_2.enabled  = False

end event

type ddlb_1 from dropdownlistbox within w_gteacr001
integer x = 261
integer y = 36
integer width = 699
integer height = 600
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean vscrollbar = true
string item[] = {"Journal","Cash Payment","Cash Receipt","Bank Payment","Bank Receipt","Expense"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if ddlb_1.text ='Journal' then 
	ls_vou_ty='JV'
elseif ddlb_1.text ='Expense' then 
	ls_vou_ty='EXPV'	
elseif ddlb_1.text ='Cash Payment' then 
	ls_vou_ty='CPV'
elseif ddlb_1.text ='Cash Receipt' then 
	ls_vou_ty='CRV'
elseif ddlb_1.text ='Bank Payment' then 
	ls_vou_ty='BPV'
elseif ddlb_1.text ='Bank Receipt' then 
	ls_vou_ty='BRV'
else
	messagebox('Error :','Please Select a valid Voucher Type')
end if

setnull(ls_temp)

//em_5.text = ls_temp
end event

type cb_2 from commandbutton within w_gteacr001
integer x = 3863
integer y = 28
integer width = 265
integer height = 100
integer taborder = 80
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

type cb_1 from commandbutton within w_gteacr001
integer x = 3602
integer y = 28
integer width = 265
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;if ddlb_1.text ='Journal' then 
	ls_vou_ty='JV'
elseif ddlb_1.text ='Expense' then 
	ls_vou_ty='EXPV'	
elseif ddlb_1.text ='Cash Payment' then 
	ls_vou_ty='CPV'
elseif ddlb_1.text ='Cash Receipt' then 
	ls_vou_ty='CRV'
elseif ddlb_1.text ='Bank Payment' then 
	ls_vou_ty='BPV'
elseif ddlb_1.text ='Bank Receipt' then 
	ls_vou_ty='BRV'
else
	messagebox('Error :','Please Select a valid Voucher Type')
end if

if rb_1.checked then	
	if isnull(dp_1.text) or isnull(dp_2.text) or dp_1.text='00/00/0000' or dp_2.text = '00/00/0000' then
		messagebox('Warning','Please Enter From And To Date')
		return 
	end if
	
	if Date(dp_1.text) > date(string(today(),'dd/mm/yyyy'))  then
		messagebox('Alert!','From Date Should Be <= Current Date  !!!')
		return 1
	end if
	
	if Date(dp_2.text) > date(string(today(),'dd/mm/yyyy'))  then
		messagebox('Alert!','To Date Should Be <= Current Date  !!!')
		return 1
	end if
	
	if Date(dp_1.text) > Date(dp_2.text) then
		messagebox('Alert!','From Date Should Be <= Than To Date !!!')
		return 1
	end if
	
	ls_frdt = dp_1.text
	ls_todt = dp_2.text
	
	  if ls_vou_ty = 'JV' then
		dw_2.hide();	dw_3.hide();	dw_4.hide();	dw_5.hide();dw_6.hide();
		dw_1.show()
		dw_1.settransobject(sqlca)
		dw_1.retrieve('A',ddlb_2.text,ls_frdt,ls_todt)	
	elseif ls_vou_ty = 'EXPV' then
		dw_2.hide();	dw_3.hide();	dw_4.hide();	dw_5.hide();dw_1.hide();
		dw_6.show()
		dw_6.settransobject(sqlca)
		dw_6.retrieve('A',ddlb_2.text,ls_frdt,ls_todt)		
	elseif ls_vou_ty='CPV' then
		dw_1.hide();	dw_3.hide();	dw_4.hide();	dw_5.hide();dw_6.hide();
		dw_2.show()
		dw_2.settransobject(sqlca)
		dw_2.retrieve('A',ddlb_2.text,ls_frdt,ls_todt)	
	elseif ls_vou_ty='CRV' then
		dw_1.hide();	dw_2.hide();	dw_4.hide();	dw_5.hide();dw_6.hide();
		dw_3.show()
		dw_3.settransobject(sqlca)
		dw_3.retrieve('A',ddlb_2.text,ls_frdt,ls_todt)	
	elseif ls_vou_ty='BPV' then
		dw_1.hide();	dw_2.hide();	dw_3.hide();	dw_5.hide();dw_6.hide();
		dw_4.show()
		dw_4.settransobject(sqlca)
		dw_4.retrieve('A',ddlb_2.text,ls_frdt,ls_todt)	
	elseif ls_vou_ty='BRV' then
		dw_1.hide();	dw_2.hide();	dw_3.hide();	dw_4.hide();dw_6.hide();
		dw_5.show()
		dw_5.settransobject(sqlca)
		dw_5.retrieve('A',ddlb_2.text,ls_frdt,ls_todt)	
	end if
elseif rb_2.checked then
	
	if isnull(ddlb_2.text)  or len(ddlb_2.text) =0 then 
		messagebox('Error At Voucher No','Please Enter a Valid Voucher Number')
		return 1
     end if
	  
     ls_temp = trim(ddlb_2.text)	
	
	select distinct 'x' into :ls_temp1 from fb_vou_head where VH_VOU_NO=:ls_temp;	
		
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During Getting voucher No  : '+sqlca.sqlerrtext)
	      rollback using sqlca;
	      return 1
	elseif sqlca.sqlcode = 100 then 
	     messagebox('Error','Voucher Number Not Available In Voucher Master  : '+sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if;	
	
	if ls_vou_ty='JV' then
		dw_2.hide();	dw_3.hide();	dw_4.hide();	dw_5.hide();dw_6.hide();
		dw_1.show()
		dw_1.settransobject(sqlca)
		dw_1.retrieve('B',ddlb_2.text,ls_frdt,ls_todt)
	elseif ls_vou_ty='EXPV' then
		dw_2.hide();	dw_3.hide();	dw_4.hide();	dw_5.hide();dw_1.hide();
		dw_6.show()
		dw_6.settransobject(sqlca)
		dw_6.retrieve('B',ddlb_2.text,ls_frdt,ls_todt)	
	elseif ls_vou_ty='CPV' then
		dw_1.hide();	dw_3.hide();	dw_4.hide();	dw_5.hide() ;dw_6.hide();
		dw_2.show()
		dw_2.settransobject(sqlca)
		dw_2.retrieve('B',ddlb_2.text,ls_frdt,ls_todt)
	elseif ls_vou_ty='CRV' then
		dw_1.hide();	dw_2.hide();	dw_4.hide();	dw_5.hide();dw_6.hide();
		dw_3.show()
		dw_3.settransobject(sqlca)
		dw_3.retrieve('B',ddlb_2.text,ls_frdt,ls_todt)
	elseif ls_vou_ty='BPV' then
		dw_1.hide();	dw_2.hide();	dw_2.hide();	dw_5.hide();dw_6.hide();
		dw_4.show()
		dw_4.settransobject(sqlca)
		dw_4.retrieve('B',ddlb_2.text,ls_frdt,ls_todt)
	elseif ls_vou_ty='BRV' then
		dw_1.hide();	dw_2.hide();	dw_3.hide();	dw_4.hide() ;dw_6.hide();
		dw_5.show()
		dw_5.settransobject(sqlca)
		dw_5.retrieve('B',ddlb_2.text,ls_frdt,ls_todt)
	end if		
end if
end event

type st_6 from statictext within w_gteacr001
integer x = 983
integer y = 52
integer width = 306
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Period From"
boolean focusrectangle = false
end type

type st_5 from statictext within w_gteacr001
integer x = 2610
integer y = 48
integer width = 306
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Voucher No "
boolean focusrectangle = false
end type

type st_3 from statictext within w_gteacr001
integer x = 37
integer y = 52
integer width = 224
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Voucher "
boolean focusrectangle = false
end type

type em_3 from editmask within w_gteacr001
boolean visible = false
integer x = 791
integer y = 44
integer width = 69
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean enabled = false
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "#"
end type

type gb_1 from groupbox within w_gteacr001
integer x = 2121
integer width = 489
integer height = 140
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_2 from datawindow within w_gteacr001
integer x = 23
integer y = 144
integer width = 4105
integer height = 2004
string dataobject = "dw_gteacr001a"
boolean maxbox = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_5 from datawindow within w_gteacr001
integer x = 23
integer y = 144
integer width = 4105
integer height = 2004
string dataobject = "dw_gteacr001d"
boolean maxbox = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_gteacr001
integer x = 23
integer y = 144
integer width = 4105
integer height = 2004
string dataobject = "dw_gteacr001b"
boolean maxbox = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_6 from datawindow within w_gteacr001
integer x = 23
integer y = 144
integer width = 4105
integer height = 2004
integer taborder = 50
string dataobject = "dw_gteacr001e"
boolean maxbox = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_gteacr001
integer x = 23
integer y = 144
integer width = 4105
integer height = 2004
string dataobject = "dw_gteacr001"
boolean maxbox = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within w_gteacr001
integer x = 23
integer y = 144
integer width = 4105
integer height = 2004
string dataobject = "dw_gteacr001c"
boolean maxbox = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

