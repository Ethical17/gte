$PBExportHeader$w_gteacf024.srw
forward
global type w_gteacf024 from window
end type
type ddlb_1 from dropdownlistbox within w_gteacf024
end type
type st_1 from statictext within w_gteacf024
end type
type cb_4 from commandbutton within w_gteacf024
end type
type cb_3 from commandbutton within w_gteacf024
end type
type cb_2 from commandbutton within w_gteacf024
end type
type cb_1 from commandbutton within w_gteacf024
end type
type dw_1 from datawindow within w_gteacf024
end type
end forward

global type w_gteacf024 from window
integer width = 4686
integer height = 2412
boolean titlebar = true
string title = "(w_ltchrf014) BRS"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_1 ddlb_1
st_1 st_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteacf024 w_gteacf024

type variables
long ll_ctr,net, ll_cnt, ll_year, ll_last,ll_user_level,ll_party
string ls_temp,ls_tmp_id,ls_name,ls_last,ls_grade,ls_count,ls_bankid,ls_vou_no,ls_recuser,ls_vouno,ls_dcind,ls_chequeno,ls_trnid,ls_bankledger
boolean lb_neworder, lb_query
datetime ld_chqdt,ld_chqdate
double ld_it_rate, ld_sc_rate,ld_cess_rate,ld_recddt,ld_chqamt,ld_checkamt
datawindowchild idw_chq
string ls_acledger_id,ls_brs_chqno,ls_brs_drcrflag,ls_sub_acledger_id
datetime ld_brs_chqdate


end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer check_duplicate_fields (string fl_field, string fl_value, string fl_message)
public function integer wf_check_duplicate_rec (string fs_bankid, string fl_chequeno, string fs_trn_id)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
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


