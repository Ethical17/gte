$PBExportHeader$w_gteacf007.srw
forward
global type w_gteacf007 from window
end type
type cb_11 from commandbutton within w_gteacf007
end type
type cb_9 from commandbutton within w_gteacf007
end type
type cb_8 from commandbutton within w_gteacf007
end type
type cb_7 from commandbutton within w_gteacf007
end type
type cb_5 from commandbutton within w_gteacf007
end type
type cbx_1 from checkbox within w_gteacf007
end type
type cb_4 from commandbutton within w_gteacf007
end type
type cb_3 from commandbutton within w_gteacf007
end type
type cb_2 from commandbutton within w_gteacf007
end type
type cb_1 from commandbutton within w_gteacf007
end type
type dw_1 from datawindow within w_gteacf007
end type
type dw_2 from datawindow within w_gteacf007
end type
type dw_3 from datawindow within w_gteacf007
end type
end forward

global type w_gteacf007 from window
integer width = 4635
integer height = 2668
boolean titlebar = true
string title = "(w_gteacf007) Voucher form"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_11 cb_11
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_5 cb_5
cbx_1 cbx_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
end type
global w_gteacf007 w_gteacf007

type variables
long ll_ctr, ll_cnt,l_ctr,ll_ref,ll_row,ll_row2,ll_vou_bal,ll_user_level,ll_acyrid,ll_acpd, ll_docsrl,ll_dcno,ll_ctr2
string ls_temp,ls_del_ind,ls_mac_id,ls_tmp_id,ls_appr_ind,ls_entry_user, ls_appr_by, ls_vou_type,ls_cons,ls_last,ls_count,ls_gl_cd,ls_sgl_cd,ls_gl,ls_party_cd,ls_party_desc,ls_opt,ls_doc_ty,ls_contra_gl,ls_contra_sgl,ls_ac_dt,ls_expsubhead
boolean lb_neworder, lb_query
double ld_hrs, ld_min, ld_tot_hrs, ld_vou_bal
datetime ld_rundt,ld_appr_dt,ld_startdt,ld_enddt, ld_pluckdt,ld_old_entry_dt,ld_voudt, ld_billdt
datawindowchild idw_sgl,idw_eacsubhead,idw_contrasgl,idw_contragl,idw_vouty

 string ls_sg,ls_sgl,ls_dc_ind,ls_old_expsubhead,ls_old_preferred_mes,ls_old_dc_ind,ls_rec_change,ls_preferred_mes,ls_section_id,ls_empid,ls_emp_type,ls_status,ls_vou_dt,ls_party_gstin, ls_party_gstinstcd
 double ld_amt,ld_old_amount,ld_wages,ld_afrate, ld_opening, ld_tds_amt, ld_tds_per,ld_sgl_amt,ld_amount
 
double ld_bill_amt, ld_cgst_prcnt, ld_sgst_prcnt, ld_igst_prcnt, ld_cgst_amt, ld_sgst_amt, ld_igst_amt
string ls_hsn_cd, ls_cgst_recgl, ls_sgst_recgl, ls_igst_recgl, ls_cgst_paygl, ls_sgst_paygl, ls_igst_paygl, ls_gst_sundry_pay, ls_co_id, ls_party_tds, ls_ref_date, ls_entry_dt, ls_functions
string ls_cgst_recsgl, ls_sgst_recsgl, ls_igst_recsgl, ls_cgst_paysgl, ls_sgst_paysgl, ls_igst_paysgl, ls_gst_sundry_paysgl, ls_gst_ind, ls_revchg_ind, ls_rev_catg, ls_ref_no, ls_chq_no

 string ls_exp_gl,ls_adv_gl,ls_deposit_gl,ls_atppf_sgl,ls_billno,ls_billdt,ls_party,ls_Plucking_Leaf,ls_narr,ls_lwwid, ls_vou_no, ls_tds_gl, ls_user_id, ls_business_segment,ls_revinvno, ls_tds_ind,ls_glentry_alow
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_glcd, string fs_sglcd, double fd_amt, string fs_narr, string fs_bill, datetime fd_billdt)
public function integer wf_check_section (integer fl_row)
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

public function integer wf_check_fillcol (integer fl_row);//if dw_1.rowcount() > 0 and fl_row > 0 then
//	if (isnull(dw_1.getitemstring(fl_row,'machine_id')) or  len(dw_1.getitemstring(fl_row,'machine_id'))=0 or &
//		 isnull(dw_1.getitemdatetime(fl_row,'peg_date'))) then
//	    messagebox('Warning: One Of The Following Fields Are Blank','Machine ID, Run Date, Please Check !!!')
//		 return -1
//	end if' ''
//end if
if dw_2.rowcount() > 0 and fl_row > 0 then
	if gs_opt='EV' then
		if (isnull(dw_2.getitemstring(fl_row,'vd_functions')) or  len(dw_2.getitemstring(fl_row,'vd_functions'))=0 or &
			 isnull(dw_2.getitemstring(fl_row,'vd_business_segment')) or  len(dw_2.getitemstring(fl_row,'vd_business_segment'))=0 or &
			 isnull(dw_2.getitemstring(fl_row,'vd_gl_cd')) or  len(dw_2.getitemstring(fl_row,'vd_gl_cd'))=0 or &
			 isnull(dw_2.getitemstring(fl_row,'vd_sgl_cd')) or  len(dw_2.getitemstring(fl_row,'vd_sgl_cd'))=0 or &
			 isnull(dw_2.getitemstring(fl_row,'vd_dc_ind')) or  len(dw_2.getitemstring(fl_row,'vd_dc_ind'))=0 or &
         	 (dw_2.getitemstring(fl_row,'VD_GST_IND') = 'Y' and (isnull(dw_2.getitemstring(fl_row,'vd_ref_no')) or  len(dw_2.getitemstring(fl_row,'vd_ref_no'))=0)) or &
			 (dw_2.getitemstring(fl_row,'VD_GST_IND') = 'Y' and (isnull(dw_2.getitemstring(fl_row,'vd_party_cd')) or  len(dw_2.getitemstring(fl_row,'vd_party_cd'))=0)) or &
			 isnull(dw_2.getitemdatetime(fl_row,'vd_ref_date')) or &
			 ((not isnull(trim(dw_2.getitemstring(fl_row,'vd_expsubhead'))) or len(trim(dw_2.getitemstring(fl_row,'vd_expsubhead'))) > 0)  and & 
			   (isnull(dw_2.getitemstring(fl_row,'vd_preferred_mes')) or len(dw_2.getitemstring(fl_row,'vd_preferred_mes')) = 0)) or &
			 isnull(dw_2.getitemnumber(fl_row,'vd_amount')) or dw_2.getitemnumber(fl_row,'vd_amount') = 0 or &
			 (dw_2.getitemstring(fl_row,'vd_tds_per') = 'Y' and (isnull(dw_2.getitemnumber(fl_row,'vd_tds_per')) or isnull(dw_2.getitemnumber(fl_row,'vd_original_amt')) or dw_2.getitemnumber(fl_row,'vd_tds_per') = 0 or dw_2.getitemnumber(fl_row,'vd_original_amt') = 0))) then
			 messagebox('Warning: One Of The Following Fields Are Blank','Ac Function, Business segment, Ledger Id,subledger Id, (Expense Subhead & Prefered MES), Dr/Cr Ind, Amount,Bill No,Bill Date,Party, TDS %, TDS on Amount, Please Check !!!')
			 return -1
		end if
	else	
		if (isnull(dw_2.getitemstring(fl_row,'vd_functions')) or  len(dw_2.getitemstring(fl_row,'vd_functions'))=0 or &
			 isnull(dw_2.getitemstring(fl_row,'vd_business_segment')) or  len(dw_2.getitemstring(fl_row,'vd_business_segment'))=0 or &
			 isnull(dw_2.getitemstring(fl_row,'vd_gl_cd')) or  len(dw_2.getitemstring(fl_row,'vd_gl_cd'))=0 or &
			 isnull(dw_2.getitemstring(fl_row,'vd_sgl_cd')) or  len(dw_2.getitemstring(fl_row,'vd_sgl_cd'))=0 or &
			 ((not isnull(trim(dw_2.getitemstring(fl_row,'vd_expsubhead'))) or len(trim(dw_2.getitemstring(fl_row,'vd_expsubhead'))) > 0)  and & 
			   (isnull(dw_2.getitemstring(fl_row,'vd_preferred_mes')) or len(dw_2.getitemstring(fl_row,'vd_preferred_mes')) = 0))	or &	 
			 isnull(dw_2.getitemstring(fl_row,'vd_dc_ind')) or  len(dw_2.getitemstring(fl_row,'vd_dc_ind'))=0 or &
			 isnull(dw_2.getitemnumber(fl_row,'vd_amount')) or dw_2.getitemnumber(fl_row,'vd_amount') = 0) then
			 messagebox('Warning: One Of The Following Fields Are Blank','AC Functions,Business segment, Ledger,subledger Id, (Expense Subhead & Prefered MES), Dr/Cr Ind,Amount Please Check !!!')
			 return -1
		end if
	end if;	
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_glcd, string fs_sglcd, double fd_amt, string fs_narr, string fs_bill, datetime fd_billdt);long fl_row
string ls_gl_cd1,ls_sgl_cd1,ls_billno1,ls_narr1
datetime ld_run_dt1,ld_billdt1
double ld_amt1
dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 1 then
	for fl_row = 1 to (dw_2.rowcount() - 1)
		ls_gl_cd1 = dw_2.getitemstring(fl_row,'vd_gl_cd')
		ls_sgl_cd1 = dw_2.getitemstring(fl_row,'vd_sgl_cd') 
		ld_amt1 = dw_2.getitemnumber(fl_row,'vd_amount')
		ls_narr1 = dw_2.getitemstring(fl_row,'vd_narr_free_text')
		ls_billno1 = dw_2.getitemstring(fl_row,'vd_ref_no')
		ld_billdt1 = dw_2.getitemdatetime(fl_row,'vd_ref_date')

		
		if ls_gl_cd1 = fs_glcd and ls_sgl_cd1 = fs_sglcd and ls_billno1 = fs_bill and ls_narr1 = fs_narr and ld_amt1 = fd_amt and ld_billdt1 = fd_billdt then
			dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_section (integer fl_row);string ls_acsubledger

if dw_2.rowcount() > 0 and fl_row > 0 then
	ls_acsubledger=dw_2.getitemstring(fl_row,'vd_sgl_cd')
	
	
	if(ls_acsubledger='SLEG0024' or ls_acsubledger='SLEG0022' or ls_acsubledger='SLEG0012' or ls_acsubledger='SLEG0013') and (isnull(dw_2.getitemstring(fl_row,'vd_section_id')) or  len(dw_2.getitemstring(fl_row,'vd_section_id'))=0) then
			messagebox('Warning :',' For Subledger Mature Tea,Young Tea,Replanting , Extension Planting Need Section AT Row ' + string (fl_row));
			return -1;
		end if
	
end if

return 1
end function

on w_gteacf007.create
this.cb_11=create cb_11
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_5=create cb_5
this.cbx_1=create cbx_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.Control[]={this.cb_11,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_5,&
this.cbx_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.dw_2,&
this.dw_3}
end on

