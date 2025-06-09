$PBExportHeader$w_gtelar076.srw
forward
global type w_gtelar076 from window
end type
type rb_2 from radiobutton within w_gtelar076
end type
type rb_1 from radiobutton within w_gtelar076
end type
type cb_3 from commandbutton within w_gtelar076
end type
type em_1 from editmask within w_gtelar076
end type
type dp_1 from datepicker within w_gtelar076
end type
type st_3 from statictext within w_gtelar076
end type
type st_1 from statictext within w_gtelar076
end type
type cb_1 from commandbutton within w_gtelar076
end type
type cb_2 from commandbutton within w_gtelar076
end type
type dw_1 from datawindow within w_gtelar076
end type
type gb_1 from groupbox within w_gtelar076
end type
end forward

global type w_gtelar076 from window
integer width = 3767
integer height = 2288
boolean titlebar = true
string title = "(Gtelar076) - Labour Plucking Performance"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
rb_2 rb_2
rb_1 rb_1
cb_3 cb_3
em_1 em_1
dp_1 dp_1
st_3 st_3
st_1 st_1
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
gb_1 gb_1
end type
global w_gtelar076 w_gtelar076

type variables
n_cst_powerfilter iu_powerfilter

string ls_sender,ls_mail,ls_recipient,ls_cc,ls_bcc,ls_subject,ls_ack_ind,ls_message,ls_addattachment,ls_dt, ls_addattachment2, ls_body_text, ls_signature
boolean lb_flag
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

on w_gtelar076.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_3=create cb_3
this.em_1=create em_1
this.dp_1=create dp_1
this.st_3=create st_3
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.rb_2,&
this.rb_1,&
this.cb_3,&
this.em_1,&
this.dp_1,&
this.st_3,&
this.st_1,&
this.cb_1,&
this.cb_2,&
this.dw_1,&
this.gb_1}
end on

on w_gtelar076.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_3)
destroy(this.em_1)
destroy(this.dp_1)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;gs_co_name = "Luxmi Tea Co. Pvt. Ltd."
dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

dp_1.value = datetime(string(today(),'dd/mm/yyyy'))
em_1.text = string(60.00)





end event

type rb_2 from radiobutton within w_gtelar076
integer x = 1902
integer y = 48
integer width = 306
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Squad"
end type

type rb_1 from radiobutton within w_gtelar076
integer x = 1577
integer y = 48
integer width = 306
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Division"
boolean checked = true
end type

type cb_3 from commandbutton within w_gtelar076
integer x = 2971
integer y = 40
integer width = 338
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Send Mail"
boolean default = true
end type

event clicked;integer li_temp, li_temp1
string ls_file1, ls_file2

dw_1.settransobject(sqlca)

setpointer(hourglass!)

if isnull(dp_1.text) or dp_1.text='00/00/0000' then 
	messagebox('Warning','Please Enter From And To Date')
	return 
end if

if Date(dp_1.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','From Date Should Be <= Current Date  !!!')
	return 1
end if

//	dw_1.dataobject='dw_gtelar076'
//	dw_1.settransobject(sqlca)
//
//	dw_1.retrieve(dp_1.text,double(em_1.text),gs_garden_nm )
//	
//	//setpointer(arrow!)
//	if dw_1.rowcount() = 0 then
//		messagebox('Alert!','No data found between the entered dates !!!')
//		return 1
//	end if
//	
//	ls_file1 = "c:\temp\"+gs_garden_snm+"_PluckerSummary"+string(today(),"_ddmmyy")+".pdf"
//	li_temp = dw_1.saveas(ls_file1,pdf!,true)
//	
//	if(li_temp=-1) then 
//		messagebox('Error','Error occured while saving PDF')
//		return 1
//	end if	
	
	dw_1.dataobject='dw_gtelar076_pay'
	dw_1.settransobject(sqlca)

	dw_1.retrieve(dp_1.text,double(em_1.text),gs_garden_nm )
	
	//setpointer(arrow!)
	if dw_1.rowcount() = 0 then
		messagebox('Alert!','No data found between the entered dates !!!')
		return 1
	end if
	
	ls_file1 = "c:\temp\"+gs_garden_snm+"_PluckerSummarySquad"+string(today(),"_ddmmyy")+".pdf"
	li_temp1 = dw_1.saveas(ls_file1,pdf!,true)
	
	if(li_temp1=-1) then 
		messagebox('Error','Error occured while saving PDF')
		return 1
	end if	


select MD_SEND_BY, MD_TO, MD_CC, MD_BCC, MD_SUBJECT, MD_DETAIL, MD_SIGNATURE into :ls_sender, :ls_recipient, :ls_cc, :ls_bcc, :ls_subject, :ls_body_text, :ls_signature from FB_MAIL_MESSAGE_DETAIL where nvl(MD_EMAIL_IND,'N') = 'Y' and MD_MESS_ID = 3 ;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while fetching mail parameters - '+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','No parameters found for mail')
	return 1
