$PBExportHeader$w_recalculate_elp.srw
forward
global type w_recalculate_elp from window
end type
type em_2 from editmask within w_recalculate_elp
end type
type em_1 from editmask within w_recalculate_elp
end type
type st_2 from statictext within w_recalculate_elp
end type
type cb_2 from commandbutton within w_recalculate_elp
end type
type st_1 from statictext within w_recalculate_elp
end type
end forward

global type w_recalculate_elp from window
integer width = 887
integer height = 516
boolean titlebar = true
string title = "E-invoicing dashboard"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_2 em_2
em_1 em_1
st_2 st_2
cb_2 cb_2
st_1 st_1
end type
global w_recalculate_elp w_recalculate_elp

type variables

string ls_invoiceno,ls_reason,ls_temp,ls_siid,ls_taxinvno,ls_delvchno,ls_remarks
date ld_sidate
long li_noofdays
boolean lb_status
end variables

forward prototypes
public function boolean wf_cancel (string fs_type, string fs_invoiceno, string fs_remarks, string fs_reason)
end prototypes

public function boolean wf_cancel (string fs_type, string fs_invoiceno, string fs_remarks, string fs_reason);if(fs_type='T') then
	update fb_einvoice set CANCELLED_FLAG='Y', CANCELLED_REMARKS=:fs_remarks, CANCEL_REASON=:fs_reason, CANCEL_DT=sysdate where docno=:fs_invoiceno;
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Updating Cancel Status in Einvoice Table',sqlca.sqlerrtext)	
		return false
	end if		
end if

insert into FB_SIDETAILS_cncl(SI_ID, DTPD_ID, SID_SRNOSTART, SID_SRNOEND, SID_SEASON, SID_CGST_PER, SID_CGST_AMT, SID_SGST_PER, SID_SGST_AMT, SID_IGST_PER, SID_IGST_AMT, SID_RATE)
select SI_ID, DTPD_ID, SID_SRNOSTART, SID_SRNOEND, SID_SEASON, SID_CGST_PER, SID_CGST_AMT, SID_SGST_PER, SID_SGST_AMT, SID_IGST_PER, SID_IGST_AMT, SID_RATE from fb_sidetails where si_id in (select si_id from fb_saleinvoice where nvl(SI_TAXINVNO, SI_DELVCHNO)=:fs_invoiceno);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Inserting Into Cancel table SI DETAILS',sqlca.sqlerrtext)	
	return false
end if		

insert into FB_SALEINVOICE_CNCL(SI_ID, TRANSP_ID, SI_CN, SI_AMOCHARGED, SI_EXCISEDUTY, SI_CESS, SI_DATE, SI_INSURANCEVALUE, SI_DESC, SI_ACTIVE, SI_CONFIRMFLAG, SI_TYPE, SI_EDUCATIONALCESS, 
SI_CENTRALEXCISENO, SI_HSECESS, SI_CNDATE, SI_ISSUE_DT, SI_PRINT_DT, BROK_ID, WARE_ID, COMM_ID, CUS_ID, SI_ENTRY_BY, SI_ENTRY_DT, SI_ROSEND_DT, ADVICE_ID, SI_WAYBILLNO, SI_VEHICLENO, 
SI_ST_DT, SI_END_DT, SI_ISS_LOCN, SI_REC_LOCN, SI_PONO, SI_PODT, SI_DCNO, SI_DCDT, SI_PROMPTDT, SI_SUPPLY_DT, SI_SUPPLY_PLACE, SI_TAXINVNO, SI_DELVCHNO, SI_SHIP_TO_ADD, SI_REV_CHRG, 
SI_LUT_NO, SI_TCS_PER, SI_TCS_AMT, SI_EINV_IND, SI_ISS_GSTNNO, SI_REC_GSTNNO, CNCL_REASON, CNCL_BY, CNCL_DATE) 
select SI_ID, TRANSP_ID, SI_CN, SI_AMOCHARGED, SI_EXCISEDUTY, SI_CESS, SI_DATE, SI_INSURANCEVALUE, SI_DESC, SI_ACTIVE, SI_CONFIRMFLAG, SI_TYPE, 
SI_EDUCATIONALCESS, SI_CENTRALEXCISENO, SI_HSECESS, SI_CNDATE, SI_ISSUE_DT, SI_PRINT_DT, BROK_ID, WARE_ID, COMM_ID, CUS_ID, SI_ENTRY_BY, SI_ENTRY_DT, SI_ROSEND_DT, ADVICE_ID, SI_WAYBILLNO, 
SI_VEHICLENO, SI_ST_DT, SI_END_DT, SI_ISS_LOCN, SI_REC_LOCN, SI_PONO, SI_PODT, SI_DCNO, SI_DCDT, SI_PROMPTDT, SI_SUPPLY_DT, SI_SUPPLY_PLACE, SI_TAXINVNO, SI_DELVCHNO, SI_SHIP_TO_ADD, SI_REV_CHRG, 
SI_LUT_NO, SI_TCS_PER, SI_TCS_AMT, SI_EINV_IND, SI_ISS_GSTNNO, SI_REC_GSTNNO, :fs_remarks, :GS_USER, sysdate
from FB_SALEINVOICE where nvl(SI_TAXINVNO, SI_DELVCHNO)=:fs_invoiceno;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Inserting Into Cancel table SI Header',sqlca.sqlerrtext)	
	return false