on w_gteacf007.destroy
destroy(this.cb_11)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_5)
destroy(this.cbx_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;//dw_1.modify("t_co.text = '"+gs_CO_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

lb_query = false	
lb_neworder = false

dw_1.GetChild ("vh_contra_gl", idw_contragl)
idw_contragl.settransobject(sqlca)

dw_1.GetChild ("vh_vou_type", idw_vouty)
idw_vouty.settransobject(sqlca)

dw_1.GetChild ("vh_contra_sgl", idw_contrasgl)
idw_contrasgl.settransobject(sqlca)	

dw_2.GetChild ("vd_sgl_cd", idw_sgl)
idw_sgl.settransobject(sqlca)	

dw_2.GetChild ("vd_expsubhead", idw_eacsubhead)
idw_eacsubhead.settransobject(sqlca)	



ls_opt = gs_opt

if gs_opt = 'CV' then
	dw_1.modify("h1.text ='Cash Voucher'")
	dw_1.modify("vh_contra_gl.visible=True")
	dw_1.modify("vh_contra_sgl.visible=True")
	dw_1.modify("t_10.visible=True")
	dw_1.modify("t_12.visible=True")
	dw_1.modify("vh_cheque_no.visible=False")
	dw_1.modify("vh_cheque_dt.visible=False")	
	dw_1.modify("vh_cheque_payto.visible=False")
	dw_1.modify("t_9.visible=False")
	dw_1.modify("t_7.visible=False")
	dw_2.modify("t_1.text='Reference :'")
	dw_2.modify("vd_party_cd.visible=False")
	dw_2.modify("t_17.visible=False")
	idw_vouty.setfilter("recty='C'")
	idw_vouty.filter( )
elseif gs_opt = 'BV' then
	dw_1.modify("h1.text ='Bank Voucher'")
	dw_1.modify("vh_contra_gl.visible=True")
	dw_1.modify("vh_contra_sgl.visible=True")
	dw_1.modify("t_10.visible=True")
	dw_1.modify("t_12.visible=True")
	dw_1.modify("vh_cheque_no.visible=True")
	dw_1.modify("vh_cheque_dt.visible=True")	
	dw_1.modify("vh_cheque_payto.visible=True")
	dw_1.modify("t_9.visible=True")
	dw_1.modify("t_7.visible=True")
	dw_2.modify("t_1.text='Reference :'")
	dw_2.modify("vd_party_cd.visible=False")
	dw_2.modify("t_17.visible=False")
	idw_vouty.setfilter("recty='B'")
	idw_vouty.filter( )
elseif gs_opt = 'EV' then
	dw_1.modify("h1.text ='Expense Voucher'")
	dw_1.modify("vh_contra_gl.visible=False")
	dw_1.modify("vh_contra_sgl.visible=False")	
	dw_1.modify("t_10.visible=False")
	dw_1.modify("t_12.visible=False")
	dw_1.modify("vh_cheque_no.visible=False")
	dw_1.modify("vh_cheque_dt.visible=False")	
	dw_1.modify("vh_cheque_payto.visible=False")
	dw_1.modify("t_9.visible=False")
	dw_1.modify("t_7.visible=False")
	dw_2.modify("t_1.text='Bill :'")
	dw_2.modify("vd_party_cd.visible=True")
	dw_2.modify("t_17.visible=True")
	idw_vouty.setfilter("recty='E'")
	idw_vouty.filter( )		
	
else
	dw_1.modify("h1.text ='Journal Voucher'")
	dw_1.modify("vh_contra_gl.visible=False")
	dw_1.modify("vh_contra_sgl.visible=False")	
	dw_1.modify("t_10.visible=False")
	dw_1.modify("t_12.visible=False")
	dw_1.modify("vh_cheque_no.visible=False")
	dw_1.modify("vh_cheque_dt.visible=False")	
	dw_1.modify("vh_cheque_payto.visible=False")
	dw_1.modify("t_9.visible=False")
	dw_1.modify("t_7.visible=False")
	dw_2.modify("t_1.text='Reference :'")
	dw_2.modify("vd_party_cd.visible=False")
	dw_2.modify("t_17.visible=False")
	idw_vouty.setfilter("recty='J'")
	idw_vouty.filter( )
end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

select distinct 'x' into :ls_temp from FB_SERIAL_NO 
where SN_DOC_TYPE in ('JV','CV','BV') and SN_ACCT_YEAR=to_char(sysdate,'yyyymm');

if sqlca.sqlcode = 100 then
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(sysdate,'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(sysdate,'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(sysdate,'yyyymm')); 
	commit using sqlca;
end if


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

type cb_11 from commandbutton within w_gteacf007
boolean visible = false
integer x = 3506
integer y = 20
integer width = 361
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Delete UAV"
end type

event clicked;

	for ll_ctr = dw_1.rowcount() to 1 step -1
		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y'  then
			
			
			
			dw_2.reset()
			dw_2.retrieve(dw_1.getitemnumber(dw_1.getrow(),'vh_doc_srl'),gs_user)
			for ll_ctr2 = dw_2.rowcount() to 1 step -1
				dw_2.deleterow(ll_ctr2)
				dw_2.update()
			next
			dw_1.deleterow(ll_ctr)
	 		dw_1.update()
			
			
			
		end if
	next	
	
	dw_1.reset()
	
commit using sqlca;


cb_3.visible=true
cb_11.visible=false

messagebox('Success','Un Aproved Voucher has been Removed')

end event

type cb_9 from commandbutton within w_gteacf007
integer x = 4306
integer y = 20
integer width = 123
integer height = 88
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(dw_1.rowcount())
end if
end event

type cb_8 from commandbutton within w_gteacf007
integer x = 4187
integer y = 20
integer width = 123
integer height = 88
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollnextRow()
end if
end event

type cb_7 from commandbutton within w_gteacf007
integer x = 4069
integer y = 20
integer width = 123
integer height = 88
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollPriorRow()
end if
end event

type cb_5 from commandbutton within w_gteacf007
integer x = 3950
integer y = 20
integer width = 123
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(1)
end if
end event

type cbx_1 from checkbox within w_gteacf007
integer x = 1129
integer y = 32
integer width = 379
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Un Approved"
boolean checked = true
end type

type cb_4 from commandbutton within w_gteacf007
integer x = 809
integer y = 12
integer width = 265
integer height = 100
integer taborder = 60
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

type cb_3 from commandbutton within w_gteacf007
integer x = 544
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
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

if dw_2.rowcount() > 1 then
	if (isnull(dw_2.getitemstring(dw_2.rowcount(),'vd_sgl_cd')) or len(dw_2.getitemstring(dw_2.rowcount(),'vd_sgl_cd')) = 0) then 
		dw_2.deleterow(dw_2.rowcount())
	end if;
end if


IF  MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
    //////////  For Deletion  ///////////////
	for ll_ctr = dw_2.rowcount() to 1 step -1
		if dw_2.getitemstring(ll_ctr,'del_flag') = 'Y' and dw_2.rowcount() = dw_2.getitemnumber(ll_ctr,'sel_row') then
			messagebox('Warning!','You Cannot Delete All Records From Detail Section !!!')
			return 1
		elseif dw_2.getitemstring(ll_ctr,'del_flag') = 'Y' and dw_2.rowcount() <> dw_2.getitemnumber(ll_ctr,'sel_row') then
			dw_2.deleterow(ll_ctr)
		end if
	next	
	
	if dw_2.rowcount() = 0 then
		messagebox('Error','Records Should Be Available In Detail Block')
		return
	end if

	if dw_1.rowcount() > 0 then	
		if (isnull(dw_1.getitemstring(dw_1.getrow(),'vh_vou_type')) or len(dw_1.getitemstring(dw_1.getrow(),'vh_vou_type'))=0 or &
			 isnull(dw_1.getitemstring(dw_1.getrow(),'vh_ledger_type')) or  len(dw_1.getitemstring(dw_1.getrow(),'vh_ledger_type'))=0 or &
			 isnull(dw_1.getitemdatetime(dw_1.getrow(),'vh_vou_date')) ) then
			messagebox('Warning:','One Of The Fields Are Blank :Voucher Type, Ledger type, Voucher Date !!!')
			dw_1.setfocus()
			dw_1.setcolumn('vh_vou_type')
			return 1
		end if
		
		if dw_1.getitemstring(dw_1.getrow(),'vh_vou_type')='BPV' or dw_1.getitemstring(dw_1.getrow(),'vh_vou_type')='BRV' then
			if (isnull(dw_1.getitemstring(dw_1.getrow(),'vh_contra_gl')) or len(dw_1.getitemstring(dw_1.getrow(),'vh_contra_gl'))=0 or &
				 isnull(dw_1.getitemstring(dw_1.getrow(),'vh_contra_sgl')) or  len(dw_1.getitemstring(dw_1.getrow(),'vh_contra_sgl'))=0 ) then
				messagebox('Warning:','One Of The Fields Are Blank : Contra Gl & Sgl, Please Check !!!')
				dw_1.setfocus()
				dw_1.setcolumn('vh_contra_gl')
				return 1
			end if
		end if
	end if
	
	if dw_2.rowcount() > 0 then
		for  ll_ctr = dw_2.rowcount() to 1 step -1
			IF wf_check_fillcol(ll_ctr) = -1 THEN 
				rollback using sqlca;
				return 1
			end if
			
			if wf_check_section(ll_ctr)	= -1 THEN 
				return 1
			end if
			
			
		next	
	end if
	
	////check expense voucher
      ls_vou_type=dw_1.getitemstring(dw_1.getrow(),'vh_vou_type')
	  long ll_count	
	  ll_count=0;
	 if ls_vou_type ='EXPV' then
		for ll_ctr = dw_2.rowcount() to 1 step -1
			ls_gl_cd = dw_2.getitemstring(ll_ctr,'vd_gl_cd')
			
			select distinct ACLEDGER_ID into :ls_exp_gl from fb_acledger where ACLEDGER_ACTYPE = 'E' and nvl(ACLEDGER_ACTIVE_IND,'N')='Y' 
	          and ACLEDGER_ID=:ls_gl_cd;
				 
	                if dw_2.getitemstring(ll_ctr,'vd_gl_cd')=ls_exp_gl then
					ll_count = ll_count+1
				end if
				
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error : During Select Expense Ledger : ',sqlca.sqlerrtext);
				return 1;		
			end if	
		next
		
		if ll_count = 0 then
			messagebox('Error','For Expense Voucher an Expense Ledger should Be Present In Detail Block')
			return
		end if		
	end if	
	
	/// check Debit & credit Conditions 
	ls_vou_type=dw_1.getitemstring(dw_1.getrow(),'vh_vou_type')
	
	if ls_vou_type ='JV' or ls_vou_type ='EXPV'  then
		if round(dw_2.getitemnumber(dw_2.getrow(),'tot_dr'), 2) <> round(dw_2.getitemnumber(dw_2.getrow(),'tot_Cr'),2) then
			messagebox('Error','Debit & Credit Amount Should Be Same In Detail Block')
			return
		end if
	elseif ls_vou_type='BPV' or ls_vou_type='CPV'  then
		if  dw_2.getitemnumber(dw_2.getrow(),'tot_dr') <= dw_2.getitemnumber(dw_2.getrow(),'tot_Cr') then
			messagebox('Error','The Total Debit Amount Should be More Than Total Credit Amount (In Case Of BPV and CPV voucher')
			return
		end if	
		
//		if ls_vou_type ='CPV' and (dw_2.getitemnumber(dw_2.getrow(),'tot_dr')>10000 or dw_2.getitemnumber(dw_2.getrow(),'tot_Cr')>10000) then
//			messagebox('Warning','The Total Debit or Credit Amount Should not be More 10000 in a Voucher (In Case Of CPV voucher)')
//			return 1
//		end if 

		 if ls_vou_type ='CPV' and (dw_2.getitemnumber(dw_2.getrow(),'tot_dr')>10000 or dw_2.getitemnumber(dw_2.getrow(),'tot_Cr')>10000) then
			ld_amount=0
			 for ll_row = 1 to DW_1.ROWCOUNT()
				ld_sgl_amt=0;ld_amount=0;setnull(ls_sgl_cd);
				 for ll_row2 = 1 to DW_2.ROWCOUNT()	
					ls_sgl_cd = dw_2.getitemstring(ll_row2,'vd_sgl_cd')
					ld_sgl_amt = dw_2.getitemnumber(ll_row2,'vd_Amount')
					
					
					select distinct 'X' into :ls_temp from fb_acsubledger where acsubledger_cv_chk='Y' and ACSUBLEDGER_ID=:ls_sgl_cd;
					if sqlca.sqlcode = -1 then
						messagebox('Sql Error: During Checking for Wages subledger for 10000 validation',sqlca.sqlerrtext)
						return 1
					elseif  sqlca.sqlcode = 100 then
						ld_amount =ld_amount+ld_sgl_amt;
						
						if ld_amount>10000 then
								messagebox('Warning','The Total Debit or Credit Amount Should not be More 10000 in a Voucher (In Case Of CPV voucher)')
								return 1
						end if
					end if;	
					
				 next
			next
		end if
		
		
		
	elseif ls_vou_type='BRV' or ls_vou_type='CRV' then
		if  dw_2.getitemnumber(dw_2.getrow(),'tot_dr') >= dw_2.getitemnumber(dw_2.getrow(),'tot_Cr') then
			messagebox('Error','The Total Credit Amount Should be More Than Total Debit Amount (In Case Of BRV and CRV voucher')
			return
		end if		
       end if;	
		
	/// Generate reference no
	if lb_neworder = true then
		select nvl(MAX(vh_doc_srl),0) into :ls_last from fb_vou_head;
		ls_last = right(ls_last,6)
		ll_cnt = long(ls_last)
		ll_cnt = ll_cnt + 1
		dw_1.setitem(dw_1.getrow(),'vh_doc_srl',ll_cnt)
		for ll_ctr = 1 to dw_2.rowcount()
			dw_2.setitem(ll_ctr,'vd_doc_srl',ll_cnt)
			dw_2.setitem(ll_ctr,'vd_ac_year',long(string(dw_1.getitemdatetime(dw_1.getrow(),'vh_vou_date'),'yyyymm')))
		next
	end if	
	
		  
if lb_neworder = false  then
     ///Generate voucher no
     long ll_vou_no,ll_fymm
           ll_vou_no = 0;ll_fymm=0		 
		  n_fames luo_fames
		  luo_fames = Create n_fames		

	  for ll_row = 1 to DW_1.ROWCOUNT()
		 if dw_1.getitemstring(ll_row,'appr_flag') = 'Y' then
			if (len(dw_1.getitemstring(ll_row,'vh_approved_by')) > 0) then
				
				if ll_vou_no = 0 then
					//ll_fymm     = dw_1.getitemnumber(ll_row,'vh_ac_year')
					ll_fymm     =  long(string(dw_1.getitemdatetime(ll_row,'vh_vou_date'),'yyyymm'))
					
					select distinct 'x' into :ls_temp from FB_SERIAL_NO 
					where SN_DOC_TYPE in ('JV','CV','BV','EV','RCIN') and SN_ACCT_YEAR=to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm');
					
					if sqlca.sqlcode = 100 then
						INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm')); 
						INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm')); 
						INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm'));
						INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'EV', 0, to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm'));
						INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'RCIN', 0, to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm'));
						commit using sqlca;
					end if
                  
					ll_vou_no = f_get_lastno(gs_opt,string(ll_fymm))
					
					if ll_vou_no < 0 then
						messagebox('Error At Last No Getting',sqlca.sqlerrtext)
						return 1
					end if
				else
					ll_vou_no = ll_vou_no + 1
				end if
		
				if ll_vou_no >= 0 then
					ls_count = string(ll_vou_no,'0000')
					ls_tmp_id =gs_opt+string(ll_fymm)+"-"+ls_count					
					dw_1.setitem(ll_row,'vh_vou_no',ls_tmp_id)	
					//dw_1.setitem(dw_1.getrow(),'vh_vou_date',datetime(today()))
				end if 
                 messagebox('Information;',' Voucher No Created :'+ls_tmp_id)
			
			ll_ref = dw_1.getitemnumber(ll_row,'VH_DOC_SRL')
			ls_vou_dt = string(dw_1.getitemdatetime(ll_row,'vh_vou_date'),'dd/mm/yyyy')
			
			///////////////////////////////		
			string ls_dedn_dt,ls_detail
			double ld_adv,ld_pf,ld_pfint,ld_emi,ld_adj_amt, ld_eladv, ld_meadv, ld_feadv
			
			declare c1 cursor for 
			select vd_gl_cd,vd_sgl_cd,vd_expsubhead,vd_amount,vd_dc_ind,vd_preferred_mes,vd_emp_id,
					decode(VD_LOAN_TYPE,'CO',vd_amount,0),decode(VD_LOAN_TYPE,'PF',vd_amount,0),nvl(VD_INT_AMT,0),
					VD_DETAIL,to_char(VD_DEDN_DATE,'dd/mm/yyyy'), nvl(VD_DEDN_EMI,0) ,VD_NARRATION_NO2,decode(VD_LOAN_TYPE,'EL',vd_amount,0),
					decode(VD_LOAN_TYPE,'ME',vd_amount,0),decode(VD_LOAN_TYPE,'FE',vd_amount,0)
			from fb_vou_det 
			where vd_doc_srl = :ll_ref;
							
			open c1;
		
			if sqlca.sqlcode = -1 then 
				messagebox('Error At Cursor','Error During Opening Cursor C1 : '+sqlca.sqlerrtext)
				return 1
			else
				setnull(ls_gl_cd);setnull(ls_sgl_cd);setnull(ls_expsubhead);setnull(ls_dc_ind);setnull(ls_preferred_mes);setnull(ls_empid);setnull(ls_detail);setnull(ls_dedn_dt);setnull(ls_lwwid)
				ld_amt=0;ld_adv=0;ld_pf=0;ld_pfint=0;ld_emi=0;ld_eladv = 0; ld_meadv = 0; ld_feadv = 0;
				
				fetch c1 into :ls_gl_cd,:ls_sgl_cd,:ls_expsubhead,:ld_amt,:ls_dc_ind,:ls_preferred_mes,:ls_empid,:ld_adv,:ld_pf,:ld_pfint,:ls_detail,:ls_dedn_dt,:ld_emi,:ls_lwwid,:ld_eladv, :ld_meadv, :ld_feadv;
				
				do while sqlca.sqlcode <> 100
						//New/Update DailyExpense
						
						 if (len(trim(ls_expsubhead)) > 0 and len(trim(ls_preferred_mes)) >0 ) then 
							ld_adj_amt=0
							
							if ls_dc_ind = 'C' then
								ld_adj_amt = ld_amt * -1 ; 
							else  
								ld_adj_amt= ld_amt ;
							end if
							
							if luo_fames.wf_upd_mes(string(dw_1.getitemdatetime(ll_row,'vh_vou_date'),'dd/mm/yyyy'),ls_expsubhead,ld_adj_amt,ls_preferred_mes,'N')  = -1 then 
								rollback using sqlca;
								return 1;
							end if;
						end if

						 if len(ls_empid) > 0   then 
							select EMP_TYPE into :ls_emp_type from fb_employee where emp_id = :ls_empid ;
							if sqlca.sqlcode = -1 then
								messagebox('Sql Error: During Employee Select',sqlca.sqlerrtext)
								return 1						
							end if;			
							
								if isnull(ld_adv) then ld_adv=0
								if isnull(ld_pf) then ld_pf=0
								if isnull(ld_pfint) then ld_pfint=0
								if isnull(ld_eladv) then ld_eladv=0
								if isnull(ld_meadv) then ld_meadv=0
								if isnull(ld_feadv) then ld_feadv=0
								  
							if ls_emp_type='LP' or ls_emp_type='LT' or ls_emp_type='LO' then	
								if ls_dc_ind ='D' then // Advance Paid to Labour
									string ls_adv_id;long ll_advcnt 
									setnull(ls_adv_id);ll_advcnt = 0
									
									select count(*) into :ll_advcnt from fb_labouradvance ;
									if sqlca.sqlcode = -1 then
										messagebox('Sql Error : Getting Advance ID (LP/LT/LO): ',sqlca.sqlerrtext);
										return 1;
									end if;  
									
									if isnull(ll_advcnt) then ll_advcnt=0
									ll_advcnt = ll_advcnt + 1
									
									ls_adv_id ='ADV'+string(ll_advcnt,'0000000')
									
									insert into fb_labouradvance (LA_ADVID,LABOUR_ID, LA_AMOUNT,LA_AMOUNTTOPAYTODATE, LA_DATE, LA_DESC, TRANSAC_ID, LA_PFADVANCE, LA_PFINTEREST,LA_DEDN_DATE,LA_DEDN_EMI,LA_ENTRY_BY, LA_ENTRY_DT,LA_ELECTADV, LA_MEDADV, LA_FESTADV)
									values (:ls_adv_id,:ls_empid,:ld_adv,0,to_date(:ls_vou_dt,'dd/mm/yyyy'),:ls_DETAIL,:ls_tmp_id,:ld_pf,:ld_pfint,to_date(:ls_dedn_dt,'dd/mm/yyyy'), :ld_EMI,:gs_user,trunc(sysdate),:ld_eladv, :ld_meadv, :ld_feadv);
									
									if sqlca.sqlcode = -1 then
										messagebox('Sql Error : Labour Advance Detail Insert (LP/LT/LO): ',sqlca.sqlerrtext);
										return 1;
									end if;  
								else	// Advance Realised from Labour
									
										select distinct 'x' into :ls_temp from fb_labadvancededuction where LABOUR_ID = :ls_empid and LWW_ID = :ls_lwwid;
										if sqlca.sqlcode = -1 then
											messagebox('Error : While Getting Labour Details',sqlca.sqlerrtext)
											rollback using sqlca;
											return 1
										elseif sqlca.sqlcode  = 100 then

											insert into fb_labadvancededuction (LABOUR_ID,ADVANCEDED,PFADVANCEDED,PFINTERESTDED, ELECTRICDED,ADVANCEDEDCASH,PFADVDEDCASH,PFINTDEDCASH, LWW_ID, LAD_DATE, LAD_ENTRY_BY,ELECADVDED,MEDADVDED, FESTADVDED)
											values(:ls_empid,0,0,0,0,:ld_adv,(nvl(:ld_pf,0) - nvl(:ld_pfint,0)),:ld_pfint,:ls_lwwid,trunc(sysdate),:gs_user, :ld_eladv, :ld_meadv, :ld_feadv);
											
											if sqlca.sqlcode = -1 then
												messagebox('Error : While Inserting Record',sqlca.sqlerrtext)
												rollback using sqlca;
												return 1
											end if
										elseif sqlca.sqlcode  = 0 then
//											update fb_labadvancededuction 
//												 set ADVANCEDEDCASH = (nvl(ADVANCEDEDCASH,0) + nvl(:ld_adv,0)) ,
//												 	  PFADVDEDCASH = (nvl(PFADVDEDCASH,0) + (nvl(:ld_pf,0) - nvl(:ld_pfint,0))) ,
//													  PFINTDEDCASH = (nvl(PFINTDEDCASH,0) + nvl(:ld_pfint,0)),
//													  LAD_DATE = trunc(sysdate), LAD_ENTRY_BY = :gs_user
//											where LABOUR_ID = :ls_empid and LWW_ID = :ls_lwwid;
											
											update fb_labadvancededuction 
												 set ADVANCEDEDCASH = (nvl(ADVANCEDEDCASH,0) + nvl(:ld_adv,0)) ,
												 	  PFADVDEDCASH = (nvl(PFADVDEDCASH,0) + (nvl(:ld_pf,0) - nvl(:ld_pfint,0))) ,
													  PFINTDEDCASH = (nvl(PFINTDEDCASH,0) + nvl(:ld_pfint,0)),
													  ELECADVDED = (nvl(ELECADVDED,0) + nvl(:ld_eladv,0)),
													  MEDADVDED = (nvl(MEDADVDED,0) + nvl(:ld_meadv,0)),
													  FESTADVDED = (nvl(FESTADVDED,0) + nvl(:ld_feadv,0)),
													  LAD_DATE = trunc(sysdate), LAD_ENTRY_BY = :gs_user
											where LABOUR_ID = :ls_empid and LWW_ID = :ls_lwwid;											
											
											if sqlca.sqlcode = -1 then
												messagebox('Error : While Updating labadvancededuction table',sqlca.sqlerrtext)
												rollback using sqlca;
												return 1
											end if
										end if	
									
								end if	 
							elseif ls_emp_type = 'SS' or ls_emp_type = 'ST' or ls_emp_type = 'AT' then	 
								if ls_dc_ind ='D' then // Advance Paid to Staff/Substaff/Apprentice

									insert into fb_empadvance (EMP_ID, EMP_ADVANCEAMOUNT,EMP_AMOUNTTOPAYTODATE, EMP_DATE, EMP_DESC, TRANSAC_ID, EMP_PFADVANCE, EMP_PFINTEREST,EMP_INSTALLMENT, EMP_DED_DT, EMP_ENTRY_BY, EMP_ENTRY_DT,EMP_ELECADVANCE, EMP_MEDADVANCE, EMP_FESTADVANCE)
									values (:ls_empid,:ld_adv,0,to_date(:ls_vou_dt,'dd/mm/yyyy'),:ls_DETAIL,:ls_tmp_id,:ld_pf,:ld_pfint,:ld_EMI,to_date(:ls_dedn_dt,'dd/mm/yyyy'), :gs_user,trunc(sysdate),:ld_eladv, :ld_meadv, :ld_feadv);
										 
									 if sqlca.sqlcode = -1 then
										messagebox('Sql Error :  Labour Advance Detail Insert (Others) : ',sqlca.sqlerrtext);
										return 1;
									end if;  			
									
								else	// Advance Realised from Staff/Substaff/Apprentice
									
										select distinct 'x' into :ls_temp from fb_empwisededuction where EMP_ID = :ls_empid and ((ewd_year * 100) + ewd_month) = to_number(to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'YYYYMM'));
										if sqlca.sqlcode = -1 then
											messagebox('Error : While Getting Emp deduction Details',sqlca.sqlerrtext)
											rollback using sqlca;
											return 1
										elseif sqlca.sqlcode  = 100 then

											insert into fb_empwisededuction (EMP_ID,EWD_ADVANCEDED,EWD_PFADVDED, EWD_RATIONDED,EWD_ELECTRICDED,EWD_LIPDED, EWD_MONTH, EWD_YEAR	, EWD_ENTRY_BY, EWD_ENTRY_DT,EWD_VOU_SAL,EWD_MEDADVDED, EWD_FESTADVDED)
											values(:ls_empid,:ld_adv,:ld_pf,0,:ld_eladv,0,to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'MM'),to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'YYYY'),:gs_user, to_date(:ls_vou_dt,'dd/mm/yyyy'),'V',:ld_meadv, :ld_feadv);
											
											if sqlca.sqlcode = -1 then
												messagebox('Error : While Inserting Record',sqlca.sqlerrtext)
												rollback using sqlca;
												return 1
											end if
										elseif sqlca.sqlcode  = 0 then
