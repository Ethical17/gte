$PBExportHeader$w_einvoice_cancel.srw
forward
global type w_einvoice_cancel from window
end type
type ddlb_1 from dropdownlistbox within w_einvoice_cancel
end type
type st_3 from statictext within w_einvoice_cancel
end type
type sle_2 from singlelineedit within w_einvoice_cancel
end type
type sle_1 from singlelineedit within w_einvoice_cancel
end type
type st_2 from statictext within w_einvoice_cancel
end type
type cb_2 from commandbutton within w_einvoice_cancel
end type
type st_1 from statictext within w_einvoice_cancel
end type
end forward

global type w_einvoice_cancel from window
integer width = 2103
integer height = 772
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
ddlb_1 ddlb_1
st_3 st_3
sle_2 sle_2
sle_1 sle_1
st_2 st_2
cb_2 cb_2
st_1 st_1
end type
global w_einvoice_cancel w_einvoice_cancel

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

on w_einvoice_cancel.create
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_2=create st_2
this.cb_2=create cb_2
this.st_1=create st_1
this.Control[]={this.ddlb_1,&
this.st_3,&
this.sle_2,&
this.sle_1,&
this.st_2,&
this.cb_2,&
this.st_1}
end on

on w_einvoice_cancel.destroy
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.st_1)
end on

event open;declare c1 cursor for
select '1-Duplicate' reason from dual
union all
select '2-Data entry mistake' from dual
union all
select'3-Order Cancelled' from dual
union all
select '4-Others' from dual;

open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_remarks;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_remarks)
		fetch c1 into:ls_remarks;
	loop
	close c1;
end if
setpointer(arrow!)
end event

type ddlb_1 from dropdownlistbox within w_einvoice_cancel
integer x = 288
integer y = 344
integer width = 1751
integer height = 376
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
end type

type st_3 from statictext within w_einvoice_cancel
integer x = 64
integer y = 336
integer width = 201
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Reason"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_einvoice_cancel
integer x = 878
integer y = 28
integer width = 498
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
textcase textcase = upper!
end type

event modified;ls_invoiceno = upper(sle_1.text)


select distinct 'X' into :ls_temp from fb_saleinvoice where  nvl(SI_TAXINVNO, SI_DELVCHNO)=:ls_invoiceno;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Invoice Checking',sqlca.sqlerrtext)	
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning!','Invoice No is wrong, Please Check !!!')
	setnull(ls_invoiceno)
	sle_1.text=""
	sle_1.setfocus()
	return 1
end if

end event

type sle_1 from singlelineedit within w_einvoice_cancel
integer x = 279
integer y = 132
integer width = 1751
integer height = 180
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
end type

type st_2 from statictext within w_einvoice_cancel
integer x = 64
integer y = 152
integer width = 201
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Remarks"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_einvoice_cancel
integer x = 841
integer y = 500
integer width = 343
integer height = 104
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Cancel"
end type

event clicked;ls_remarks=trim(sle_1.text)
ls_invoiceno=trim(sle_2.text)
ls_reason=trim(ddlb_1.text)

if MessageBox("Warrning", 'Do You have Canceled the Invoice From GST Portal ....?' ,Exclamation!, YesNo!, 1) = 1 then
setpointer(hourglass!)
	if(len(ls_remarks)>0 and len(ls_reason)>0) then 
	
	
		 ls_reason =f_get_string_position(ls_reason,'-')
	
		//return 1
		select SI_ID, SI_DATE, nvl(SI_TAXINVNO,'X') , nvl(SI_DELVCHNO,'X'),floor(sysdate-to_date(SI_DATE))  into :ls_siid,:ld_sidate,:ls_taxinvno,:ls_delvchno,:li_noofdays from fb_saleinvoice where nvl(SI_TAXINVNO, SI_DELVCHNO)=:ls_invoiceno;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Invoice Checking',sqlca.sqlerrtext)	
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning!','Invoice Not Found Saleinvoice Table , Please Check !!!')
			return 1
		elseif sqlca.sqlcode = 0 then
			if(ls_taxinvno<>'X') then
				select distinct 'X' into :ls_temp from fb_einvoice where docno=:ls_invoiceno and irn is not null;
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Invoice Checking',sqlca.sqlerrtext)	
					return 1
				elseif sqlca.sqlcode = 100 then
					messagebox('Warning!' ,'IRN hasnt been generted')
					return 1
				elseif sqlca.sqlcode =0 then	
					if(li_noofdays<=1) then
						lb_status=wf_cancel('T',ls_invoiceno,ls_remarks,ls_reason)
					else
						messagebox('Warning!' ,'IRN hasnt been generted')
						return 1
					end if
				end if
			elseif(ls_delvchno<>'X') then
				if(li_noofdays<=1) then
					lb_status=wf_cancel('D',ls_invoiceno,ls_remarks,ls_reason)	
				else
					messagebox('Warning!' ,'IRN hasnt been generted')
					return 1
				end if
			end if
		end if
		
		if(lb_status=false) then 
			rollback;
		else
			commit;
				messagebox('Success!','Invoice Has been Cancelled')
				setpointer(Arrow!)
		end if
		
	else
		messagebox('Warning!','Remarks And Reason is Mandatory , Please Check !!!')
		return 1
	end if
else
	messagebox('Warning!','First Cancel The Invoice From GST Portal !!!')
		return 1
end if
end event

type st_1 from statictext within w_einvoice_cancel
integer x = 64
integer y = 44
integer width = 837
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "INVOICE / DELIVERY NUMBER :"
boolean focusrectangle = false
end type