end event

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if (	 isnull(dw_1.getitemstring(fl_row,'acledger_id')) or len(dw_1.getitemstring(fl_row,'acledger_id'))=0  or & 
	   	 isnull(dw_1.getitemnumber(fl_row,'brs_clearamt')) or  dw_1.getitemnumber(fl_row,'brs_clearamt')=0 or &
		 isnull(dw_1.getitemstring(fl_row,'brs_drcrflag')) or  len(dw_1.getitemstring(fl_row,'brs_drcrflag'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'brs_chqno')) or  len(dw_1.getitemstring(fl_row,'brs_chqno'))=0 or &
		 isnull(dw_1.getitemdatetime(fl_row,'brs_cleardate')) or isnull(dw_1.getitemdatetime(fl_row,'brs_chqdate'))) then
	      messagebox('Warning: One Of The Following Fields Are Blank', 'Bank ,Cheque No,Cheque Date,Clear Amount,Clear Date,Dr/Cr Indicator, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer check_duplicate_fields (string fl_field, string fl_value, string fl_message);long fl_row
string  ls_value

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_value = dw_1.getitemstring(fl_row,''+fl_field+'')
		
		if ls_value = fl_value then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate "+fl_message +" At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_duplicate_rec (string fs_bankid, string fl_chequeno, string fs_trn_id);long fl_row
string ls_bank_id,ls_chequeno1,ls_trn_id

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		
		ls_bank_id = dw_1.getitemstring(fl_row,'acledger_id')
		ls_chequeno1 = dw_1.getitemstring(fl_row,'brs_chqno')
		ls_trn_id  = dw_1.getitemstring(fl_row,'trn_id')
		
		if ls_bank_id = fs_bankid and ls_chequeno1 = fl_chequeno  and  ls_trn_id = fs_trn_id then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1


end function

on w_gteacf024.create
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.ddlb_1,&
this.st_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteacf024.destroy
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
dw_1.modify("t_co.text = '"+gs_co_name+"'")

dw_1.GetChild ("brs_chqno", idw_chq)
idw_chq.settransobject(sqlca)	

this.tag = Message.StringParm
ll_user_level = long(this.tag)

declare c1 cursor for
select distinct initcap(ACSUBLEDGER_MANID)||' ('||ACSUBLEDGER_ID||')' bankname
from  fb_acledger  a ,fb_acsubledger b
where a.ACLEDGER_ID=b.ACLEDGER_ID and upper(ACLEDGER_LEDGERTYPE)  like 'BANK' and ACLEDGER_ACTIVE_IND='Y';

open c1;

if sqlca.sqlcode = -1 then 
	messagebox('Error','Error During Opening Cursor C1 : '+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 0 then 
	
	setnull(ls_bankledger);
	fetch c1 into :ls_bankledger;
	
	do while sqlca.sqlcode <> 100
	
		ddlb_1.additem(ls_bankledger);
	
		setnull(ls_bankledger);
		fetch c1 into :ls_bankledger;
	
	loop
	close c1;
end if;
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF1!) THEN
	cb_1.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type ddlb_1 from dropdownlistbox within w_gteacf024
integer x = 402
integer y = 8
integer width = 1504
integer height = 768
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean vscrollbar = true
end type

type st_1 from statictext within w_gteacf024
integer x = 14
integer y = 24
integer width = 384
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bank Ledger :"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_gteacf024
integer x = 2725
integer y = 12
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

event clicked;if dw_1.modifiedcount() > 0 or dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gteacf024
integer x = 2459
integer y = 12
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

string temp 

if dw_1.rowcount() > 0 then
    for ll_ctr = dw_1.rowcount() to 1 step -1	
		IF isnull(dw_1.getitemnumber(ll_ctr,'brs_clearamt')) or dw_1.getitemnumber(ll_ctr,'brs_clearamt') = 0 or &
		    isnull(dw_1.getitemdatetime(ll_ctr,'brs_cleardate'))  THEN
			dw_1.deleterow(ll_ctr)
		END IF
   next	
end if

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.rowcount() > 0 then
		if wf_check_fillcol(dw_1.getrow()) = -1 then return 1
	end if

	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 	
			IF not isnull(dw_1.getitemnumber(ll_ctr,'brs_clearamt')) or dw_1.getitemnumber(ll_ctr,'brs_clearamt') <> 0 or &
		        not isnull(dw_1.getitemdatetime(ll_ctr,'brs_cleardate'))  THEN
				ls_bankid = dw_1.getitemstring(ll_ctr,'acledger_id')
				ls_chequeno = dw_1.getitemstring(ll_ctr,'brs_chqno')
				ls_trnid = dw_1.getitemstring(ll_ctr,'trn_id')
	
				select distinct to_char(brs_chqdate,'dd/mm/yyyy') into :ls_temp from Fb_BRS where acledger_id=:ls_bankid and brs_chqno = :ls_chequeno and trn_id = :ls_trnid and nvl(BRS_CNCL_FLAG,'N') = 'N';
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Cheque No.',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 0 then
					messagebox('Warning!','Cheque No. Already Cleared On '+ls_temp+' Date , Please Check !!!')
					return 1
				end if	
						
				 if dw_1.getitemstatus(ll_cnt,0,primary!) = NewModified! or dw_1.getitemstatus(ll_cnt,0,primary!) = New! then
					if ll_last=0 then
						select nvl(MAX(substr(BRS_ID,4,7)),0) into :ll_last from fb_brs;
					end if
					ll_last = ll_last + 1
					ls_count = string (ll_last,'0000000') 
					ls_tmp_id = 'BRS'+ls_count
					dw_1.setitem(ll_cnt,'BRS_ID',ls_tmp_id)		
				end if		
		   else
				dw_1.deleterow(ll_ctr)
		   end if;	
		 next	
	end if

	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type cb_2 from commandbutton within w_gteacf024
integer x = 2194
integer y = 12
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Query"
end type

event clicked;if cb_2.text = "&Query" then
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	lb_query = true
	dw_1.settaborder('acledger_id',5)
	dw_1.settaborder('brs_chqno',6)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('acledger_id')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.settaborder('acledger_id',0)
	dw_1.settaborder('brs_chqno',0)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gteacf024
integer x = 1929
integer y = 12
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;
dw_1.settransobject(sqlca)
dw_1.reset()


if isnull(ddlb_1.text) or len(ddlb_1.text)=0 then
	messagebox('Error','Bank Ledger Should Be Selected')
	return 1
end if

ls_bankledger = left(right(ddlb_1.text,9),8)

if isnull(ls_bankledger) or len(ls_bankledger)=0 then
	messagebox('Error','Bank Ledger Should Be Selected')
	return 1
else
	
	declare c1 cursor for 
    select VD_GL_CD,VD_CHQ_NO, VD_CHEQUE_DT,VH_VOU_NO,sum(nvl(VD_AMOUNT,0))chq_amt,VD_DC_IND,VD_DOC_SRL VD_TRN_ID ,VD_sGL_CD
     from fb_vou_head a,fb_vou_det b
     where a.VH_doc_srl=b.VD_doc_srl and nvl(VD_CHQ_NO,'00000')<>'00000' and VH_VOU_TYPE in ('BPV','BRV') and
               VD_sGL_CD = :ls_bankledger and VH_APPROVED_DT is not null  and 
               not exists (select  BRS_CHQNO from fb_brs where ACLEDGER_ID=VD_GL_CD and BRS_VOU_NO=VH_VOU_NO and TRN_ID=VD_DOC_SRL and nvl(BRS_CNCL_FLAG,'N') = 'N')
      group by VD_GL_CD,VD_CHQ_NO, VD_CHEQUE_DT,VH_VOU_NO,VD_DC_IND,VD_DOC_SRL,VD_sGL_CD order by VD_CHEQUE_DT,VD_CHQ_NO ;
	
	open c1;
	
	if sqlca.sqlcode = -1 then 
		messagebox('SQL Error','Error During Opening Cursor C1 : '+sqlca.sqlerrtext)
		return 1
	elseif sqlca.sqlcode = 0 then 
		setnull(ls_acledger_id);setnull(ls_brs_chqno);setnull(ls_brs_drcrflag);setnull(ls_vouno);setnull(ld_brs_chqdate);setnull(ls_trnid);setnull(ls_sub_acledger_id);
		 ld_checkamt =0;
		fetch c1 into :ls_acledger_id, :ls_brs_chqno, :ld_brs_chqdate,:ls_vouno, :ld_checkamt,:ls_brs_drcrflag,:ls_trnid,:ls_sub_acledger_id;
			
      	do while sqlca.sqlcode <> 100 

			dw_1.scrolltorow(dw_1.insertrow(0))
			
			dw_1.setitem(dw_1.getrow(),'acledger_id',ls_acledger_id)
			dw_1.setitem(dw_1.getrow(),'brs_chqno',ls_brs_chqno)
			dw_1.setitem(dw_1.getrow(),'brs_chqdate',ld_brs_chqdate)
			dw_1.setitem(dw_1.getrow(),'brs_vou_no',ls_vouno)
			dw_1.setitem(dw_1.getrow(),'checkamt',ld_checkamt)
			dw_1.setitem(dw_1.getrow(),'brs_clearamt',ld_checkamt)
			dw_1.setitem(dw_1.getrow(),'brs_drcrflag',ls_brs_drcrflag)
			dw_1.setitem(dw_1.getrow(),'trn_id',ls_trnid)
			dw_1.setitem(dw_1.getrow(),'subacledger_id',ls_sub_acledger_id)
			
			
			setnull(ls_acledger_id);setnull(ls_brs_chqno);setnull(ls_brs_drcrflag);setnull(ls_vouno);setnull(ld_brs_chqdate); setnull(ls_trnid);setnull(ls_sub_acledger_id);ld_checkamt =0;
		fetch c1 into :ls_acledger_id, :ls_brs_chqno, :ld_brs_chqdate,:ls_vouno, :ld_checkamt,:ls_brs_drcrflag,:ls_trnid,:ls_sub_acledger_id;
			
		loop
		close c1;
		dw_1.ScrolltoRow(1)
		dw_1.insertrow(0)
				
	end if;
end if;


end event

type dw_1 from datawindow within w_gteacf024
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer y = 116
integer width = 4635
integer height = 2052
integer taborder = 30
string dataobject = "dw_gteacf024"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		//dw_1.setitem(newrow,'fcd_cancel_by',gs_user)
		//dw_1.setitem(newrow,'fcd_cancel_dt',datetime(today()))
		dw_1.setcolumn('acledger_id')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.getrow())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.getrow())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;if lb_query = false then
	
	if dwo.name='acledger_id' then
		ls_bankid=data
		string  ls_bank,ls_acno
		
		idw_chq.SetFilter ("vd_gl_cd = '"+trim(ls_bankid)+"'") 
	     idw_chq.filter( )
	