//											update fb_empwisededuction 
//												 set EWD_ADVANCEDED = (nvl(EWD_ADVANCEDED,0) + nvl(:ld_adv,0)) ,
//												 	  EWD_PFADVDED = (nvl(EWD_PFADVDED,0) + nvl(:ld_pf,0)) ,
//													  EWD_MONTH = to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'MM'), EWD_YEAR = to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'YYYY'),
//													  EWD_ENTRY_DT = trunc(sysdate), EWD_ENTRY_BY = :gs_user
//											where EMP_ID = :ls_empid and ((ewd_year * 100) + ewd_month) = to_number(to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'YYYYMM'));


											update fb_empwisededuction 
												 set EWD_ADVANCEDED = (nvl(EWD_ADVANCEDED,0) + nvl(:ld_adv,0)) ,
												 	  EWD_PFADVDED = (nvl(EWD_PFADVDED,0) + nvl(:ld_pf,0)) ,
													  EWD_ELECTRICDED = (nvl(EWD_ELECTRICDED,0) + nvl(:ld_eladv,0)) ,
													  EWD_MEDADVDED = (nvl(EWD_MEDADVDED,0) + nvl(:ld_meadv,0)) ,
													  EWD_FESTADVDED = (nvl(EWD_FESTADVDED,0) + nvl(:ld_feadv,0)) ,
													  EWD_MONTH = to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'MM'), EWD_YEAR = to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'YYYY'),
													  EWD_ENTRY_DT = trunc(sysdate), EWD_ENTRY_BY = :gs_user
											where EMP_ID = :ls_empid and ((ewd_year * 100) + ewd_month) = to_number(to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'YYYYMM'));		
											
											if sqlca.sqlcode = -1 then
												messagebox('Error : While Updating fb_empwisededuction table',sqlca.sqlerrtext)
												rollback using sqlca;
												return 1
											end if
										end if	
									
								end if

							end if;				
					end if	

					setnull(ls_gl_cd);setnull(ls_sgl_cd);setnull(ls_expsubhead);setnull(ls_dc_ind);setnull(ls_preferred_mes);setnull(ls_empid);setnull(ls_detail);setnull(ls_dedn_dt);setnull(ls_lwwid)
					ld_amt=0;ld_adv=0;ld_pf=0;ld_pfint=0;ld_emi=0; ld_eladv = 0; ld_meadv = 0; ld_feadv = 0;
					
					fetch c1 into :ls_gl_cd,:ls_sgl_cd,:ls_expsubhead,:ld_amt,:ls_dc_ind,:ls_preferred_mes,:ls_empid,:ld_adv,:ld_pf,:ld_pfint,:ls_detail,:ls_dedn_dt,:ld_emi,:ls_lwwid,:ld_eladv, :ld_meadv, :ld_feadv;

				loop
				close c1;
				
		//	GST Start
