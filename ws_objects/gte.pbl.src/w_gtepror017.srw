$PBExportHeader$w_gtepror017.srw
forward
global type w_gtepror017 from window
end type
type cb_2 from commandbutton within w_gtepror017
end type
type st_1 from statictext within w_gtepror017
end type
type dp_1 from datepicker within w_gtepror017
end type
type st_2 from statictext within w_gtepror017
end type
type dp_2 from datepicker within w_gtepror017
end type
type cb_3 from commandbutton within w_gtepror017
end type
type cb_1 from commandbutton within w_gtepror017
end type
type dw_1 from datawindow within w_gtepror017
end type
end forward

global type w_gtepror017 from window
integer width = 4805
integer height = 2284
boolean titlebar = true
string title = "(Gtepror017) Fine Bought Leaf %"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_2 cb_2
st_1 st_1
dp_1 dp_1
st_2 st_2
dp_2 dp_2
cb_3 cb_3
cb_1 cb_1
dw_1 dw_1
end type
global w_gtepror017 w_gtepror017

type variables
n_cst_powerfilter iu_powerfilter 
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (datetime fd_date)
end prototypes

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

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_1.getitemdatetime(fl_row,'la_date')) or &
		 ((isnull(dw_1.getitemnumber(fl_row,'la_owllnb1')) or dw_1.getitemnumber(fl_row,'la_owllnb1')=0) and &
		  (isnull(dw_1.getitemnumber(fl_row,'la_owllnb2')) or dw_1.getitemnumber(fl_row,'la_owllnb2')=0) and &
		  (isnull(dw_1.getitemnumber(fl_row,'la_owllnb3')) or dw_1.getitemnumber(fl_row,'la_owllnb3')=0) and &
		  (isnull(dw_1.getitemnumber(fl_row,'la_owllnb4')) or dw_1.getitemnumber(fl_row,'la_owllnb4')=0)) or &
		  ((isnull(dw_1.getitemnumber(fl_row,'la_oullnb1')) or dw_1.getitemnumber(fl_row,'la_oullnb1')=0) and &
		  (isnull(dw_1.getitemnumber(fl_row,'la_oullnb2')) or dw_1.getitemnumber(fl_row,'la_oullnb2')=0) and &
		  (isnull(dw_1.getitemnumber(fl_row,'la_oullnb3')) or dw_1.getitemnumber(fl_row,'la_oullnb3')=0) and &
		  (isnull(dw_1.getitemnumber(fl_row,'la_oullnb4')) or dw_1.getitemnumber(fl_row,'la_oullnb4')=0)) or &
		  isnull(dw_1.getitemnumber(fl_row,'la_owlperfinlf')) or dw_1.getitemnumber(fl_row,'la_owlperfinlf')=0 or &
		  isnull(dw_1.getitemnumber(fl_row,'la_owlpercoalf')) or dw_1.getitemnumber(fl_row,'la_owlpercoalf')=0 or &
		  isnull(dw_1.getitemnumber(fl_row,'la_owlbmcfinper')) or dw_1.getitemnumber(fl_row,'la_owlbmcfinper')=0 or &
		  isnull(dw_1.getitemnumber(fl_row,'la_owlbmccoaper')) or dw_1.getitemnumber(fl_row,'la_owlbmccoaper')=0 or &
		  isnull(dw_1.getitemnumber(fl_row,'la_oulperfinlf')) or dw_1.getitemnumber(fl_row,'la_oulperfinlf')=0 or &
		  isnull(dw_1.getitemnumber(fl_row,'la_oulpercoalf')) or dw_1.getitemnumber(fl_row,'la_oulpercoalf')=0 or &
		  isnull(dw_1.getitemnumber(fl_row,'la_oulbmcfinper')) or dw_1.getitemnumber(fl_row,'la_oulbmcfinper')=0 or &
		  isnull(dw_1.getitemnumber(fl_row,'la_oulbmccoaper')) or dw_1.getitemnumber(fl_row,'la_oulbmccoaper')=0) then
	    messagebox('Warning: One Of The Following Fields Are Blank of Own and Outside Leaf','Sum of Leaf & A Bud (1-4), % Fine Leaf, % Coarse Leaf, Ballometer Count % Fine, Ballometer Count % Coarse, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (datetime fd_date);long fl_row
datetime ld_date1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ld_date1 = dw_1.getitemdatetime(fl_row,'la_date')
		
		if ld_date1 = fd_date then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtepror017.create
this.cb_2=create cb_2
this.st_1=create st_1
this.dp_1=create dp_1
this.st_2=create st_2
this.dp_2=create dp_2
this.cb_3=create cb_3
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.st_1,&
this.dp_1,&
this.st_2,&
this.dp_2,&
this.cb_3,&
this.cb_1,&
this.dw_1}
end on