//		select CB_MANID , BL_ACNO into :ls_bank,:ls_acno
//		  from fb_bankledger a ,fb_chqbank b  where a.CB_ID=b.CB_ID(+) and  nvl(BL_ACTIVE_IND,'N')='Y' and BL_ID=:ls_bankid;
//		  if sqlca.sqlcode = -1 then
//				messagebox('Error : While Getting Bank  Details',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			elseif sqlca.sqlcode  = 0 then
//				dw_1.setitem(row,'fcd_bank_ac_no',ls_acno) 
//				dw_1.setitem(row,'fcd_bank_name',ls_bank) 
//			end if
	end if
	

	if dwo.name = 'brs_chqno' then
		ls_chequeno=data
		
		if f_check_initial_space(data) = -1 then return 1
	//	if f_check_numeric(data) = -1 then return 1
		
		ls_bankid = dw_1.getitemstring(dw_1.getrow(),'acledger_id')
		
		idw_chq.accepttext( )	
		ld_chqdt = idw_chq.getitemdatetime(idw_chq.getrow(),'vd_cheque_dt')
		ls_vouno = idw_chq.getitemstring(idw_chq.getrow(),'vh_vou_no')
		ld_chqamt = idw_chq.getitemnumber(idw_chq.getrow(),'chq_amt')
		ls_dcind = idw_chq.getitemstring(idw_chq.getrow(),'vd_dc_ind') 	
		ls_trnid = idw_chq.getitemstring(idw_chq.getrow(),'VD_TRN_ID')
			
		dw_1.setitem(row,'brs_chqdate',ld_chqdt)
		dw_1.setitem(row,'brs_vou_no',ls_vouno)	
		dw_1.setitem(row,'checkamt',ld_chqamt)	
		dw_1.setitem(row,'brs_clearamt',ld_chqamt)	
		dw_1.setitem(row,'brs_drcrflag',ls_dcind)	
		dw_1.setitem(row,'trn_id',ls_trnid)
	
		if check_duplicate_fields('brs_chqno',data,'Cheque No.') = -1 then return 1
			
		select distinct to_char(brs_chqdate,'dd/mm/yyyy') into :ls_temp from Fb_BRS where acledger_id=:ls_bankid and brs_vou_no=:ls_vouno and  TRN_ID=:ls_trnid and nvl(BRS_CNCL_FLAG,'N') = 'N';
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Cheque No.',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Cheque No. Already Cleared On '+ls_temp+' Date , Please Check !!!')
			return 1
		end if	
	end if;		
	
	IF DWO.NAME = 'brs_remarks' or DWO.NAME = 'brs_vou_no'  then
		 if f_check_initial_space(data) = -1 then return 1		
		if f_check_alphanumeric(data) = -1 then return 1		
		if f_check_string_sp(data) = -1 then return 1	
	end if;	
	
	if dwo.name = 'brs_cleardate'  then
		ld_chqdt = datetime(data)
		
		ld_chqdate = dw_1.getitemdatetime(dw_1.getrow(),'brs_chqdate') 
	
		if date(data) < date(ld_chqdate) then
			messagebox('Warning!','Date Of Cheque Clearence should not be Less Than Cheque date, Please Check !!!')
			return 1
		end if
	
		if date(ld_chqdt) > today() then
			messagebox('Warning!','Date Of Cheque Clearence Should Not Be > Current Date, Please Check !!!')
			return 1
		end if		
	end if
	


cb_3.enabled = true
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

end event