//			if ls_gst_ind = 'Y' then
				declare c3 cursor for 
					select vd_functions,vd_business_segment,vd_doc_srl,vh_vou_no,vd_user_id,to_char(vd_entry_dt,'dd/mm/yyyy'),VD_REF_NO,
											  to_char(VD_REF_DATE,'dd/mm/yyyy'),VD_CO_ID,VD_PARTY_CD,
								  VD_HSN_CD, VD_CGST_RECGL, VD_SGST_RECGL, VD_IGST_RECGL, VD_CGST_PAYGL, VD_SGST_PAYGL, VD_IGST_PAYGL, VD_GST_SUNDRY_PAY, 
											  VD_CGST_RECSGL, VD_SGST_RECSGL, VD_IGST_RECSGL, VD_CGST_PAYSGL, VD_SGST_PAYSGL, VD_IGST_PAYSGL, VD_GST_SUNDRY_PAYSGL,
								  VD_GST_IND, VD_REVCHG_IND, VD_REVCHG_CATG, VD_PARTY_GSTN, VD_PARTY_GSTNSTATE,VD_amount, VD_CGST_PRCNT, VD_SGST_PRCNT, VD_IGST_PRCNT, VD_CGST_AMT, VD_SGST_AMT, VD_IGST_AMT
						from fb_vou_det , fb_vou_head 
						where vh_doc_srl = vd_doc_srl and vd_doc_srl = :ll_ref and nvl(VD_amount,0) > 0 ; 								
				open c3;
			
				if sqlca.sqlcode = -1 then 
					messagebox('Error At Cursor','Error During Opening Cursor C3 : '+sqlca.sqlerrtext)
					return 1
				else
					setnull(ls_functions);setnull(ls_business_segment);setnull(ls_vou_no);setnull(ls_TDS_GL);setnull(ls_user_id);setnull(ls_REF_NO);setnull(ls_CO_ID);setnull(ls_PARTY_tds);setnull( ls_REF_DATE);setnull(ls_entry_dt);
					
					setnull(ls_hsn_cd); setnull(ls_cgst_recgl); setnull(ls_sgst_recgl); setnull(ls_igst_recgl); setnull(ls_cgst_paygl); setnull(ls_sgst_paygl); setnull(ls_igst_paygl); setnull(ls_gst_sundry_pay); 
					setnull(ls_cgst_recsgl); setnull(ls_sgst_recsgl); setnull(ls_igst_recsgl); setnull(ls_cgst_paysgl); setnull(ls_sgst_paysgl); setnull(ls_igst_paysgl); setnull(ls_gst_sundry_paysgl);
					setnull(ls_gst_ind); setnull(ls_revchg_ind); setnull(ls_party_gstin); setnull(ls_party_gstinstcd);
					ll_docsrl=0; ld_bill_amt = 0; ld_cgst_prcnt = 0; ld_sgst_prcnt = 0; ld_igst_prcnt = 0; ld_cgst_amt = 0; ld_sgst_amt = 0; ld_igst_amt = 0; setnull(ls_rev_catg);
					
					fetch c3 into :ls_functions,:ls_business_segment,:ll_docsrl,:ls_vou_no,:ls_user_id,:ls_entry_dt,:ls_REF_NO,:ls_REF_DATE,:ls_CO_ID,:ls_PARTY_tds,:ls_hsn_cd, 
									:ls_cgst_recgl, :ls_sgst_recgl, :ls_igst_recgl, :ls_cgst_paygl, :ls_sgst_paygl, :ls_igst_paygl, :ls_gst_sundry_pay,
									:ls_cgst_recsgl, :ls_sgst_recsgl, :ls_igst_recsgl, :ls_cgst_paysgl, :ls_sgst_paysgl, :ls_igst_paysgl, :ls_gst_sundry_paysgl, 
									:ls_gst_ind, :ls_revchg_ind, :ls_rev_catg, :ls_party_gstin, :ls_party_gstinstcd, :ld_bill_amt, :ld_cgst_prcnt, :ld_sgst_prcnt, :ld_igst_prcnt, :ld_cgst_amt, :ld_sgst_amt, :ld_igst_amt;
					
					do while sqlca.sqlcode <> 100	
						
					if isnull(ls_revchg_ind) then ls_revchg_ind = 'N';
					
					if not isnull(ls_REF_NO) then ls_billno = ls_REF_NO;
					if not isnull(ls_REF_DATE) then ls_billdt = ls_REF_DATE;
					string ls_temp2 
					setnull(ls_temp2);
						
					 if ls_revchg_ind = 'Y'  then
						select distinct 'x' into :ls_temp2 from FB_SERIAL_NO where SN_DOC_TYPE =  'RCIN' and SN_ACCT_YEAR=to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm');
							
						if sqlca.sqlcode = 100 then
							INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'RCIN', 0, to_char(to_date(:ll_fymm,'yyyymm'),'yyyymm'));
							commit using sqlca;
						end if
						//-- Getting The Serial No
						 select nvl(sn_srl_no,0)+1 into :ll_dcno from fb_serial_no  where sn_doc_type = 'RCIN' and SN_ACCT_YEAR = to_number(:ll_fymm) for update;
						if sqlca.sqlcode = -1 then 		 
							messagebox('Sql Error: During Getting Reverse Charge No ',sqlca.sqlerrtext);
							rollback using sqlca;
							return -1;
						end if;		
						
						select 'RC/'||:gs_garden_snm||'/'||decode(sign(to_number(to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'mm')) - 04),-1,to_number(to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'yyyy'))-1||to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'mm'),to_number(to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'yyyy'))||to_char(to_date(:ls_vou_dt,'dd/mm/yyyy'),'mm'))||'/'||lpad(:ll_dcno,3,'0')  into :ls_revinvno
						from dual;
				
						update fb_serial_no set sn_srl_no = nvl(sn_srl_no,0) + 1   where sn_doc_type = 'RCIN' and  SN_ACCT_YEAR = to_number(:ll_fymm);
						if sqlca.sqlcode = -1 then 		 
							messagebox('Sql Error: During Updating Reverse Charge No ',sqlca.sqlerrtext);
							rollback using sqlca;
							return -1;
						end if;	
						
						insert into FB_REVCHARGE_INVOICE (RCI_CO_CD, RCI_UNITCD, RCI_HSN_CODE, RCI_UOM, RCI_QNTY, RCI_RATE, RCI_AMOUNT, 
																		 RCI_SGST_RATE, RCI_CGST_RATE, RCI_IGST_RATE, RCI_SGST_AMT, RCI_CGST_AMT, RCI_IGST_AMT, RCI_TOTAL_AMT, 
																		 RCI_INVOICE_NO, RCI_INVOICE_DT, RCI_REF_NO, RCI_REF_DT, RCI_PARTY_CD, rci_item_catg)
						values (:gs_CO_ID,:gs_garden_snm,:ls_hsn_cd,'Kg',1,nvl(:ld_bill_amt,0), nvl(:ld_bill_amt,0) , :ld_sgst_prcnt,:ld_cgst_prcnt,:ld_igst_prcnt, :ld_sgst_amt,:ld_cgst_amt,:ld_igst_amt,
									  (nvl(:ld_cgst_amt,0) + nvl(:ld_sgst_amt,0) + nvl(:ld_igst_amt,0) + nvl(:ld_bill_amt,0)), :ls_revinvno,to_date(:ls_vou_dt,'dd/mm/yyyy'),:ls_tmp_id,to_date(:ls_vou_dt,'dd/mm/yyyy'),:ls_PARTY_tds, :ls_rev_catg);
						
						
						if sqlca.sqlcode = -1 then
							messagebox('Sql Error : During Reverse Charge Insert (Auto): ',sqlca.sqlerrtext);
							rollback using sqlca;
							return -1;
						end if;  
		
						If ld_cgst_amt > 0 and ( not isnull(ls_cgst_recgl) or len(ls_cgst_recgl) > 0) then
						// Find Credit CGST payable
						//	:ls_cgst_recgl, :ls_sgst_recgl, :ls_igst_recgl, :ls_cgst_paygl, :ls_sgst_paygl, :ls_igst_paygl, :ls_gst_sundry_pay
							// insert into Voucher Detail for supplier_val
							insert into fb_vou_det (vd_functions,vd_business_segment,vd_doc_srl,vd_vou_no,vd_gl_cd,vd_sgl_cd,vd_dc_ind,vd_amount,vd_detail,vd_user_id,vd_entry_dt,VD_REF_NO,VD_REF_DATE,VD_CO_ID,VD_PARTY_CD,VD_BILL_AMT,VD_CGST_PRCNT)
							values(:ls_functions,:ls_business_segment,:ll_docsrl,:ls_vou_no,:ls_cgst_recgl,:ls_cgst_recsgl,'D',:ld_cgst_amt,'CGST Recoverable Auto Entry',:ls_user_id,to_date(:ls_entry_dt,'dd/mm/yyyy'),:ls_billno,to_date(:ls_billdt,'dd/mm/yyyy'),:gs_CO_ID,:ls_PARTY_tds,:ld_bill_amt,:ld_cgst_prcnt);
							
							if sqlca.sqlcode = -1 then 		 
								  messagebox('Sql Error: During Insertion CGST Recoverable Detail (Dr) ',sqlca.sqlerrtext);
								  rollback using sqlca;
								  return -1;
							end if;	
						end if
							
						If ld_sgst_amt > 0 and (not isnull(ls_sgst_recgl) or len(ls_sgst_recgl) > 0) then
							insert into fb_vou_det (vd_functions,vd_business_segment,vd_doc_srl,vd_vou_no,vd_gl_cd,vd_sgl_cd,vd_dc_ind,vd_amount,vd_detail,vd_user_id,vd_entry_dt,VD_REF_NO,VD_REF_DATE,VD_CO_ID,VD_PARTY_CD,VD_BILL_AMT,VD_SGST_PRCNT)
							values(:ls_functions,:ls_business_segment,:ll_docsrl,:ls_vou_no,:ls_sgst_recgl,:ls_sgst_recsgl, 'D',:ld_sgst_amt,'SGST Recoverable Auto Entry',:ls_user_id,to_date(:ls_entry_dt,'dd/mm/yyyy'),:ls_billno,to_date(:ls_billdt,'dd/mm/yyyy'),:gs_CO_ID,:ls_PARTY_tds,:ld_bill_amt,:ld_sgst_prcnt);
							
							if sqlca.sqlcode = -1 then 		 
								  messagebox('Sql Error: During Insertion SGST Recoverable Detail (Dr) ',sqlca.sqlerrtext);
								  rollback using sqlca;
								  return -1;
							end if;	
						end if
		
						If ld_igst_amt > 0 and (not isnull(ls_igst_recgl) or len(ls_igst_recgl) > 0) then
							insert into fb_vou_det (vd_functions,vd_business_segment,vd_doc_srl,vd_vou_no,vd_gl_cd,vd_sgl_cd,vd_dc_ind,vd_amount,vd_detail,vd_user_id,vd_entry_dt,VD_REF_NO,VD_REF_DATE,VD_CO_ID,VD_PARTY_CD,VD_BILL_AMT,VD_IGST_PRCNT)
							values(:ls_functions,:ls_business_segment,:ll_docsrl,:ls_vou_no,:ls_igst_recgl,:ls_igst_recsgl,'D',:ld_igst_amt,'IGST Recoverable Auto Entry',:ls_user_id,to_date(:ls_entry_dt,'dd/mm/yyyy'),:ls_billno,to_date(:ls_billdt,'dd/mm/yyyy'),:gs_CO_ID,:ls_PARTY_tds,:ld_bill_amt,:ld_igst_prcnt);
							
							if sqlca.sqlcode = -1 then 		 
								  messagebox('Sql Error: During Insertion SGST Recoverable Detail (Dr) ',sqlca.sqlerrtext);
								  rollback using sqlca;
								  return -1;
							end if;	
						end if
						
						If ld_cgst_amt > 0 and (not isnull(ls_cgst_paygl) or len(ls_cgst_paygl) > 0) then
						// Find Credit CGST payable
						//	:ls_cgst_recgl, :ls_sgst_recgl, :ls_igst_recgl, :ls_cgst_paygl, :ls_sgst_paygl, :ls_igst_paygl, :ls_gst_sundry_pay
							// insert into Voucher Detail for supplier_val
							insert into fb_vou_det (vd_functions,vd_business_segment,vd_doc_srl,vd_vou_no,vd_gl_cd,vd_sgl_cd,vd_dc_ind,vd_amount,vd_detail,vd_user_id,vd_entry_dt,VD_REF_NO,VD_REF_DATE,VD_CO_ID,VD_PARTY_CD,VD_BILL_AMT,VD_CGST_PRCNT)
							values(:ls_functions,:ls_business_segment,:ll_docsrl,:ls_vou_no,:ls_cgst_paygl,:ls_cgst_paysgl,'C',:ld_cgst_amt,'CGST Payable Auto Entry',:ls_user_id,to_date(:ls_entry_dt,'dd/mm/yyyy'),:ls_billno,to_date(:ls_billdt,'dd/mm/yyyy'),:gs_CO_ID,:ls_PARTY_tds,:ld_bill_amt,:ld_cgst_prcnt);
							
							if sqlca.sqlcode = -1 then 		 
								  messagebox('Sql Error: During Insertion CGST Recoverable Detail (Cr) ',sqlca.sqlerrtext);
								  rollback using sqlca;
								  return -1;
							end if;	
						end if
							
						If ld_sgst_amt > 0 and (not isnull(ls_sgst_paygl) or len(ls_sgst_paygl) > 0) then
							insert into fb_vou_det (vd_functions,vd_business_segment,vd_doc_srl,vd_vou_no,vd_gl_cd,vd_sgl_cd,vd_dc_ind,vd_amount,vd_detail,vd_user_id,vd_entry_dt,VD_REF_NO,VD_REF_DATE,VD_CO_ID,VD_PARTY_CD,VD_BILL_AMT,VD_SGST_PRCNT)
							values(:ls_functions,:ls_business_segment,:ll_docsrl,:ls_vou_no,:ls_sgst_paygl,:ls_sgst_paysgl,'C',:ld_sgst_amt,'SGST Payable Auto Entry',:ls_user_id,to_date(:ls_entry_dt,'dd/mm/yyyy'),:ls_billno,to_date(:ls_billdt,'dd/mm/yyyy'),:gs_CO_ID,:ls_PARTY_tds,:ld_bill_amt,:ld_sgst_prcnt);
							
							if sqlca.sqlcode = -1 then 		 
								  messagebox('Sql Error: During Insertion SGST Recoverable Detail (Cr) ',sqlca.sqlerrtext);
								  rollback using sqlca;
								  return -1;
							end if;	
						end if
		
						If ld_igst_amt > 0 and (not isnull(ls_igst_paygl) or len(ls_igst_paygl) > 0) then
							insert into fb_vou_det (vd_functions,vd_business_segment,vd_doc_srl,vd_vou_no,vd_gl_cd,vd_sgl_cd,vd_dc_ind,vd_amount,vd_detail,vd_user_id,vd_entry_dt,VD_REF_NO,VD_REF_DATE,VD_CO_ID,VD_PARTY_CD,VD_BILL_AMT,VD_IGST_PRCNT)
							values(:ls_functions,:ls_business_segment,:ll_docsrl,:ls_vou_no,:ls_igst_paygl,:ls_igst_paysgl,'C',:ld_igst_amt,'IGST Payable Auto Entry',:ls_user_id,to_date(:ls_entry_dt,'dd/mm/yyyy'),:ls_billno,to_date(:ls_billdt,'dd/mm/yyyy'),:gs_CO_ID,:ls_PARTY_tds,:ld_bill_amt,:ld_igst_prcnt);
							
							if sqlca.sqlcode = -1 then 		 
								  messagebox('Sql Error: During Insertion IGST Payable Detail (Cr) ',sqlca.sqlerrtext);
								  rollback using sqlca;
								  return -1;
							end if;	
						end if						
					else						
						insert into FB_GST_PAYABLE (GP_VOU_NO, GP_VOU_DT, GP_CO_CD, GP_UNIT_SN, GP_HSN_CODE, GP_UOM, GP_QNTY, GP_RATE, GP_PARTY, GP_BILL_NO, GP_BILL_DT, GP_AMOUNT, 
																GP_SGST_RATE, GP_CGST_RATE, GP_IGST_RATE, GP_SGST_AMT, GP_CGST_AMT, GP_IGST_AMT,  GP_TOTAL_AMOUNT, gp_item_catg)
						values( :ls_tmp_id,to_date(:ls_vou_dt,'dd/mm/yyyy'),:gs_CO_ID,:gs_garden_snm,:ls_hsn_cd,'Kg',1, nvl(:ld_bill_amt,0) , :ls_PARTY_tds, :ls_billno, to_date(:ls_billdt,'dd/mm/yyyy'),
								 nvl(:ld_bill_amt,0) ,  :ld_sgst_prcnt,:ld_cgst_prcnt,:ld_igst_prcnt, :ld_sgst_amt,:ld_cgst_amt,:ld_igst_amt,
									  (nvl(:ld_cgst_amt,0) + nvl(:ld_sgst_amt,0) + nvl(:ld_igst_amt,0) + nvl(:ld_bill_amt,0)) , :ls_rev_catg);

						
						if sqlca.sqlcode = -1 then
							messagebox('Sql Error : During GST Payable Insert (Auto): ',sqlca.sqlerrtext);
							rollback using sqlca;
							return -1;
						end if;  
						If ld_cgst_amt > 0 and (not isnull(ls_cgst_recgl) or len(ls_cgst_recgl) > 0) then
						// Find Credit CGST payable
						//	:ls_cgst_recgl, :ls_sgst_recgl, :ls_igst_recgl, :ls_cgst_paygl, :ls_sgst_paygl, :ls_igst_paygl, :ls_gst_sundry_pay
							// insert into Voucher Detail for supplier_val
							insert into fb_vou_det (vd_functions,vd_business_segment,vd_doc_srl,vd_vou_no,vd_gl_cd,vd_sgl_cd,vd_dc_ind,vd_amount,vd_detail,vd_user_id,vd_entry_dt,VD_REF_NO,VD_REF_DATE,VD_CO_ID,VD_PARTY_CD,VD_BILL_AMT,VD_CGST_PRCNT)
							values(:ls_functions,:ls_business_segment,:ll_docsrl,:ls_vou_no,:ls_cgst_recgl,:ls_cgst_recsgl,'D',:ld_cgst_amt,'CGST Recoverable Auto Entry',:ls_user_id,to_date(:ls_entry_dt,'dd/mm/yyyy'),:ls_billno,to_date(:ls_billdt,'dd/mm/yyyy'),:gs_CO_ID,:ls_PARTY_tds,:ld_bill_amt,:ld_cgst_prcnt);
							
							if sqlca.sqlcode = -1 then 		 
								  messagebox('Sql Error: During Insertion CGST Recoverable Detail (Dr) ',sqlca.sqlerrtext);
								  rollback using sqlca;
								  return -1;
							end if;	
						end if 
							
						If ld_sgst_amt > 0 and (not isnull(ls_sgst_recgl) or len(ls_sgst_recgl) > 0) then
							insert into fb_vou_det (vd_functions,vd_business_segment,vd_doc_srl,vd_vou_no,vd_gl_cd,vd_sgl_cd,vd_dc_ind,vd_amount,vd_detail,vd_user_id,vd_entry_dt,VD_REF_NO,VD_REF_DATE,VD_CO_ID,VD_PARTY_CD,VD_BILL_AMT,VD_SGST_PRCNT)
							values(:ls_functions,:ls_business_segment,:ll_docsrl,:ls_vou_no,:ls_sgst_recgl,:ls_sgst_recsgl,'D',:ld_sgst_amt,'SGST Recoverable Auto Entry',:ls_user_id,to_date(:ls_entry_dt,'dd/mm/yyyy'),:ls_billno,to_date(:ls_billdt,'dd/mm/yyyy'),:gs_CO_ID,:ls_PARTY_tds,:ld_bill_amt,:ld_sgst_prcnt);
							
							if sqlca.sqlcode = -1 then 		 
								  messagebox('Sql Error: During Insertion SGST Recoverable Detail (Dr) ',sqlca.sqlerrtext);
								  rollback using sqlca;
								  return -1;
							end if;	
						end if
		
						If ld_igst_amt > 0 and (not isnull(ls_igst_recgl) or len(ls_igst_recgl) > 0) then
							insert into fb_vou_det (vd_functions,vd_business_segment,vd_doc_srl,vd_vou_no,vd_gl_cd,vd_sgl_cd,vd_dc_ind,vd_amount,vd_detail,vd_user_id,vd_entry_dt,VD_REF_NO,VD_REF_DATE,VD_CO_ID,VD_PARTY_CD,VD_BILL_AMT,VD_IGST_PRCNT)
							values(:ls_functions,:ls_business_segment,:ll_docsrl,:ls_vou_no,:ls_igst_recgl,:ls_igst_recsgl,'D',:ld_igst_amt,'IGST Recoverable Auto Entry',:ls_user_id,to_date(:ls_entry_dt,'dd/mm/yyyy'),:ls_billno,to_date(:ls_billdt,'dd/mm/yyyy'),:gs_CO_ID,:ls_PARTY_tds,:ld_bill_amt,:ld_igst_prcnt);
							
							if sqlca.sqlcode = -1 then 		 
								  messagebox('Sql Error: During Insertion SGST Recoverable Detail (Dr) ',sqlca.sqlerrtext);
								  rollback using sqlca;
								  return -1;
							end if;	
						end if
						
						If (ld_cgst_amt + ld_igst_amt + ld_sgst_amt) > 0 and (not isnull(ls_gst_sundry_pay) or len(ls_gst_sundry_pay) > 0) then
							insert into fb_vou_det (vd_functions,vd_business_segment,vd_doc_srl,vd_vou_no,vd_gl_cd,vd_sgl_cd,vd_dc_ind,vd_amount,vd_detail,vd_user_id,vd_entry_dt,VD_REF_NO,VD_REF_DATE,VD_CO_ID,VD_PARTY_CD,VD_BILL_AMT)
							values(:ls_functions,:ls_business_segment,:ll_docsrl,:ls_vou_no,:ls_gst_sundry_pay,:ls_gst_sundry_paysgl,'C',(nvl(:ld_cgst_amt,0) + nvl(:ld_sgst_amt,0) + nvl(:ld_igst_amt,0)),'Sundry Payable Auto Entry',:ls_user_id,to_date(:ls_entry_dt,'dd/mm/yyyy'),:ls_billno,to_date(:ls_billdt,'dd/mm/yyyy'),:gs_CO_ID,:ls_PARTY_tds,:ld_bill_amt);
							
							if sqlca.sqlcode = -1 then 		 
								  messagebox('Sql Error: During Insertion Sundry Payable Detail Cr) ',sqlca.sqlerrtext);
								  rollback using sqlca;
								  return -1;
							end if;	
						end if;
					end if;		
				//
				//====		
	
						
					setnull(ls_hsn_cd); setnull(ls_cgst_recgl); setnull(ls_sgst_recgl); setnull(ls_igst_recgl); setnull(ls_cgst_paygl); setnull(ls_sgst_paygl); setnull(ls_igst_paygl); setnull(ls_gst_sundry_pay); 
					setnull(ls_cgst_recsgl); setnull(ls_sgst_recsgl); setnull(ls_igst_recsgl); setnull(ls_cgst_paysgl); setnull(ls_sgst_paysgl); setnull(ls_igst_paysgl); setnull(ls_gst_sundry_paysgl);
					setnull(ls_gst_ind); setnull(ls_revchg_ind); setnull(ls_party_gstin); setnull(ls_party_gstinstcd);
					ll_docsrl=0; ld_bill_amt = 0; ld_cgst_prcnt = 0; ld_sgst_prcnt = 0; ld_igst_prcnt = 0; ld_cgst_amt = 0; ld_sgst_amt = 0; ld_igst_amt = 0; setnull(ls_rev_catg);
					
					fetch c3 into :ls_functions,:ls_business_segment,:ll_docsrl,:ls_vou_no,:ls_user_id,:ls_entry_dt,:ls_REF_NO,:ls_REF_DATE,:ls_CO_ID,:ls_PARTY_tds,:ls_hsn_cd, 
									:ls_cgst_recgl, :ls_sgst_recgl, :ls_igst_recgl, :ls_cgst_paygl, :ls_sgst_paygl, :ls_igst_paygl, :ls_gst_sundry_pay,
									:ls_cgst_recsgl, :ls_sgst_recsgl, :ls_igst_recsgl, :ls_cgst_paysgl, :ls_sgst_paysgl, :ls_igst_paysgl, :ls_gst_sundry_paysgl, 
									:ls_gst_ind, :ls_revchg_ind, :ls_rev_catg, :ls_party_gstin, :ls_party_gstinstcd, :ld_bill_amt, :ld_cgst_prcnt, :ld_sgst_prcnt, :ld_igst_prcnt, :ld_cgst_amt, :ld_sgst_amt, :ld_igst_amt;
	
					loop
					close c3;
				end if;   
////			end if //if ls_gst_ind = 'Y' then
		//	GST END
				
				
				if ll_ref > 0 then
					///	-- Diffrence amount For Cash/Bank(ContraGL) Voucher
					if ls_vou_type ='CRV' or ls_vou_type ='CPV' or ls_vou_type ='BRV' or ls_vou_type ='BPV' then	
				
						select (sum(decode(vd_dc_ind,'D',nvl(vd_amount,0),0)) - sum(decode(vd_dc_ind,'C',nvl(vd_amount,0),0)))
							into :ld_vou_bal from fb_vou_det where VD_DOC_SRL = :ll_ref ;
			
						if sqlca.sqlcode = -1 then
							messagebox('Sql Error : During select difference Amount of Voucher ',sqlca.sqlerrtext);
							rollback using sqlca;
							return 1;
						end if; 
						
						if ls_vou_type ='CRV' or ls_vou_type ='CPV' then
							 ls_contra_gl=dw_1.getitemstring(ll_row,'vh_contra_gl')
							 ls_contra_sgl=dw_1.getitemstring(ll_row,'vh_contra_sgl')
															
							insert into fb_vou_det (vd_functions,vd_business_segment,vd_doc_srl,vd_gl_cd,vd_sgl_cd,vd_dc_ind,vd_amount,vd_detail,vd_user_id,vd_entry_dt)
							values ('PLT',:gs_garden_snm,:ll_ref,:ls_contra_gl,:ls_contra_sgl,decode(sign(:ld_vou_bal),-1,'D','C'),
										 decode(sign(:ld_vou_bal),-1,(nvl(:ld_vou_bal,0) * (-1)) ,nvl(:ld_vou_bal,0)),'Auto Generated',:gs_user,sysdate);
			
							if sqlca.sqlcode = -1 then
								messagebox('Sql Error : During Voucher Detail Insert (Cash): ',sqlca.sqlerrtext);
								rollback using sqlca;
								return 1;
							end if;  
	
						else
							//-- for BANK VOUCHER	
							  ls_contra_gl=dw_1.getitemstring(ll_row,'vh_contra_gl')
							  ls_contra_sgl=dw_1.getitemstring(ll_row,'vh_contra_sgl')
							  ls_chq_no = dw_1.getitemstring(ll_row,'vh_cheque_no')
							  ld_voudt = dw_1.getitemdatetime(dw_1.getrow(),'vh_vou_date')
							  
							  
								insert into fb_vou_det (vd_functions,vd_business_segment,vd_doc_srl,vd_gl_cd,vd_sgl_cd,vd_dc_ind,vd_amount,vd_detail,vd_user_id,vd_entry_dt, vd_chq_no,VD_CHEQUE_DT)
								values ('PLT',:gs_garden_snm,:ll_ref,:ls_contra_gl,:ls_contra_sgl,decode(sign(:ld_vou_bal),-1,'D','C'),
												  decode(sign(:ld_vou_bal),-1,(nvl(:ld_vou_bal,0) * (-1)) ,nvl(:ld_vou_bal,0)),'Auto Generated',:gs_user,sysdate,:ls_chq_no, :ld_voudt);
				
								if sqlca.sqlcode = -1 then
									messagebox('Sql Error : During Voucher Detail Insert (Bank) : ',sqlca.sqlerrtext);
									return 1;
								end if;  
									
						 end if;
					end if;
				end if
					////-- End Diffrence amount For Cash/Bank(ContraGL) Voucher
			end if
			
			///////////////////////////////
					
			end if
		  end if	// END Approval check
	  next
	DESTROY n_fames