end if

if isnull(ls_sender)	then
	messagebox('Warning','Sender Email is blank')
	return 1
end if

if isnull(ls_recipient)	then
	messagebox('Warning','Sender Email is blank')
	return 1
end if

if isnull(ls_cc) then ls_cc = ""

if isnull(ls_bcc) then ls_bcc = ""

if isnull(ls_subject) then ls_subject = ""

if isnull(ls_body_text) then ls_body_text = ""

if isnull(ls_signature) then ls_signature = ""

//ls_cc += gs_garden_mail

ls_addattachment = ls_file1

//ls_addattachment2 = ls_file1

ls_subject 	 = ls_subject +" "+ string(dp_1.text)+" "+ gs_garden_nm

ls_message	= "Dear Sir/Madam, "+gs_lfcr+gs_lfcr+ls_body_text+gs_lfcr+gs_lfcr
ls_message	 = ls_message +gs_lfcr+"Your kind attention is required."+gs_lfcr

ls_message	 = ls_message +gs_lfcr+"Administrator"+gs_lfcr

ls_message	 = ls_message +gs_lfcr+gs_lfcr+gs_garden_nm+gs_lfcr+gs_garden_add+gs_lfcr+gs_lfcr

ls_message += ls_signature


n_web_mail lnvo_mail
	
lnvo_mail = Create n_web_mail

lb_flag = lnvo_mail.of_send_webmail_single(ls_sender,ls_recipient,ls_cc,ls_subject,ls_message,ls_bcc,ls_addattachment)


if lb_flag = True then
	messagebox('Successful','Sent successfully')
	return 1
else
	messagebox('Error','Unable tosend mail')
	return 1
end if


end event

type em_1 from editmask within w_gtelar076
integer x = 1321
integer y = 36
integer width = 197
integer height = 104
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###.00"
end type

type dp_1 from datepicker within w_gtelar076
integer x = 535
integer y = 40
integer width = 370
integer height = 100
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-07-19"), Time("10:31:14.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;//string ls_frdt,ls_todt
//long ll_pbno
//
//ls_frdt = dp_1.text
//ls_todt = dp_2.text
//
//setpointer(hourglass!)
//
//ddlb_2.reset()
//ddlb_2.additem('ALL')
//
//declare c2 cursor for
//select distinct ls_id
// from FB_EMPLOYEE a, FB_LABOURDAILYATTENDANCE b 
// where  b.LABOUR_ID = a.emp_ID AND trunc(b.LDA_DATE) between to_date(:ls_frdt,'dd/mm/yyyy') and to_date(:ls_todt,'dd/mm/yyyy') order by 1;
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
//setpointer(arrow!)
end event

type st_3 from statictext within w_gtelar076
integer x = 928
integer y = 56
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
string text = "Plucking (%) "
boolean focusrectangle = false
end type

type st_1 from statictext within w_gtelar076
integer x = 9
integer y = 60
integer width = 530
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Date (dd/mm/yyyy) : "
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_gtelar076
integer x = 2299
integer y = 40
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

if isnull(dp_1.text) or dp_1.text='00/00/0000' then 
	messagebox('Warning','Please Enter From And To Date')
	return 
end if

if Date(dp_1.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','From Date Should Be <= Current Date  !!!')
	return 1
end if

if rb_1.checked = true then 
	dw_1.dataobject='dw_gtelar076'
	dw_1.settransobject(sqlca)
elseif rb_2.checked = true  then 
	dw_1.dataobject='dw_gtelar076_pay'
	dw_1.settransobject(sqlca)
end if

dw_1.retrieve(dp_1.text,double(em_1.text),gs_garden_nm )

setpointer(arrow!)
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No data found between the entered dates !!!')
	return 1
end if


end event

type cb_2 from commandbutton within w_gtelar076
integer x = 2565
integer y = 40
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

type dw_1 from datawindow within w_gtelar076
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 152
integer width = 3689
integer height = 2008
string dataobject = "dw_gtelar076"
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

type gb_1 from groupbox within w_gtelar076
integer x = 1545
integer width = 649
integer height = 148
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