on w_gtepror017.destroy
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.dp_1)
destroy(this.st_2)
destroy(this.dp_2)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nm+"'")

dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))

end event

type cb_2 from commandbutton within w_gtepror017
boolean visible = false
integer x = 2546
integer y = 8
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Mail"
boolean default = true
end type

event clicked;//if dw_1.rowcount() > 0 then
//	setpointer(hourglass!)
//	//parent.dw_1.saveas("c:\reports\Gtepror010.pdf",pdf!,true)
//	parent.dw_1.saveas("c:\reports\Gtepror010.xls",EXCEL!,true)
//	
//	ls_sender  =  'obl.system@obeetee.com'
//	
//	ls_recipient = 'vishal.gupta@obeetee.com'
//	
//	ls_cc= 'abhishek.baranwal@obeetee.com'
//	
//	ls_bcc = 'prabhat.kumar@obeetee.com'
//	
//	//ls_addattachment = "c:\reports\Gtepror010.pdf"
//	ls_addattachment = "c:\reports\Gtepror010.xls"
//		
//	ls_subject 	 = "Todays Source Wise Fine Leaf Count"
//	
//	ls_message	= "Dear Sir, "+gs_lfcr+gs_lfcr+"Please find enclosed herewith an Source Wise Fine Leaf Count Report. "+gs_lfcr+gs_lfcr
//	ls_message	 = ls_message +gs_lfcr+"Your kind attention is required."+gs_lfcr
//	
//	ls_message	 = ls_message +gs_lfcr+"Administrator"+gs_lfcr
//	
//	ls_message	 = ls_message +gs_lfcr+gs_lfcr+gs_email_signature
//	
//	n_web_mail lnvo_mail
//		
//	lnvo_mail = Create n_web_mail
//	
//	lnvo_mail.of_send_webmail(ls_sender,ls_recipient,ls_cc,ls_subject,ls_message,ls_bcc,ls_addattachment) 
//end if		
//	setpointer(Arrow!)
//	return 1

end event

type st_1 from statictext within w_gtepror017
integer x = 18
integer y = 28
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

type dp_1 from datepicker within w_gtepror017
integer x = 677
integer y = 8
integer width = 370
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2019-10-21"), Time("14:02:35.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gtepror017
integer x = 1056
integer y = 28
integer width = 233
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

type dp_2 from datepicker within w_gtepror017
integer x = 1303
integer y = 8
integer width = 370
integer height = 100
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2019-10-21"), Time("14:02:35.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_3 from commandbutton within w_gtepror017
integer x = 1984
integer y = 12
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
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gtepror017
integer x = 1723
integer y = 12
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

dw_1.retrieve(dp_1.text,dp_2.text)

setpointer(arrow!)
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No data found between the entered dates !!!')
	return 1
end if
end event

type dw_1 from datawindow within w_gtepror017
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 9
integer y = 116
integer width = 4439
integer height = 2056
integer taborder = 20
string dataobject = "dw_gtepror017"
boolean hscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
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