end if
	
if dw_1.update(true,false) = 1 then
	if dw_2.update(true,false) = 1 then
		if ll_vou_no > 0 then
		   ///update last no
			if f_upd_lastno(gs_opt,string(ll_fymm),ll_vou_no) = -1 then
				rollback using sqlca;			
				return 1
			end if	
		end if
		dw_2.resetupdate();
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		cb_1.enabled = true
		dw_1.reset()
		dw_2.reset()		
		dw_2.settaborder('vd_functions',0)	
		dw_2.settaborder('vd_business_segment',0)	
		dw_2.settaborder('vd_gl_cd',10)	
		dw_2.settaborder('vd_sgl_cd',20)	
		dw_2.settaborder('vd_expsubhead',30)	
		dw_2.settaborder('vd_preferred_mes',40)	
		dw_2.settaborder('vd_dc_ind',50)	
		dw_2.settaborder('vd_amount',60)	
		dw_2.settaborder('vd_section_id',70)	
		dw_2.settaborder('vd_narr_free_text',80)	
		dw_2.settaborder('vd_ref_no',90)	
		dw_2.settaborder('vd_ref_date',100)	
		dw_2.settaborder('vd_detail',110)	
		dw_2.settaborder('vd_narration_no2',120)	
		dw_2.settaborder('vd_narr_date2',130)	
		dw_2.settaborder('vd_narr_txt2',140)	
		dw_2.settaborder('ad_ind',160)	
		dw_2.settaborder('del_flag',170)	
	else
		rollback using sqlca;
		return 1
	end if
else
	messagebox('SQL Error : During Save',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if
else
	return
end if  
end event

type cb_2 from commandbutton within w_gteacf007
integer x = 279
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

event clicked;if cbx_1.checked then
	ls_appr_ind = 'Y';
else
	ls_appr_ind = 'N';
end if

if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0 or dw_2.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	dw_2.reset()
   	cb_3.enabled = false
  	cb_5.enabled = false
	cb_7.enabled = false
	cb_8.enabled = false
	cb_9.enabled = false
	cb_1.enabled = false
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.settaborder('vh_vou_no',25)
	dw_1.SetFocus ()
	dw_1.setcolumn('vh_vou_type')
	cb_2.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,ls_opt,ls_appr_ind)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	dw_1.settaborder('vh_vou_no',0)
	cb_2.text = "&Query"
   	cb_5.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
	cb_1.enabled = true
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gteacf007
integer x = 14
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

event clicked;if lb_neworder = false then
	if dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
	dw_1.reset()
	dw_2.reset()
end if
dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if gs_opt = 'CV' then
	select a.ACLEDGER_ID,b.ACSUBLEDGER_ID into :ls_contra_gl,:ls_contra_sgl from fb_acledger a,fb_acsubledger b 
	 where a.ACLEDGER_ID=b.ACLEDGER_ID and ACLEDGER_LEDGERTYPE='CASH' and nvl(ACLEDGER_ACTIVE_IND,'N')='Y';

	if sqlca.sqlcode = -1 then
		messagebox('Sql Error : During Select Cash Ledger : ',sqlca.sqlerrtext);
		return 1;
	elseif sqlca.sqlcode = 100 then
		messagebox('Information !','Cash Ledger Not Present, Please Create First !!!');
		return 1;		
	end if
end if
    

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	
	if gs_opt = 'CV' then
		//dw_1.setitem(dw_1.getrow(),'vh_contra_gl','LEG0008')
		//dw_1.setitem(dw_1.getrow(),'vh_contra_sgl','SLEG0026')	
		dw_1.setitem(dw_1.getrow(),'vh_contra_gl',ls_contra_gl)
		dw_1.setitem(dw_1.getrow(),'vh_contra_sgl',ls_contra_sgl)	
	end if
	
	dw_1.setitem(dw_1.getrow(),'vh_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'vh_entry_dt',datetime(today()))
	//dw_1.setitem(dw_1.getrow(),'vh_ac_year',long(string(datetime(today()),'yyyymm')))
	dw_1.setitem(dw_1.getrow(),'VH_CO_ID',gs_CO_ID)
	
	setnull(ls_temp);
	select unit_shortname into :ls_temp from fb_gardenmaster where nvl(UNIT_ACTIVE_IND,'N')='Y' ;
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error : During Select Garden Master : ',sqlca.sqlerrtext);
		return 1;
	end if
	if(ls_temp<>gs_garden_snm) then 
		messagebox('Error','Garden Short Name ismis match')
		return 1;
	end if	
	dw_1.setitem(dw_1.getrow(),'VH_UNIT_ID',gs_garden_snm)
	
	
	if gs_opt = 'JV' then
		dw_1.setitem(dw_1.getrow(),'vh_vou_type','JV')
		dw_1.setfocus()
		dw_1.setcolumn('vh_vou_date')
		dw_2.insertrow(0)
		dw_2.setitem(1,'vd_business_segment',gs_garden_snm)
	elseif gs_opt = 'EV' then
		dw_1.setitem(dw_1.getrow(),'vh_vou_type','EXPV')
		dw_1.setfocus()
		dw_1.setcolumn('vh_vou_date')
		//dw_2.setfocus()
		dw_2.insertrow(0)	
		dw_2.setitem(1,'vd_business_segment',gs_garden_snm)
	else
		dw_1.setcolumn('vh_vou_type')
	end if

	
	dw_1.setitem(dw_1.getrow(),'vh_vou_date',datetime(today()))
	
	select AP_STATUS into  :ls_status from fb_ac_year a,fb_acyear_period b
	where AY_YEAR_ID=AP_YEAR_ID(+) and trunc(sysdate) between trunc(AP_START_DT) and trunc(AP_END_DT);
	
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error : During Checking MEP : ',sqlca.sqlerrtext);
		return 1;
	elseif sqlca.sqlcode = 100 then
		messagebox('Information !','Accounting Year Period Not Created, Please Create Period First !!!');
		setnull(ld_voudt)
		dw_1.setitem(dw_1.getrow(),'vh_vou_date',ld_voudt)
		return 1;		
	end if
	
	if ls_status = 'C' then 
		messagebox('Information !','Entry For The Entered Date Is Not Allowed As MEP For The Selected Date Is Closed, Please Check !!!')
		setnull(ld_voudt)
		dw_1.setitem(dw_1.getrow(),'vh_vou_date',ld_voudt)
		return 1
	else    
		//dw_1.setitem(dw_1.getrow(),'vh_ac_year',long(string(ld_voudt,'yyyymm')))
		//dw_1.setitem(dw_1.getrow(),'vh_ac_period',long(ll_acpd))
		
		select distinct AY_FY_YEAR  into : ll_acyrid from fb_ac_year 
		where AY_STATUS ='O' and AY_COM_ID=:gs_CO_ID and 
				trunc(sysdate) between trunc(AY_START_DT) and nvl(trunc(AY_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));
				 
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error : During Accounting Year Select : ',sqlca.sqlerrtext);
			setnull(ld_voudt)
			dw_1.setitem(dw_1.getrow(),'vh_vou_date',ld_voudt)
			return 1;
		elseif sqlca.sqlcode = 0 then	
			dw_1.setitem(dw_1.getrow(),'vh_ac_year',long(ll_acyrid))
		end if;  	
		
		select distinct min(AP_PERIOD_ID) into : ll_acpd from fb_ac_year a,fb_acyear_period b 
		where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and 
					AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and AY_FY_YEAR=:ll_acyrid and
				trunc(sysdate) between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));
				  
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error : During Accounting Year Period Select : ',sqlca.sqlerrtext);
			setnull(ld_voudt)
			dw_1.setitem(dw_1.getrow(),'vh_vou_date',ld_voudt)
			return 1;
		elseif sqlca.sqlcode = 0 then	
			dw_1.setitem(dw_1.getrow(),'vh_ac_period',long(ll_acpd))
		end if;  
	end if

	

else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()		
	
	if gs_opt = 'CV' then
		//dw_1.setitem(dw_1.getrow(),'vh_contra_gl','LEG0008')
		//dw_1.setitem(dw_1.getrow(),'vh_contra_gl','SLEG0026')
		dw_1.setitem(dw_1.getrow(),'vh_contra_gl',ls_contra_gl)
		dw_1.setitem(dw_1.getrow(),'vh_contra_sgl',ls_contra_sgl)
	end if
	
	dw_1.setitem(dw_1.getrow(),'vh_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'vh_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'vh_ac_year',long(string(today(),'yyyymm')))
     dw_1.setitem(dw_1.getrow(),'VH_CO_ID',gs_CO_ID)
	
	
	setnull(ls_temp);
	select unit_shortname into :ls_temp from fb_gardenmaster where nvl(UNIT_ACTIVE_IND,'N')='Y' ;
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error : During Select Garden Master : ',sqlca.sqlerrtext);
		return 1;
	end if
	if(ls_temp<>gs_garden_snm) then 
		messagebox('Error','Garden Short Name ismis match')
		return 1;
	end if	
	dw_1.setitem(dw_1.getrow(),'VH_UNIT_ID',gs_garden_snm)
	
	
	
	if gs_opt = 'JV' then
		dw_1.setitem(dw_1.getrow(),'vh_vou_type','JV')
		//dw_2.setfocus()
		//dw_2.insertrow(0)
		dw_1.setcolumn('vh_vou_date')
	elseif gs_opt = 'EV' then
		dw_1.setitem(dw_1.getrow(),'vh_vou_type','EXPV')
		//dw_2.setfocus()
		//dw_2.insertrow(0)
		dw_1.setcolumn('vh_vou_date')		
	else
		dw_1.setcolumn('vh_vou_type')
	end if
end if


cb_1.enabled = false
end event

type dw_1 from datawindow within w_gteacf007
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer y = 128
integer width = 4585
integer height = 724
integer taborder = 40
string dataobject = "dw_gteacf007"
boolean hscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'vh_entry_by',gs_user)
		dw_1.setitem(newrow,'vh_entry_dt',datetime(today()))
		dw_1.setitem(dw_1.getrow(),'indent_holocalflag','1')
		dw_1.setitem(dw_1.getrow(),'INDENT_ACTIVE','1')
	     dw_1.setcolumn('indent_deliverytype')
	end if
 end if
end if

//IF KeyDown(KeyEscape!) THEN
//	cb_4.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF1!) THEN
//	cb_1.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF2!) THEN
//	cb_2.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF3!) THEN
//	if dw_1.rowcount() > 0  then
//		cb_3.triggerevent(clicked!)
//	end if
//end if
end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;//IF KeyDown(KeyEscape!) THEN
//	cb_4.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF1!) THEN
//	cb_1.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF2!) THEN
//	cb_2.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF3!) THEN
//	if dw_1.rowcount() > 0  then
//		cb_3.triggerevent(clicked!)
//	end if
//end if
end event

event ue_keydwn;//IF KeyDown(KeyEscape!) THEN
//	cb_4.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF1!) THEN
//	cb_1.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF2!) THEN
//	cb_2.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF3!) THEN
//	if dw_1.rowcount() > 0  then
//		cb_3.triggerevent(clicked!)
//	end if
//end if
end event

event itemchanged;///chek for Voucher type
if dwo.name = 'vh_vou_type'  then
	ls_temp = data
	if gs_garden_snm = 'KG' then
		dw_2.settaborder('vd_section_id',0)
	end if
	if gs_opt = 'CV'  then
		if ls_temp <> 'CPV' and ls_temp <> 'CRV' then 
			messagebox('Warning!','Voucher Type Should Be Cash Payment/ Cash Receipt, Please Check !!!')
			return 1
		end if
		
		if dw_2.rowcount( )>0 then
			for  ll_ctr = dw_2.rowcount() to 1 step -1
				dw_2.setitem(ll_ctr ,'vd_amount',0)
			next	
		end if
	
	elseif gs_opt = 'BV' then
		
		idw_contragl.SetFilter ("ledgertype like 'BANK'") 
		idw_contragl.filter( )		
		
		if ls_temp<>'BPV' and ls_temp <> 'BRV' then 
			messagebox('Warning!','Voucher Type Should Be Bank Payment/ Bank Receipt, Please Check !!!')
			return 1
		end if
	elseif gs_opt = 'JV' then
		if ls_temp<>'JV' then 
			messagebox('Warning!','Voucher Type Should Be Journal Voucher, Please Check !!!')
			return 1
		end if	
		
	elseif gs_opt = 'EV' then
		if ls_temp<>'EXPV' then 
			messagebox('Warning!','Voucher Type Should Be Expense Voucher, Please Check !!!')
			return 1
		end if		
		
	else
		messagebox('Warning!','Voucher Type Should Be Bank/Cach/Journal Voucher, Please Check !!!')
		return 1
	end if
end if	


if dwo.name = 'vh_vou_type'  and lb_query = false then
	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_2.setitem(1,'vd_business_segment',gs_garden_snm)
		if gs_garden_snm = 'KG' and (ls_temp = 'BPV' or ls_temp = 'CPV' )then
			dw_2.setitem(1,'vd_gl_cd','LEG0015')
			dw_2.setitem(1,'vd_preferred_mes','C')
			dw_2.setitem(1,'vd_dc_ind','D')
			dw_2.settaborder('vd_dc_ind',0)
			ls_gl_cd = 'LEG0015'
			idw_sgl.SetFilter ("trim(ACLEDGER_ID) = '"+trim(ls_gl_cd)+"'") 
			idw_sgl.filter( )						
		end if
		dw_1.setfocus()
		dw_1.setcolumn('vh_vou_type')		
	end if;	
end if

if dwo.name = 'vh_vou_date'  and lb_query = false then
	ld_voudt=datetime(data)
//	 if f_check_fin_yr(ld_voudt) = -1 then;	return 1;end if;

	select AP_STATUS into  :ls_status from fb_ac_year a,fb_acyear_period b
	where AY_YEAR_ID=AP_YEAR_ID(+) and trunc(:ld_voudt) between trunc(AP_START_DT) and trunc(AP_END_DT);
	
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error : During Checking MEP : ',sqlca.sqlerrtext);
		return 1;
	elseif sqlca.sqlcode = 100 then
		messagebox('Information !','Accounting Year Period Not Created, Please Create Period First !!!');
		return 1;		
	end if
	
	if ls_status = 'C' then 
		messagebox('Information !','Entry For The Entered Date Is Not Allowed As MEP For The Selected Date Is Closed, Please Check !!!')
		return 1
	else    
		//dw_1.setitem(dw_1.getrow(),'vh_ac_year',long(string(ld_voudt,'yyyymm')))
		//dw_1.setitem(dw_1.getrow(),'vh_ac_period',long(ll_acpd))
		
		select distinct AY_FY_YEAR  into : ll_acyrid from fb_ac_year 
		where AY_STATUS ='O' and AY_COM_ID=:gs_CO_ID and 
				trunc(:ld_voudt) between trunc(AY_START_DT) and nvl(trunc(AY_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));
				 
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error : During Accounting Year Select : ',sqlca.sqlerrtext);
			return 1;
		elseif sqlca.sqlcode = 0 then	
			dw_1.setitem(dw_1.getrow(),'vh_ac_year',long(ll_acyrid))
		end if;  	
		
		select distinct min(AP_PERIOD_ID) into : ll_acpd from fb_ac_year a,fb_acyear_period b 
		where a.AY_YEAR_ID=b.AP_YEAR_ID(+) and 
					AP_STATUS ='O' and a.AY_COM_ID=:gs_CO_ID and AY_FY_YEAR=:ll_acyrid and
				trunc(:ld_voudt) between trunc(AP_START_DT) and nvl(trunc(AP_END_DT),to_date(to_char(sysdate,'dd/mm/yyyy'),'dd/mm/yyyy'));
				  
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error : During Accounting Year Period Select : ',sqlca.sqlerrtext);
			return 1;
		elseif sqlca.sqlcode = 0 then	
			dw_1.setitem(dw_1.getrow(),'vh_ac_period',long(ll_acpd))
		end if;  
	end if
end if

	if dwo.name = 'vh_contra_gl' then
		ls_contra_gl = data		
		//if  wf_check_duplicate_rec(ls_contra_gl) = -1 then return 1
		idw_contrasgl.SetFilter ("acledger_id = '"+trim(data)+"'") 
		idw_contrasgl.filter( )		
	end if
	
	if dwo.name = 'vh_contra_sgl' then
		ls_contra_sgl= data
	end if