end if	


update fb_dailyteapacked set DTP_DISPIND =  null where dtp_id in (select dtp_id from fb_dtpdetails where dtpd_id in 
(select dtpd_id from fb_sidetails where si_id in (select si_id from fb_saleinvoice where SI_TAXINVNO =:fs_invoiceno))); 
if sqlca.sqlcode = -1 then
	messagebox('Error : While Updateing Daily Tea Packed status',sqlca.sqlerrtext)	
	return false
end if	


delete from FB_SIDETAILS where si_id in (select si_id from fb_saleinvoice where nvl(SI_TAXINVNO, SI_DELVCHNO)=:fs_invoiceno);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Deleting from SI DETAILS',sqlca.sqlerrtext)	
	return false
end if	

delete from fb_saleinvoice where nvl(SI_TAXINVNO, SI_DELVCHNO)=:fs_invoiceno;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Deleting from SI HEADER',sqlca.sqlerrtext)	
	return false
end if	
return true
end function

on w_recalculate_elp.create
this.em_2=create em_2
this.em_1=create em_1
this.st_2=create st_2
this.cb_2=create cb_2
this.st_1=create st_1
this.Control[]={this.em_2,&
this.em_1,&
this.st_2,&
this.cb_2,&
this.st_1}
end on

on w_recalculate_elp.destroy
destroy(this.em_2)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.st_1)
end on

type em_2 from editmask within w_recalculate_elp
integer x = 407
integer y = 128
integer width = 384
integer height = 68
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type em_1 from editmask within w_recalculate_elp
integer x = 411
integer y = 40
integer width = 370
integer height = 68
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

type st_2 from statictext within w_recalculate_elp
integer x = 69
integer y = 128
integer width = 233
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date :"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_recalculate_elp
integer x = 151
integer y = 204
integer width = 480
integer height = 104
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Re Calculate ELP"
end type

event clicked;if isnull(em_1.text) or em_1.text = '00/00/0000' then
	messagebox('Warning!','Please Select A From Date !!!')
	return 1
end if

if isnull(em_2.text) or em_2.text = '00/00/0000' then
	messagebox('Warning!','Please Select A To Date !!!')
	return 1
end if

string ls_todt,ls_frdt

ls_frdt=em_1.text;
ls_todt=em_2.text


IF MessageBox("Calculation  Alert", 'Do You Want To RE-Calculate ELP ....?' ,Exclamation!, YesNo!, 2) = 1 THEN
	setpointer(hourglass!)	
	
	declare p2 procedure for up_labour_wages_elp(:gs_user,:gs_garden_snm,:gs_gstn_stcd,:ls_frdt,:ls_todt);
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Declare of up_labour_wages_elp',sqlca.sqlerrtext)					
			return 1
		end if

		execute p2;
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Execute of up_labour_wages_elp',sqlca.sqlerrtext)
			return 1
		end if
		
		Messagebox('Information !','RE-Calculate ELP Process Completed !!!')
		setpointer(arrow!)	
	
end if

end event

type st_1 from statictext within w_recalculate_elp
integer x = 64
integer y = 40
integer width = 293
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date :"
boolean focusrectangle = false
end type

