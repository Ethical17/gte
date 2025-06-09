$PBExportHeader$w_gtelar012.srw
forward
global type w_gtelar012 from window
end type
type ddlb_1 from dropdownlistbox within w_gtelar012
end type
type st_3 from statictext within w_gtelar012
end type
type cb_1 from commandbutton within w_gtelar012
end type
type dp_2 from datepicker within w_gtelar012
end type
type st_2 from statictext within w_gtelar012
end type
type dp_1 from datepicker within w_gtelar012
end type
type st_1 from statictext within w_gtelar012
end type
type cb_2 from commandbutton within w_gtelar012
end type
type dw_1 from datawindow within w_gtelar012
end type
end forward

global type w_gtelar012 from window
integer width = 4567
integer height = 2276
boolean titlebar = true
string title = "(Gtelar012) - Deduction List"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_1 ddlb_1
st_3 st_3
cb_1 cb_1
dp_2 dp_2
st_2 st_2
dp_1 dp_1
st_1 st_1
cb_2 cb_2
dw_1 dw_1
end type
global w_gtelar012 w_gtelar012

type variables
n_cst_powerfilter iu_powerfilter
string ls_dt,ls_stdt,ls_enddt
datetime ld_dt
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

on w_gtelar012.create
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.cb_1=create cb_1
this.dp_2=create dp_2
this.st_2=create st_2
this.dp_1=create dp_1
this.st_1=create st_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.ddlb_1,&
this.st_3,&
this.cb_1,&
this.dp_2,&
this.st_2,&
this.dp_1,&
this.st_1,&
this.cb_2,&
this.dw_1}
end on

on w_gtelar012.destroy
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.dp_2)
destroy(this.st_2)
destroy(this.dp_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

//dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))

setpointer(hourglass!)
declare c1 cursor for
select distinct LWW_ID||' ('||to_char(LWW_STARTDATE,'dd/mm/yyyy')||'-'||to_char(LWW_ENDDATE,'dd/mm/yyyy')||')',LWW_STARTDATE
  from fb_LABOURWAGESWEEK
order by LWW_STARTDATE desc;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_dt,:ld_dt;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_dt)
		fetch c1 into:ls_dt,:ld_dt;
	loop
	close c1;
end if
end event

type ddlb_1 from dropdownlistbox within w_gtelar012
integer x = 782
integer y = 12
integer width = 1152
integer height = 608
integer taborder = 30
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

event selectionchanged;//ls_dt = left(ddlb_1.text,10)
//ddlb_2.reset()
//ddlb_2.additem('ALL')
//
//declare c2 cursor for
//select distinct LS_ID from FB_LABOURWEEKLYWAGES a,FB_LABOURWAGESWEEK b 
//where a.LWW_ID = b.LWW_ID and trunc(b.LWW_STARTDATE) = to_date(:ls_dt,'dd/mm/yyyy') order by 1;
//
//open c2;
//
//IF sqlca.sqlcode = 0 THEN 
//	fetch c2 into :ll_pbno;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_2.additem(string(ll_pbno))
//		fetch c2 into:ll_pbno;
//	loop
//	close c2;
//end if
//
//ddlb_2.text = 'ALL'
end event

type st_3 from statictext within w_gtelar012
integer x = 18
integer y = 24
integer width = 754
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "LWW ID (Start && End Date) : "
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelar012
integer x = 1961
integer y = 4
integer width = 265
integer height = 100
integer taborder = 30
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
//
//if isnull(dp_1.text) or dp_1.text='00/00/0000' then
//	messagebox('Warning','Please Enter The "From" Date !!!')
//	return 
//end if
//
//if isnull(dp_2.text) or dp_2.text='00/00/0000' then
//	messagebox('Warning','Please Enter The "To" Date !!!')
//	return 
//end if
//
//if date(dp_1.text) > date(dp_2.text)  then
//	messagebox('Warning ','The From Date Should be <= TO Date , Please check ...!')
//	return 1
//end if
//
//string ls_frdt,ls_todt,ls_ysdt
//ls_frdt = dp_1.text 
//ls_todt = dp_2.text
//
//
//select to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd'),'dd/mm/yyyy')
//  into :ls_ysdt from dual;
//
//if sqlca.sqlcode =-1 then
//	messagebox('SQL Error During Date Select',sqlca.sqlerrtext)
//	return 1
//end if

if isnull(ddlb_1.text)  then
	messagebox('Warning','Please Enter Week Start Date !!!')
	return 
end if

string ls_lww_id

ls_lww_id = left(ddlb_1.text,13)
ls_stdt = mid(ddlb_1.text,16,10)
ls_enddt = left(right(ddlb_1.text,11),10)

dw_1.retrieve(ls_lww_id,ls_stdt,ls_enddt)

setpointer(arrow!)

end event

type dp_2 from datepicker within w_gtelar012
boolean visible = false
integer x = 3438
integer width = 389
integer height = 100
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2012-06-18"), Time("11:27:33.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gtelar012
boolean visible = false
integer x = 3291
integer y = 16
integer width = 137
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To : "
alignment alignment = center!
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gtelar012
boolean visible = false
integer x = 2885
integer width = 389
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2012-06-18"), Time("11:27:33.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_1 from statictext within w_gtelar012
boolean visible = false
integer x = 2505
integer y = 16
integer width = 379
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Period From : "
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gtelar012
integer x = 2231
integer y = 4
integer width = 265
integer height = 100
integer taborder = 40
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

type dw_1 from datawindow within w_gtelar012
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 112
integer width = 4517
integer height = 2056
string dataobject = "dw_gtelar012"
boolean hscrollbar = true
boolean vscrollbar = true
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