if dwo.name = 'vh_cheque_no' then
	ld_voudt = dw_1.getitemdatetime(dw_1.getrow(),'vh_vou_date')
	dw_1.setitem(row,'vh_cheque_dt',ld_voudt)
end if
	
if lb_query = false then
	ld_old_entry_dt=dw_1.getitemdatetime(dw_1.getrow(),'old_entry_dt') 
end if

//if dwo.name = 'appr_flag'  then
//	ls_tmp_id =data
//	if ls_tmp_id = 'Y' then
//		dw_1.setitem(row,'vh_approved_by',gs_user)
//		dw_1.setitem(row,'vh_approved_dt',datetime(today())) 
//	elseif ls_tmp_id = 'N' then		
//		setnull(ls_temp)
//		dw_1.setitem(row,'vh_approved_by',ls_temp)
//		dw_1.setitem(row,'vh_approved_dt',datetime(ls_temp)) 
//	end if	
//else
//	dw_1.setitem(row,'vh_entry_by',gs_user)
//	dw_1.setitem(row,'vh_entry_dt',datetime(today()))
//end if;
if dwo.name = 'appr_flag'  then
	ls_tmp_id =data
	if ls_tmp_id = 'Y' then
		if dw_2.modifiedcount() > 0 then
			messagebox('Warning','Row Is Modified, Please Save Record First')
				setnull(ls_temp)
				dw_1.setitem(row,'vh_approved_by',ls_temp)
				dw_1.setitem(row,'vh_approved_dt',datetime(ls_temp)) 
				
				dw_2.settaborder('vd_functions',0)	
				dw_2.settaborder('vd_business_segment',0)	
				dw_2.settaborder('vd_gl_cd',10)	
				dw_2.settaborder('vd_sgl_cd',20)	
				dw_2.settaborder('vd_expsubhead',30)	
				dw_2.settaborder('vd_preferred_mes',40)	
				dw_2.settaborder('vd_dc_ind',50)	
				dw_2.settaborder('vd_amount',60)	
				dw_2.settaborder('vd_section_id',70)	
				dw_2.settaborder('vd_narr_free_text',80)	
				dw_2.settaborder('vd_ref_no',90)	
				dw_2.settaborder('vd_ref_date',100)	
				dw_2.settaborder('vd_detail',110)	
				dw_2.settaborder('vd_narration_no2',120)	
				dw_2.settaborder('vd_narr_date2',130)	
				dw_2.settaborder('vd_narr_txt2',140)	
				dw_2.settaborder('ad_ind',160)	
				dw_2.settaborder('del_flag',170)	
				return 1
		else		
		   dw_2.settaborder('vd_functions',0)	
		   dw_2.settaborder('vd_business_segment',0)	
		   dw_2.settaborder('vd_gl_cd',0)	
		   dw_2.settaborder('vd_sgl_cd',0)	
		   dw_2.settaborder('vd_expsubhead',0)	
		   dw_2.settaborder('vd_preferred_mes',0)	
		   dw_2.settaborder('vd_dc_ind',0)	
		   dw_2.settaborder('vd_amount',0)	
		   dw_2.settaborder('vd_section_id',0)	
		   dw_2.settaborder('vd_narr_free_text',0)	
		   dw_2.settaborder('vd_ref_no',0)	
		   dw_2.settaborder('vd_ref_date',0)	
		   dw_2.settaborder('vd_detail',0)	
		   dw_2.settaborder('vd_narration_no2',0)	
		   dw_2.settaborder('vd_narr_date2',0)	
		   dw_2.settaborder('vd_narr_txt2',0)	
		   dw_2.settaborder('ad_ind',0)	
  		   dw_2.settaborder('del_flag',0)
			  
		   dw_1.setitem(row,'vh_approved_by',gs_user)
		   dw_1.setitem(row,'vh_approved_dt',datetime(today())) 
		end if

	elseif ls_tmp_id = 'N' then		
		setnull(ls_temp)		
		dw_1.setitem(row,'vh_approved_by',ls_temp)
		dw_1.setitem(row,'vh_approved_dt',datetime(ls_temp)) 
		
		dw_2.settaborder('vd_functions',0)	
		dw_2.settaborder('vd_business_segment',0)	
		dw_2.settaborder('vd_gl_cd',10)	
		dw_2.settaborder('vd_sgl_cd',20)	
		dw_2.settaborder('vd_expsubhead',30)	
		dw_2.settaborder('vd_preferred_mes',40)	
		dw_2.settaborder('vd_dc_ind',50)	
		dw_2.settaborder('vd_amount',60)	
		dw_2.settaborder('vd_section_id',70)	
		dw_2.settaborder('vd_narr_free_text',80)	
		dw_2.settaborder('vd_ref_no',90)	
		dw_2.settaborder('vd_ref_date',100)	
		dw_2.settaborder('vd_detail',110)	
		dw_2.settaborder('vd_narration_no2',120)	
		dw_2.settaborder('vd_narr_date2',130)	
		dw_2.settaborder('vd_narr_txt2',140)	
		dw_2.settaborder('ad_ind',160)	
		dw_2.settaborder('del_flag',170)	
	end if	
else
	dw_1.setitem(row,'vh_entry_by',gs_user)
	dw_1.setitem(row,'vh_entry_dt',datetime(today()))
end if;

if dwo.name='del_flag' then
	ls_temp=data
	
	
	for ll_ctr = dw_1.rowcount() to 1 step -1
		if(row = ll_ctr) then
			if ls_temp='Y' then
				cb_11.visible=true;
				cb_3.visible=false;
				return
			else
				cb_11.visible=false;
				cb_3.visible=true;
			end if		
		else
			if dw_1.getitemstring(ll_ctr,'del_flag')='Y' then 
				cb_11.visible=true;
				cb_3.visible=false;
				return
			else
				cb_11.visible=false;
				cb_3.visible=true;
			end if
		end if
	next
	
end if

cb_3.enabled = true
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			ll_ref = dw_1.getitemnumber(dw_1.getrow(),'vh_doc_srl')
			dw_2.reset()
			dw_2.retrieve(ll_ref)
		end if
	end if
end if
end event

type dw_2 from datawindow within w_gteacf007
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer y = 860
integer width = 4585
integer height = 1368
integer taborder = 50
string dataobject = "dw_gteacf007a"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_2.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_2.rowcount() and dw_2.rowcount() > 1  then
		dw_2.setitem(newrow,'vd_detail',dw_2.getitemstring(currentrow,'vd_detail'))
		dw_2.setitem(newrow,'vd_functions',dw_2.getitemstring(currentrow,'vd_functions'))
		dw_2.setitem(newrow,'vd_business_segment',dw_2.getitemstring(currentrow,'vd_business_segment'))
		//dw_2.setitem(newrow,'vd_gl_cd',dw_2.getitemstring(currentrow,'vd_gl_cd'))
		//dw_2.setitem(newrow,'vd_sgl_cd',dw_2.getitemstring(currentrow,'vd_sgl_cd'))
		dw_2.setitem(newrow,'vd_ref_no',dw_2.getitemstring(currentrow,'vd_ref_no'))
		dw_2.setitem(newrow,'vd_ref_date',dw_2.getitemdatetime(currentrow,'vd_ref_date'))		
		dw_2.setitem(newrow,'vd_narr_free_text',dw_2.getitemstring(currentrow,'vd_narr_free_text'))
		dw_2.setitem(newrow,'vd_dc_ind',dw_2.getitemstring(currentrow,'vd_dc_ind'))
		//dw_2.setitem(newrow,'vd_party_cd',dw_2.getitemstring(currentrow,'vd_party_cd'))
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(dw_2.getrow())
	end if
	if dw_2.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

//IF KeyDown(KeyEscape!) THEN
//	cb_4.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF1!) THEN
//	cb_1.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF2!) THEN
//	cb_2.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF3!) THEN
//	if dw_1.rowcount() > 0  then
//		cb_3.triggerevent(clicked!)
//	end if
//end if
end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(dw_2.getrow())
	end if
	if dw_2.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

//IF KeyDown(KeyEscape!) THEN
//	cb_4.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF1!) THEN
//	cb_1.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF2!) THEN
//	cb_2.triggerevent(clicked!)
//end if
//IF KeyDown(KeyF3!) THEN
//	if dw_1.rowcount() > 0  then
//		cb_3.triggerevent(clicked!)
//	end if
//end if
end event

event itemchanged;if dwo.name = 'vd_gl_cd'  then
	dw_2.settaborder('vd_dc_ind',50)
	dw_2.setitem(row,'vd_sgl_cd','')
	dw_2.setitem(row,'vd_amount',0)
	ls_gl_cd = data
	
	ls_glentry_alow = 'N'
	
	select distinct ACLEDGER_ID,ACLEDGER_TYPE into :ls_exp_gl,:ls_glentry_alow from fb_acledger 
	where ACLEDGER_ACTYPE = 'E' and nvl(ACLEDGER_ACTIVE_IND,'N')='Y'  and ACLEDGER_ID=:ls_gl_cd;
	
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error : During Select Expense Ledger : ',sqlca.sqlerrtext);
		return 1;
//	elseif sqlca.sqlcode = 100 then
//		messagebox('Information !','Expense Ledger Not Present, Please Create First !!!');
//		return 1;		
	end if
	
	// remove by SS on 06-Feb-2025 and added in ACLEDGER_TYPE as Y for LEG0004
//	if ls_gl_cd = 'LEG0004'  then

	if ls_glentry_alow='E' then
		messagebox('Error','Stock Of Stores Ledger Should Not Be Selected, Please Check !!')
		return 1
	end if
	 
	//if (ls_gl_cd <>'LEG0014' or ls_gl_cd <>'LEG0015') then
	if ls_gl_cd <>ls_exp_gl then
		  setnull(ls_preferred_mes)
		  setnull(ls_section_id)	  
		  dw_2.setitem(row,'vd_preferred_mes',ls_preferred_mes)
		  dw_2.setitem(row,'vd_section_id',ls_section_id)
		  dw_2.setitem(row,'vd_dc_ind','D')
		  ls_vou_type = dw_1.getitemstring(dw_1.getrow(),'vh_vou_type')
		  if ls_vou_type = 'BRV' or ls_vou_type = 'CRV' then
			dw_2.setitem(row,'vd_dc_ind','C')
			dw_2.settaborder('vd_dc_ind',0)
		  elseif ls_vou_type = 'BPV' or ls_vou_type = 'CPV' then
			dw_2.setitem(row,'vd_dc_ind','D')
			dw_2.settaborder('vd_dc_ind',0)
		  end if
	  elseif  ls_gl_cd = ls_exp_gl then
		if gs_garden_snm = 'KG' then
			dw_2.setitem(1,'vd_preferred_mes','C')
			idw_sgl.SetFilter ("trim(ACLEDGER_ID) = '"+trim(data)+"'") 
			idw_sgl.filter( )			
		end if
      end if
		
	if isnull(dw_1.getitemstring(dw_1.getrow(),'vh_remitno')) = false or len(dw_1.getitemstring(dw_1.getrow(),'vh_remitno'))>=1 then
		if ls_gl_cd<>'LEG0009' and ls_gl_cd<>'LEG0010' and ls_gl_cd<>'LEG0011' and ls_gl_cd<>'LEG0012' then
			messagebox('Error','Please Select A General Ledger related to Remittance ')
			return 1
		end if
	end if
	
	ls_contra_gl = dw_1.getitemstring(dw_1.getrow(),'vh_contra_gl') 
	
	if gs_opt = 'CV'  and  ls_gl_cd =ls_contra_gl then
		messagebox('Error','Contra Ledger Could not Select here,Please Select A Valid Ledger From List')
		return 1
	end if
		
	idw_sgl.SetFilter ("trim(ACLEDGER_ID) = '"+trim(data)+"'") 
	idw_sgl.filter( )
	
else
	ls_gl_cd=dw_2.getitemstring(row,'vd_gl_cd') 
end if;	

if lb_query = false then
	ls_old_expsubhead=dw_2.getitemstring(row,'old_expsubhead') 
	ld_old_amount=dw_2.getitemnumber(row,'old_amount') 
	ls_old_preferred_mes=dw_2.getitemstring(row,'old_preferred_mes') 
	ls_old_dc_ind=dw_2.getitemstring(row,'old_dc_ind')
	ld_voudt=dw_1.getitemdatetime(dw_1.getrow(),'vh_vou_date') 	
end if

if dwo.name = 'vd_sgl_cd' then
	ls_sgl_cd = data
	dw_2.setitem(row,'vd_amount',0)
	ls_gl = dw_2.getitemstring(row,'vd_gl_cd') 
	ld_voudt=dw_1.getitemdatetime(dw_1.getrow(),'vh_vou_date') 	
	
	select distinct ACLEDGER_ID into :ls_adv_gl from fb_acledger where ACLEDGER_LEDGERTYPE = 'ADVANCE' and 
	           nvl(ACLEDGER_ACTIVE_IND,'N')='Y' and ACLEDGER_ID=:ls_gl_cd;
	
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error : During Select Expense Ledger : ',sqlca.sqlerrtext);
		return 1;
//	elseif sqlca.sqlcode = 100 then
//		messagebox('Information !','Expense Ledger Not Present, Please Create First !!!');
//		return 1;		
	end if
	
	if ls_gl = 'LEG0001' or ls_gl =  'LEG0002' or ls_gl = 'LEG0003' then
		ld_opening = 0
		select (sum(decode(c.ACLEDGER_CUMLATIVE_IND,'C',decode(c.ACLEDGER_DCIND,'C',0,(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)) ),
																											'H',decode(c.ACLEDGER_DCIND,'C',0,(decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)) ),
															'N', (decode(VD_DC_IND,'D',1,-1) * nvl(VD_AMOUNT,0)) ))) -
				 (sum(decode(c.ACLEDGER_CUMLATIVE_IND,'C',decode(c.ACLEDGER_DCIND,'D',0,(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)) ),
																											'H',decode(c.ACLEDGER_DCIND,'D',0,(decode(VD_DC_IND,'C',1,-1) * nvl(VD_AMOUNT,0)) ),0))) OP_BAL into :ld_opening
		from fb_vou_head a,fb_vou_det b,fb_acledger c,fb_acsubledger d
		where a.VH_DOC_SRL=b.VD_DOC_SRL and VD_GL_CD= c.ACLEDGER_ID and VD_SGL_CD = d.ACSUBLEDGER_ID(+) and 
					 VD_SGL_CD = :ls_sgl_cd and VD_GL_CD = :ls_gl and 
					 ((c.ACLEDGER_CUMLATIVE_IND in ('C','H') and VH_VOU_DATE < trunc(:ld_voudt) ) or
				(c.ACLEDGER_CUMLATIVE_IND in ('N') and VH_VOU_DATE between 
				  to_date(decode(sign(to_number(to_char(trunc(:ld_voudt),'mm')) - 04),-1,to_number(to_char(trunc(:ld_voudt),'yyyy')) - 1,to_number(to_char(trunc(:ld_voudt),'yyyy')))||'0401','yyyymmdd') and trunc(:ld_voudt) ) ) and 
			  VH_APPROVED_BY is not null;
			  
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error : During Select Getting Opening Details : ',sqlca.sqlerrtext);
			return 1;
		end if	
		if isnull(ld_opening) then ld_opening = 0;
		dw_2.setitem(row,'opbal',ld_opening)
	end if
	
	
	
	//if ls_gl_cd='LEG0003' then
//	if ls_gl_cd=ls_adv_gl then
//		 select emp_id into :ls_empid from fb_employee where trim(ACSUBLEDGER_ID) = :ls_sgl_cd and trim(EMP_INACTIVETYPE)='Regular' ;
//		if sqlca.sqlcode = -1 then
//			messagebox('Sql Error: During Employee Select',sqlca.sqlerrtext)
//			return 1
//		elseif sqlca.sqlcode = 0 then	
//			dw_2.setitem(row,'vd_emp_id',ls_empid)	
//		end if;				
//	end if;	  	
		setnull(ls_temp);
		
		 select distinct ty into :ls_temp
		  from (select decode(AC_PROCESS,'PF ADVANCE','PF','Electricity Advance','EL','Medical Advance','ME','Festival Advance','FE','CO') ty,
          decode(AC_PROCESS,'PF ADVANCE',DR_ACLEDGER_ID,'Electricity Advance',DR_ACLEDGER_ID,'Medical Advance',DR_ACLEDGER_ID,'Festival Advance',DR_ACLEDGER_ID,CR_ACLEDGER_ID) ACLEDGER_ID,
          decode(AC_PROCESS,'PF ADVANCE',DR_ACSUBLEDGER_ID,'Electricity Advance',DR_ACSUBLEDGER_ID,'Medical Advance',DR_ACSUBLEDGER_ID,'Festival Advance',DR_ACSUBLEDGER_ID,CR_ACSUBLEDGER_ID) ACSUBLEDGER_ID,null emp_id
          from fb_acautoprocess  where ((AC_PROCESS='PF ADVANCE'  and :gs_opt in ('CV','BV','JV')) or (ac_process = 'Wages To Account' and AC_PROCESS_DETAIL='Company Advance')
          or (AC_PROCESS='Electricity Advance' and :gs_opt in ('CV','BV','JV')) or (AC_PROCESS='Medical Advance' and :gs_opt in ('CV','BV','JV')) or (AC_PROCESS='Festival Advance' and :gs_opt in ('CV','BV','JV')))              
		 union
          select 'CO',ACLEDGER_ID,a.ACSUBLEDGER_ID,emp_id from fb_employee a,fb_acsubledger b where a.ACSUBLEDGER_ID = b.ACSUBLEDGER_ID and a.emp_type in ('AT','SS','ST') and a.ACSUBLEDGER_ID is not null)
		where ACLEDGER_ID = :ls_gl_cd and ACSUBLEDGER_ID =:ls_sgl_cd ;
		  
		 if sqlca.sqlcode = -1 then
			messagebox('Sql Error : During Select Deposit Ledger and ATPPF Scheme : ',sqlca.sqlerrtext);
			return 1;
		end if
		if len(ls_temp) = 0 or isnull(ls_temp) then
			setnull(ls_empid)
			dw_2.setitem(row,'vd_emp_id',ls_empid)
		end if;
		
	
	//if  wf_check_duplicate_rec(ls_sgl_cd) = -1 then return 1
	
	idw_eacsubhead.SetFilter ("eachead_id = '"+trim(data)+"'") 
	idw_eacsubhead.filter( )
	
	ls_contra_sgl = dw_1.getitemstring(dw_1.getrow(),'vh_contra_sgl') 
	if gs_opt = 'CV'  and  ls_gl_cd =ls_contra_gl and  ls_sgl_cd= ls_contra_sgl then
	   messagebox('Error','Contra SubLedger Could not Select here,Please Select A Valid Sub Ledger From List')
	   return 1
	end if
	if gs_opt = 'EV' then
		
		
		select nvl(acsubledger_tds_ind, 'N') into :ls_tds_ind from fb_acsubledger where acsubledger_id = :ls_sgl_cd;
		if sqlca.sqlcode = -1 then
			messagebox('Error', 'Error occured while checking TDS indicator : '+sqlca.sqlerrtext);
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning', 'No subledger found for code : '+ls_Sgl_cd);
			return 1
		elseif sqlca.sqlcode = 0 then
			dw_2.setitem(row, 'vd_tds_ind', ls_tds_ind)
		end if
		
		
		select SUP_ID, SUP_GSTNNO, SUP_GSTN_STCD  into :ls_party_cd,:ls_party_gstin,:ls_party_gstinstcd  from fb_supplier where nvl(SUP_ACTIVE,'0') = '1' and ACSUBLEDGER_ID = :ls_sgl_cd ;			 
		
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error: During Party Ledger Select',sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 0 then
			if isnull(ls_party_gstin) or len(ls_party_gstin) = 0 then
				//dw_2.setitem(row,'vd_revchg_ind','Y')
			else
				dw_2.setitem(row,'vd_revchg_ind','N')
			end if
				dw_2.setitem(row,'vd_party_cd',ls_party_cd)
				dw_2.setitem(row,'vd_party_gstn',ls_party_gstin)
				dw_2.setitem(row,'vd_party_gstnstate',ls_party_gstinstcd)
		elseif sqlca.sqlcode = 100 then
			setnull(ls_party_gstin); setnull(ls_party_gstinstcd);setnull(ls_party_cd);
				dw_2.setitem(row,'vd_revchg_ind','N')
				dw_2.setitem(row,'vd_party_cd',ls_party_cd)
				dw_2.setitem(row,'vd_party_gstn',ls_party_gstin)
				dw_2.setitem(row,'vd_party_gstnstate',ls_party_gstinstcd)
				if dw_2.getitemstring(row, 'vd_gl_cd') = 'LEG0001' and gs_opt = 'EV'  then
					messagebox('Warning', 'There must be a supplier against the selected sub-ledger.')
					return 1
				end if
		end if;
	else
		setnull(ls_party_gstin); setnull(ls_party_gstinstcd);setnull(ls_party_cd);
		dw_2.setitem(row,'vd_revchg_ind','N')
		dw_2.setitem(row,'vd_party_cd',ls_party_cd)
		dw_2.setitem(row,'vd_party_gstn',ls_party_gstin)
		dw_2.setitem(row,'vd_party_gstnstate',ls_party_gstinstcd)				
	end if;
	
else
	ls_sgl_cd = dw_2.getitemstring(row,'vd_sgl_cd') 
end if

if dwo.name = 'vd_cheque_no' then
	ld_voudt = dw_1.getitemdatetime(dw_1.getrow(),'vh_vou_date')
	dw_2.setitem(row,'vd_cheque_dt',ld_voudt)
end if

if dwo.name = 'vd_preferred_mes' then
	ls_cons = trim(data)
	ls_expsubhead=dw_2.getitemstring(row,'vd_expsubhead') 
	
	if (not isnull(ls_cons) or len(ls_cons) > 0) and (isnull(trim(ls_expsubhead)) or len(trim(ls_expsubhead)) = 0) or &
	   (isnull(ls_cons) or len(ls_cons) = 0) and ( not isnull(trim(ls_expsubhead)) or len(trim(ls_expsubhead)) > 0)	then
		messagebox('Error','Please Select a valid Expense sub head for Mes & Vise Versa !!!')
	      rollback using sqlca;
	      return 1
	end if	
	
	if ls_cons <>'W' and ls_cons <> 'C' and ls_cons <> 'S' then
		messagebox('Error','Please Select Cash Wages/Cash Other/Salary for Mes ')
	      rollback using sqlca;
	      return 1
	end if		
end if	


if dwo.name = 'vd_dc_ind'  then
	ls_dc_ind = data
	
	setnull(ls_temp)
	
	 select distinct ty into :ls_temp
	  from (select decode(AC_PROCESS,'PF ADVANCE','PF','Electricity Advance','EL','Medical Advance','ME','Festival Advance','FE','CO') ty,
          decode(AC_PROCESS,'PF ADVANCE',DR_ACLEDGER_ID,'Electricity Advance',DR_ACLEDGER_ID,'Medical Advance',DR_ACLEDGER_ID,'Festival Advance',DR_ACLEDGER_ID,CR_ACLEDGER_ID) ACLEDGER_ID,
          decode(AC_PROCESS,'PF ADVANCE',DR_ACSUBLEDGER_ID,'Electricity Advance',DR_ACSUBLEDGER_ID,'Medical Advance',DR_ACSUBLEDGER_ID,'Festival Advance',DR_ACSUBLEDGER_ID,CR_ACSUBLEDGER_ID) ACSUBLEDGER_ID,null emp_id
          from fb_acautoprocess  where ((AC_PROCESS='PF ADVANCE'  and :gs_opt in ('CV','BV','JV')) or (ac_process = 'Wages To Account' and AC_PROCESS_DETAIL='Company Advance')
          or (AC_PROCESS='Electricity Advance' and :gs_opt in ('CV','BV','JV')) or (AC_PROCESS='Medical Advance' and :gs_opt in ('CV','BV','JV')) or (AC_PROCESS='Festival Advance' and :gs_opt in ('CV','BV','JV')))              
		 union
          select 'CO',ACLEDGER_ID,a.ACSUBLEDGER_ID,emp_id from fb_employee a,fb_acsubledger b where a.ACSUBLEDGER_ID = b.ACSUBLEDGER_ID and a.emp_type in ('AT','SS','ST') and a.ACSUBLEDGER_ID is not null)
	where ACLEDGER_ID = :ls_gl_cd and ACSUBLEDGER_ID =:ls_sgl_cd ;
	  
	 if sqlca.sqlcode = -1 then
		messagebox('Sql Error : During Select Deposit Ledger and ATPPF Scheme : ',sqlca.sqlerrtext);
		return 1;
	end if	
	
//	if len(ls_temp) > 0 and ls_dc_ind='C' then
//		messagebox('Advance Deposit Error','You Can Not Deposit Advance in Cash/Bank Against Labour/Employee, Please check...!')
//		return 1
//	end if;
else
	ls_dc_ind = dw_2.getitemstring(row, 'vd_dc_ind')
end if	

if dwo.name = 'vd_amount' then
	ld_amt = double(data)
	ls_gl_cd = dw_2.getitemstring(row,'vd_gl_cd')
	ls_sgl_cd = dw_2.getitemstring(row,'vd_sgl_cd') 
	ls_narr = dw_2.getitemstring(row,'vd_narr_free_text')
	ls_billno = dw_2.getitemstring(row,'vd_ref_no')
	ld_billdt = dw_2.getitemdatetime(row,'vd_ref_date')
	ls_vou_type = dw_1.getitemstring(dw_1.getrow(),'vh_vou_type')
	
	If ((not isnull(trim(dw_2.getitemstring(row,'vd_expsubhead'))) or len(trim(dw_2.getitemstring(row,'vd_expsubhead'))) > 0)  and  (isnull(dw_2.getitemstring(row,'vd_preferred_mes')) or len(dw_2.getitemstring(row,'vd_preferred_mes')) = 0))	then
		messagebox('Warning!','Prefered MES Is Blank, Please Select From List !!!')
		dw_2.setcolumn('vd_preferred_mes')
	//	dw_2.setfocus('vd_preferred_mes')
		return 1
	end if
	
	
	if dw_1.getitemstring(dw_1.getrow(),'vh_vou_type') = 'CPV' and ld_amt>10000 then 
		
		select distinct 'X' into :ls_temp from fb_acsubledger where acsubledger_cv_chk='Y' and ACSUBLEDGER_ID=:ls_sgl_cd;
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error: During Checking for Wages subledger for 10000 validation',sqlca.sqlerrtext)
			return 1
		elseif  sqlca.sqlcode = 100 then
			messagebox('Warning...!','For Cash Voucher Max Amount Cannot Exceed 10000')
			return 1
		end if;	

	end if
	
	
	if  wf_check_duplicate_rec(ls_gl_cd,ls_sgl_cd,ld_amt,ls_narr,ls_billno,ld_billdt) = -1 then return 1
	
	ls_cons=dw_2.getitemstring(row,'vd_preferred_mes') 
	ls_expsubhead=dw_2.getitemstring(row,'vd_expsubhead') 
	
	if ls_cons = 'W'  then ///'ESUB0163'
         select kamsub_afrate afrate into :ld_afrate from fb_kamsubhead where trim(kamsub_id) = :ls_expsubhead and trunc(:ld_billdt) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error: During Kamjari Head Select',sqlca.sqlerrtext)
			return 1
		end if;
		if ld_afrate > 0  then
			ld_wages = round((ld_amt/ld_afrate),2)
			dw_2.setitem(row,'VD_MANDAYS',ld_wages)	
		end if
	end if;	
	
	/// for Advance
	
		setnull(ls_temp);setnull(gs_emp_id)
		
		  select distinct ty,emp_id into :ls_temp,:gs_emp_id
          from (select decode(AC_PROCESS,'PF ADVANCE','PF','Electricity Advance','EL','Medical Advance','ME','Festival Advance','FE','CO') ty,
          decode(AC_PROCESS,'PF ADVANCE',DR_ACLEDGER_ID,'Electricity Advance',DR_ACLEDGER_ID,'Medical Advance',DR_ACLEDGER_ID,'Festival Advance',DR_ACLEDGER_ID,CR_ACLEDGER_ID) ACLEDGER_ID,
          decode(AC_PROCESS,'PF ADVANCE',DR_ACSUBLEDGER_ID,'Electricity Advance',DR_ACSUBLEDGER_ID,'Medical Advance',DR_ACSUBLEDGER_ID,'Festival Advance',DR_ACSUBLEDGER_ID,CR_ACSUBLEDGER_ID) ACSUBLEDGER_ID,null emp_id
          from fb_acautoprocess  where ((AC_PROCESS='PF ADVANCE'  and :gs_opt in ('CV','BV','JV')) or (ac_process = 'Wages To Account' and AC_PROCESS_DETAIL='Company Advance')
          or (AC_PROCESS='Electricity Advance' and :gs_opt in ('CV','BV','JV')) or (AC_PROCESS='Medical Advance' and :gs_opt in ('CV','BV','JV')) or (AC_PROCESS='Festival Advance' and :gs_opt in ('CV','BV','JV')))              
		 union
          select 'CO',ACLEDGER_ID,a.ACSUBLEDGER_ID,emp_id from fb_employee a,fb_acsubledger b where a.ACSUBLEDGER_ID = b.ACSUBLEDGER_ID and a.emp_type in ('AT','SS','ST') and a.ACSUBLEDGER_ID is not null)
          where ACLEDGER_ID = :ls_gl_cd and ACSUBLEDGER_ID =:ls_sgl_cd ;
		  
		 if sqlca.sqlcode = -1 then
			messagebox('Sql Error : During Select Deposit Ledger and ATPPF Scheme : ',sqlca.sqlerrtext);
			return 1;
		end if
//		if len(ls_temp) > 0 and ls_dc_ind='C' then
//			messagebox('Advance Deposit Error','You Can Not Deposit Advance in Cash/Bank Against Labour/Employee, Please check...!')
//			return 1
//		end if;
	    dw_2.setitem(row,'vd_loan_type',ls_temp)
		if ls_temp='CO' then
			dw_2.setitem(row,'vd_emp_id',gs_emp_id)
		end if

		
		if len(dw_2.getitemstring(row,'vd_loan_type')) > 0 then 	
			gd_amount		= ld_amt;
			gs_dc_ind		= ls_dc_ind
			gs_emp_id 		= dw_2.getitemstring(row,'vd_emp_id')
			gs_emp_pfno 	= dw_2.getitemstring(row,'vd_pf_no')					
			gd_int_rate		= dw_2.getitemnumber(row,'vd_int_rate')	
			gd_int_amt		= dw_2.getitemnumber(row,'vd_int_amt')
			gd_loan_bal		= dw_2.getitemnumber(row,'vd_loan_bal')
			gd_loan_type	= dw_2.getitemstring(row,'vd_loan_type')
			gs_dedn_dt		= string(dw_2.getitemdatetime(row,'vd_dedn_date'),'dd/mm/yyyy')
			gd_dedn_emi	= dw_2.getitemnumber(row,'vd_dedn_emi')
			
			if gs_opt = 'CV' or gs_opt = 'JV' or (gs_opt = 'BV' and ls_vou_type = 'BPV') then 
				if ld_amt > 0 then open(w_gteacf007a)
			end if
			
			if gb_retval	 = true then
				
				     dw_2.setitem(row,'vd_emp_id',gs_emp_id)		
					dw_2.setitem(row,'vd_pf_no',gs_emp_pfno)					
					dw_2.setitem(row,'vd_int_rate',gd_int_rate)	
					dw_2.setitem(row,'vd_int_amt',gd_int_amt)
					dw_2.setitem(row,'vd_loan_bal',gd_loan_bal)
					dw_2.setitem(row,'vd_dedn_date',datetime(date(gs_dedn_dt)))
					dw_2.setitem(row,'vd_dedn_emi',gd_dedn_emi)

					if ls_dc_ind='C' then
						
						select  min(LWW_ID) into :ls_lwwid from fb_labourwagesweek where lww_paidflag='0' ;
					
						if sqlca.sqlcode = -1 then
							messagebox('Sql Error: During Select Supplier ',sqlca.sqlerrtext)
							return 1
						end if;
						
						if not isnull(ls_lwwid) and len(ls_lwwid) > 0 then
							dw_2.setitem(row,'vd_narration_no2',ls_lwwid)
						end if
					end if
					
			end if;
		else
			setnull(ls_temp)
			dw_2.setitem(row,'vd_emp_id',ls_temp)		
			dw_2.setitem(row,'vd_pf_no',ls_temp)					
			dw_2.setitem(row,'vd_int_rate',ls_temp)	
			dw_2.setitem(row,'vd_int_amt',ls_temp)
			dw_2.setitem(row,'vd_loan_bal',ls_temp)
			dw_2.setitem(row,'vd_dedn_date',ls_temp)
			dw_2.setitem(row,'vd_dedn_emi',ls_temp)
   		end if		
end if;


if gs_opt = 'EV'  then
	
    if dwo.name = 'vd_ref_no'  then
        ls_billno = data
		 if isnull(ls_billno) or len(ls_billno)=0 then			
			messagebox('Error:', 'Please enter Bill No for this Expense')
			return 1
		end if	
		
		ld_voudt=dw_1.getitemdatetime(dw_1.getrow(),'vh_vou_date') 	
		ls_sgl_cd = dw_2.getitemstring(row,'vd_sgl_cd') 
		
		select distinct vh_vou_no into :ls_temp from fb_vou_det a, fb_vou_head b where a.vd_doc_Srl=b.vh_doc_srl and vh_vou_date between to_date(decode(sign(to_char(trunc(:ld_voudt),'mm') - 4),-1,(to_char(trunc(:ld_voudt),'yyyy')-1),to_char(trunc(:ld_voudt),'yyyy'))||'04','yyyymm')
						and last_day(to_date(decode(sign(to_char(trunc(:ld_voudt),'mm') - 4),-1,(to_char(trunc(:ld_voudt),'yyyy')),to_char(trunc(:ld_voudt),'yyyy')+1)||'03','yyyymm')) and VD_SGL_CD =:ls_sgl_cd and vd_ref_no=:ls_billno;
		 
		 if sqlca.sqlcode = -1 then
			messagebox('Sql Error : During Checking Bill no Duplicate : ',sqlca.sqlerrtext);
			return 1;
		elseif sqlca.sqlcode = 0 then
			messagebox('Warning ','Bill No. Already Present for Voucher - '+ls_temp);
			return 1;
		end if
		
		
		if f_check_initial_space(ls_billno) = -1 then return 1	
	end if
	
	if dwo.name = 'vd_ref_date'  then
		ls_billdt=data
		if isnull(ls_billdt) or ls_billdt = '00/00/0000'  then
			messagebox('Warning','Please Enter Bill Date')
			return 
		end if
		
		if Date(ls_billdt) > date(string(today(),'dd/mm/yyyy'))  then
			messagebox('Alert!','Bill Date Should Be <= Current Date  !!!')
			return 1
		end if
	end if;	

	
	if dwo.name = 'vd_party_cd'  then
		ls_party = data
			//messagebox('ls_party',ls_party)
		if isnull(ls_party) or len(ls_party)=0 then
			messagebox('Error:', 'Please enter Party for this Expense')
			return 1
		end if			
		 select distinct sup_id into :ls_party from fb_supplier
			where nvl(SUP_ACTIVE,'1')='1' and trim(sup_id) =:ls_party;
	
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error: During Select Supplier ',sqlca.sqlerrtext)
				return 1
			end if;	
	end if	
	
	if dwo.name = 'vd_tds_per' and not isnull(dw_2.getitemnumber(row, 'vd_amount')) then
		ld_tds_amt = dw_2.getitemnumber(row, 'vd_amount')
		ld_tds_per = double(data)
		dw_2.setitem(row, 'vd_original_amt', (100*ld_tds_amt)/ld_tds_per);
	end if
end if;	

if dwo.name = 'vd_gst_ind'  then		
	gd_amount = dw_2.getitemnumber(row,'vd_amount')
	gs_party_cd = dw_2.getitemstring(row,'vd_party_cd')	
	gs_party_gstin     = dw_2.getitemstring(row,'vd_party_gstn')	
	gs_party_gstin_stcd = dw_2.getitemstring(row,'vd_party_gstnstate')	
	gs_party_gl  = dw_2.getitemstring(row,'vd_gl_cd')	
	gs_party_sgl = dw_2.getitemstring(row,'vd_sgl_cd')	
	gs_hsn_cd 			=  	dw_2.getitemstring(row,'vd_hsn_cd')	
	gs_CGST_RECGL 	= 	dw_2.getitemstring(row,'vd_cgst_recgl')					
	gs_SGST_RECGL 	= 	dw_2.getitemstring(row,'vd_sgst_recgl')	
	gs_IGST_RECGL 	= 	dw_2.getitemstring(row,'vd_igst_recgl')
	gs_CGST_PAYGL	= 	dw_2.getitemstring(row,'vd_cgst_paygl')
	gs_SGST_PAYGL 	= 	dw_2.getitemstring(row,'vd_sgst_paygl')
	gs_IGST_PAYGL 	= 	dw_2.getitemstring(row,'vd_igst_paygl')
	gs_GST_SUNDRY_PAY = dw_2.getitemstring(row,'vd_gst_sundry_pay')
	gs_CGST_RECSGL 	= 	dw_2.getitemstring(row,'vd_cgst_recsgl')					
	gs_SGST_RECSGL 	= 	dw_2.getitemstring(row,'vd_sgst_recsgl')	
	gs_IGST_RECSGL 	= 	dw_2.getitemstring(row,'vd_igst_recsgl')
	gs_CGST_PAYSGL	= 	dw_2.getitemstring(row,'vd_cgst_paysgl')
	gs_SGST_PAYSGL 	= 	dw_2.getitemstring(row,'vd_sgst_paysgl')
	gs_IGST_PAYSGL 	= 	dw_2.getitemstring(row,'vd_igst_paysgl')
	gs_GST_SUNDRY_PAYSGL = dw_2.getitemstring(row,'vd_gst_sundry_paysgl')
	gd_BILL_AMT 		= 	dw_2.getitemnumber(row,'vd_bill_amt')
	gd_CGST_PRCNT 	= dw_2.getitemnumber(row,'vd_cgst_prcnt')
	gd_SGST_PRCNT 	= dw_2.getitemnumber(row,'vd_sgst_prcnt')
	gd_IGST_PRCNT 	= dw_2.getitemnumber(row,'vd_igst_prcnt')
	gd_CGST_AMT = dw_2.getitemnumber(row,'vd_cgst_amt')
	gd_SGST_AMT = dw_2.getitemnumber(row,'vd_sgst_amt')
	gd_IGST_AMT = dw_2.getitemnumber(row,'vd_igst_amt')					
	gs_revchg_ind = dw_2.getitemstring(row,'vd_revchg_ind')		
	if isnull(gs_revchg_ind) then gs_revchg_ind = 'N';
	gs_revcatg  = dw_2.getitemstring(row,'vd_revchg_catg')			
	gd_date = ld_voudt
	
	
	if not isnull(dw_2.getitemdatetime(row,'vh_approved_dt')) then
		gs_apr_ind = 'Y'
	else
		gs_apr_ind = 'N'
	end if
	if isnull(gd_date) then
		messagebox('Warning !!!','Voucher Date is Blank, Please Check !!!')
		return 1
	end if
	if trim(data) = 'Y' and gd_amount > 0 then	open(w_gteacf007gst)
	if gb_retvalg	 = true and gs_apr_ind = 'N' then
			dw_2.setitem(row,'vd_hsn_cd',gs_hsn_cd)		
			dw_2.setitem(row,'vd_cgst_recgl',gs_CGST_RECGL)					
			dw_2.setitem(row,'vd_sgst_recgl',gs_SGST_RECGL)	
			dw_2.setitem(row,'vd_igst_recgl',gs_IGST_RECGL)
			dw_2.setitem(row,'vd_cgst_paygl',gs_CGST_PAYGL)
			dw_2.setitem(row,'vd_sgst_paygl',gs_SGST_PAYGL)
			dw_2.setitem(row,'vd_igst_paygl',gs_IGST_PAYGL)
			dw_2.setitem(row,'vd_gst_sundry_pay',trim(gs_GST_SUNDRY_PAY))

			dw_2.setitem(row,'vd_cgst_recsgl',gs_CGST_RECSGL)					
			dw_2.setitem(row,'vd_sgst_recsgl',gs_SGST_RECSGL)	
			dw_2.setitem(row,'vd_igst_recsgl',gs_IGST_RECSGL)
			dw_2.setitem(row,'vd_cgst_paysgl',gs_CGST_PAYSGL)
			dw_2.setitem(row,'vd_sgst_paysgl',gs_SGST_PAYSGL)
			dw_2.setitem(row,'vd_igst_paysgl',gs_IGST_PAYSGL)
			dw_2.setitem(row,'vd_gst_sundry_paysgl',trim(gs_GST_SUNDRY_PAYSGL))

			
			dw_2.setitem(row,'vd_bill_amt',gd_BILL_AMT)
			dw_2.setitem(row,'vd_cgst_prcnt',gd_CGST_PRCNT)
			dw_2.setitem(row,'vd_sgst_prcnt',gd_SGST_PRCNT)
			dw_2.setitem(row,'vd_igst_prcnt',gd_IGST_PRCNT)
			dw_2.setitem(row,'vd_cgst_amt',gd_CGST_AMT)
			dw_2.setitem(row,'vd_sgst_amt',gd_SGST_AMT)
			dw_2.setitem(row,'vd_igst_amt',gd_IGST_AMT)
	end if
else
			dw_2.setitem(row,'vd_hsn_cd',gs_hsn_cd)		
//			dw_2.setitem(row,'vd_party_cd',gs_party_cd)	
		//	dw_2.setitem(row,'vd_cgst_recgl',gs_CGST_RECGL)					
//			dw_2.setitem(row,'vd_sgst_recgl',gs_SGST_RECGL)	
//			dw_2.setitem(row,'vd_igst_recgl',gs_IGST_RECGL)
//			dw_2.setitem(row,'vd_cgst_paygl',gs_CGST_PAYGL)
//			dw_2.setitem(row,'vd_sgst_paygl',gs_SGST_PAYGL)
//			dw_2.setitem(row,'vd_igst_paygl',gs_IGST_PAYGL)
//			dw_2.setitem(row,'vd_gst_sundry_pay',gs_GST_SUNDRY_PAY)
//			dw_2.setitem(row,'vd_cgst_recsgl',gs_CGST_RECSGL)					
//			dw_2.setitem(row,'vd_sgst_recsgl',gs_SGST_RECSGL)	
//			dw_2.setitem(row,'vd_igst_recsgl',gs_IGST_RECSGL)
//			dw_2.setitem(row,'vd_cgst_paysgl',gs_CGST_PAYSGL)
//			dw_2.setitem(row,'vd_sgst_paysgl',gs_SGST_PAYSGL)
//			dw_2.setitem(row,'vd_igst_paysgl',gs_IGST_PAYSGL)
//			dw_2.setitem(row,'vd_gst_sundry_paysgl',gs_GST_SUNDRY_PAYSGL)
//			
			dw_2.setitem(row,'vd_bill_amt',gd_BILL_AMT)
//			dw_2.setitem(row,'vd_cgst_prcnt',gd_CGST_PRCNT)
//			dw_2.setitem(row,'vd_sgst_prcnt',gd_SGST_PRCNT)
//			dw_2.setitem(row,'vd_igst_prcnt',gd_IGST_PRCNT)
//			dw_2.setitem(row,'vd_cgst_amt',gd_CGST_AMT)
//			dw_2.setitem(row,'vd_sgst_amt',gd_SGST_AMT)
//			dw_2.setitem(row,'vd_igst_amt',gd_IGST_AMT)			
end if;


if dwo.name = 'vd_narr_free_text' then
	ls_gl_cd = dw_2.getitemstring(row,'vd_gl_cd')
	ls_sgl_cd = dw_2.getitemstring(row,'vd_sgl_cd') 
	ls_billno = dw_2.getitemstring(row,'vd_ref_no')
	ld_amt = dw_2.getitemnumber(row,'vd_amount')
	ld_billdt = dw_2.getitemdatetime(row,'vd_ref_date')
	if  wf_check_duplicate_rec(ls_gl_cd,ls_sgl_cd,ld_amt,data,ls_billno,ld_billdt) = -1 then return 1
end if
if dwo.name = 'vd_ref_no' then
	ls_gl_cd = dw_2.getitemstring(row,'vd_gl_cd')
	ls_sgl_cd = dw_2.getitemstring(row,'vd_sgl_cd') 
	ld_amt = dw_2.getitemnumber(row,'vd_amount')
	ls_narr = dw_2.getitemstring(row,'vd_narr_free_text')
	ld_billdt = dw_2.getitemdatetime(row,'vd_ref_date')
	if  wf_check_duplicate_rec(ls_gl_cd,ls_sgl_cd,ld_amt,ls_narr,data,ld_billdt) = -1 then return 1
end if
if dwo.name = 'vd_ref_date' then
	ls_gl_cd = dw_2.getitemstring(row,'vd_gl_cd')
	ls_sgl_cd = dw_2.getitemstring(row,'vd_sgl_cd') 
	ld_amt = dw_2.getitemnumber(row,'vd_amount')
	ls_narr = dw_2.getitemstring(row,'vd_narr_free_text')
	ls_billno = dw_2.getitemstring(row,'vd_ref_no')
	if  wf_check_duplicate_rec(ls_gl_cd,ls_sgl_cd,ld_amt,ls_narr,ls_billno,datetime(data)) = -1 then return 1
end if


if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then
		  dw_2.insertrow(0)
end if


cb_3.enabled = true
end event

event clicked;if dwo.name = 'ad_ind' then

		if len(dw_2.getitemstring(row,'vd_loan_type')) > 0 then 	
			gs_dc_ind 		= dw_2.getitemstring(row,'vd_dc_ind')
			gd_amount		= dw_2.getitemnumber(row,'vd_amount');
			gs_emp_id 		= dw_2.getitemstring(row,'vd_emp_id')
			gs_emp_pfno 	= dw_2.getitemstring(row,'vd_pf_no')					
			gd_int_rate		= dw_2.getitemnumber(row,'vd_int_rate')	
			gd_int_amt		= dw_2.getitemnumber(row,'vd_int_amt')
			gd_loan_bal		= dw_2.getitemnumber(row,'vd_loan_bal')
			gd_loan_type	= dw_2.getitemstring(row,'vd_loan_type')
			gs_dedn_dt		= string(dw_2.getitemdatetime(row,'vd_dedn_date'),'dd/mm/yyyy')
			gd_dedn_emi	= dw_2.getitemnumber(row,'vd_dedn_emi')
			
			if not isnull(dw_2.getitemdatetime(row,'vh_approved_dt')) then
				gs_apr_ind = 'Y'
			else
				gs_apr_ind = 'N'
			end if
		
			if gd_amount > 0 then open(w_gteacf007a)
			
			if gb_retval	 = true and gs_apr_ind = 'N' then
				     dw_2.setitem(row,'vd_emp_id',gs_emp_id)		
					dw_2.setitem(row,'vd_pf_no',gs_emp_pfno)					
					dw_2.setitem(row,'vd_int_rate',gd_int_rate)	
					dw_2.setitem(row,'vd_int_amt',gd_int_amt)
					dw_2.setitem(row,'vd_loan_bal',gd_loan_bal)
					dw_2.setitem(row,'vd_dedn_date',datetime(date(gs_dedn_dt)))
					dw_2.setitem(row,'vd_dedn_emi',gd_dedn_emi)
			end if;
   		end if
end if
end event

type dw_3 from datawindow within w_gteacf007
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 1426
integer y = 1248
integer width = 3072
integer height = 640
integer taborder = 50
string dataobject = "dw_gteacf007b"
boolean hscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'vh_entry_by',gs_user)
		dw_1.setitem(newrow,'vh_entry_dt',datetime(today()))
		dw_1.setitem(dw_1.getrow(),'indent_holocalflag','1')
		dw_1.setitem(dw_1.getrow(),'INDENT_ACTIVE','1')
	     dw_1.setcolumn('indent_deliverytype')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;///chek for Voucher type
if dwo.name = 'vh_vou_type'  then
	ls_temp = data
	if gs_opt = 'CV'  then
		if ls_temp <> 'CPV' and ls_temp <> 'CRV' then 
			messagebox('Warning!','Voucher Type Should Be Cash Payment/ Cash Receipt, Please Check !!!')
			return 1
		end if
	elseif gs_opt = 'BV' then
		
		idw_contragl.SetFilter ("ledgertype like 'BANK'") 
		idw_contragl.filter( )		
		
		if ls_temp<>'BPV' and ls_temp <> 'BRV' then 
			messagebox('Warning!','Voucher Type Should Be Bank Payment/ Bank Receipt, Please Check !!!')
			return 1
		end if
	elseif gs_opt = 'JV' then
		if ls_temp<>'JV' then 
			messagebox('Warning!','Voucher Type Should Be Journal Voucher, Please Check !!!')
			return 1
		end if		
	else
		messagebox('Warning!','Voucher Type Should Be Bank/Cach/Journal Voucher, Please Check !!!')
		return 1
	end if
end if	


if dwo.name = 'vh_vou_type'  and lb_query = false then
	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_1.setfocus()
		dw_1.setcolumn('vh_vou_type')		
	end if;	
end if

if dwo.name = 'vh_vou_date'  and lb_query = false then
	ld_voudt=datetime(data)
	 if f_check_fin_yr(ld_voudt) = -1 then;	return 1;end if;
	dw_1.setitem(dw_1.getrow(),'vh_ac_year',long(string(ld_voudt,'yyyymm')))
end if

	if dwo.name = 'vh_contra_gl' then
		ls_contra_gl = data		
		//if  wf_check_duplicate_rec(ls_contra_gl) = -1 then return 1
		idw_contrasgl.SetFilter ("acledger_id = '"+trim(data)+"'") 
		idw_contrasgl.filter( )		
	end if
	
	if dwo.name = 'vh_contra_sgl' then
		ls_contra_sgl= data
	end if
	
if lb_query = false then
	ld_old_entry_dt=dw_1.getitemdatetime(dw_1.getrow(),'old_entry_dt') 
end if
dw_1.setitem(row,'vh_entry_by',gs_user)
dw_1.setitem(row,'vh_entry_dt',datetime(today()))

if dwo.name = 'appr_flag'  then
	ls_tmp_id =data
	if ls_tmp_id = 'Y' then
		dw_1.setitem(row,'vh_approved_by',gs_user)
		dw_1.setitem(row,'vh_approved_dt',datetime(today())) 
	elseif ls_tmp_id = 'N' then		
		setnull(ls_temp)
		dw_1.setitem(row,'vh_approved_by',ls_temp)
		dw_1.setitem(row,'vh_approved_dt',datetime(ls_temp)) 
	end if	
end if;

cb_3.enabled = true
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			ll_ref = dw_1.getitemnumber(dw_1.getrow(),'vh_doc_srl')
			dw_2.reset()
			dw_2.retrieve(ll_ref)
		end if
	end if
end if
end event

