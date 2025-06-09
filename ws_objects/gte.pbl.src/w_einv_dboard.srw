$PBExportHeader$w_einv_dboard.srw
forward
global type w_einv_dboard from window
end type
type cb_1 from commandbutton within w_einv_dboard
end type
type cbx_2 from checkbox within w_einv_dboard
end type
type cb_6 from commandbutton within w_einv_dboard
end type
type cb_4 from commandbutton within w_einv_dboard
end type
type cb_2 from commandbutton within w_einv_dboard
end type
type dw_1 from datawindow within w_einv_dboard
end type
end forward

global type w_einv_dboard from window
integer width = 4859
integer height = 2444
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
cb_1 cb_1
cbx_2 cbx_2
cb_6 cb_6
cb_4 cb_4
cb_2 cb_2
dw_1 dw_1
end type
global w_einv_dboard w_einv_dboard

type variables
long ll_cnt, ll_cnt1,ix,ll_user_level,ll_last,ll_last1, ll_ctr, li_temp
string ls_acsaleno, ls_aucsaleno, ls_ausid,ls_spmanid,ls_spid,ls_spbid,ls_invno,ls_grade, ls_temp, ls_ac_dt,ls_appr_ind,ls_tmp_id, ls_saleno, ls_file
string ls_aus_id, ls_brok, ls_iss_locn, ls_rec_locn, ls_iss_gstn, ls_rec_gstn, ls_hsn, ls_iss_gstin, ls_rec_gstin, ls_aprv_by, ls_yrmn
long ll_stno,ll_endno,ll_nochest,ll_season, ll_rec
boolean lb_neworder, lb_query
double ld_saleval,ld_due,ld_bankchrg, ld_amount, ld_totval, ld_paid, ld_balamt,ld_bnkchrgproportion, ld_chqamt,ld_net,ld_brokerage, ld_cgst_per, ld_sgst_per, ld_igst_per,ld_cgst_amt, ld_sgst_amt, ld_igst_amt, ld_inspchrg,ld_miscchrg
datetime ld_dt, ld_aus_dt,ld_aus_date, ld_prompt_dt, ld_acsaledt, ld_aprv_dt
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_prod)
public function integer wf_genjson (string fs_docno)
public function integer wf_callapi (string fs_json_string, string fs_docno)
public function long wf_gen_csv ()
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

public function integer wf_check_fillcol (integer fl_row);//if dw_2.rowcount() > 0 and fl_row > 0 then
//	if (isnull(dw_2.getitemstring(fl_row,'tmp_id')) or  len(dw_2.getitemstring(fl_row,'tmp_id'))=0 or &
//		 isnull(dw_2.getitemnumber(fl_row,'sad_quantity')) or dw_2.getitemnumber(fl_row,'sad_quantity') = 0 ) then
//	    messagebox('Warning: One Of The Following Fields Are Blank','Product, Order Quantity, Please Check !!!')
//		 return -1
//	end if
//end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_prod);long fl_row
string ls_prod1

//dw_2.SelectRow(0, FALSE)
//if dw_2.rowcount() > 1 then
//	for fl_row = 1 to (dw_2.rowcount() - 1)
//		ls_prod1 = dw_2.getitemstring(fl_row,'tmp_id')
//		
//		if trim(ls_prod1) = trim(fs_prod) then
//			dw_2.SelectRow(fl_row, TRUE)
//			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
//			return -1
//		end if
//	next 
//end if 

return 1
end function

public function integer wf_genjson (string fs_docno);string ls_version, ls_irn, ls_taxsch, ls_suptyp, ls_regrev, ls_ecmgstin, ls_igstonintra, ls_doctyp, ls_docno, ls_docdt, ls_sgstin, ls_slglnm, ls_strdnm, ls_saddr1, ls_saddr2, ls_sloc, ls_spin, ls_sstcd, ls_sph, ls_sem
string ls_bgstin, ls_blglnm, ls_btrdnm, ls_baddr1, ls_baddr2, ls_bloc, ls_bpin, ls_bstcd, ls_bpos, ls_bph, ls_bem, ls_distrdnm, ls_disaddr1, ls_disaddr2, ls_disloc, ls_dispin, ls_disstcd, ls_shipgstin, ls_shiplglnm, ls_shiptrdnm
string ls_shipaddr1, ls_shipaddr2, ls_shiploc, ls_shippin, ls_shipstcd, ls_paynm, ls_payacctdet, ls_paymode, ls_payfininsbr, ls_payterm, ls_payinstr, ls_paycrtrn, ls_paydirdr, ls_paycrday, ls_paypaidamt, ls_paypaymtdue
string ls_refinvrm, ls_invstdt, ls_invenddt, ls_inv_no, ls_invdt, ls_othrefno, ls_recadvrefr, ls_recadvdt, ls_tendrefr, ls_contrrefr, ls_extrefr, ls_projrefr, ls_porefr, ls_porefdt, ls_url, ls_docs, ls_infodtls, ls_expshipbno
string ls_expshipbdt, ls_expport, ls_exprefclm, ls_expforcur, ls_expcntcode, ls_expduty, ls_transid, ls_transname, ls_transmode, ls_distance, ls_transdocno, ls_transdocdt, ls_vehno, ls_vehtype

string ls_slno, ls_prddesc, ls_isservc, ls_hsncd, ls_barcde, ls_bchnm, ls_bchexpdt, ls_bchwrdt, ls_qty, ls_freeqty, ls_uom, ls_unitprice, ls_totamt, ls_discount, ls_pretaxval, ls_assamt, ls_gstrt, ls_igstamt, ls_cgstamt, ls_sgstamt
string ls_cesrt, ls_cesamt, ls_cesnonadvlamt, ls_statecesrt, ls_statecesamt, ls_statecesnonadvlamt, ls_othchrg, ls_totitemval, ls_ordlineref, ls_orgcntry, ls_prdslno, ls_attnm, ls_attval

string ls_trandtls, ls_docdtls, ls_sellerdtls, ls_buyerdtls, ls_dispdtls, ls_shipdtls, ls_itemlist, ls_bchdtls, ls_attribdtls, ls_paydtls, ls_refdtls, ls_docperddtls, ls_predocdtls, ls_contrdtls, ls_addldocdtls, ls_expdtls, ls_ewbdtls

string ls_json_string, ls_rec
long li_filenum

select distinct VERSION, IRN, TAXSCH, SUPTYP, REGREV, ECMGSTIN, IGSTONINTRA, DOCTYP, DOCNO, to_char(DOCDT,'dd/mm/yyyy'), SGSTIN, SLGLNM, STRDNM, SADDR1, SADDR2, SLOC, to_char(SPIN), SSTCD, SPH, SEM, 
	BGSTIN, BLGLNM, BTRDNM, BADDR1, BADDR2, BLOC, to_char(BPIN), BSTCD, BPOS, BPH, BEM, DISTRDNM, DISADDR1, DISADDR2, DISLOC, to_char(DISPIN), DISSTCD, SHIPGSTIN, SHIPLGLNM, SHIPTRDNM, 
	SHIPADDR1, SHIPADDR2, SHIPLOC, to_char(SHIPPIN), SHIPSTCD, PAYNM, PAYACCTDET, PAYMODE, PAYFININSBR, PAYTERM, PAYINSTR, PAYCRTRN, PAYDIRDR, to_char(PAYCRDAY), to_char(PAYPAIDAMT), to_char(PAYPAYMTDUE),
	REFINVRM, to_char(INVSTDT,'dd/mm/yyyy'), to_char(INVENDDT,'dd/mm/yyyy'), INVNO, to_char(INVDT,'dd/mm/yyyy'), OTHREFNO, RECADVREFR, to_char(RECADVDT,'dd/mm/yyyy'), TENDREFR, CONTRREFR, EXTREFR, PROJREFR, POREFR, to_char(POREFDT,'dd/mm/yyyy'), URL, DOCS, INFODTLS, EXPSHIPBNO,
	 to_char(EXPSHIPBDT,'dd/mm/yyyy'), EXPPORT, EXPREFCLM, EXPFORCUR, EXPCNTCODE, to_char(EXPDUTY), TRANSID, TRANSNAME, TRANSMODE, to_char(DISTANCE), TRANSDOCNO, to_char(TRANSDOCDT,'dd/mm/yyyy'), VEHNO, VEHTYPE
into :ls_version, :ls_irn, :ls_taxsch, :ls_suptyp, :ls_regrev, :ls_ecmgstin, :ls_igstonintra, :ls_doctyp, :ls_docno, :ls_docdt, :ls_sgstin, :ls_slglnm, :ls_strdnm, :ls_saddr1, :ls_saddr2, :ls_sloc, :ls_spin, :ls_sstcd, :ls_sph, :ls_sem,
	:ls_bgstin, :ls_blglnm, :ls_btrdnm, :ls_baddr1, :ls_baddr2, :ls_bloc, :ls_bpin, :ls_bstcd, :ls_bpos, :ls_bph, :ls_bem, :ls_distrdnm, :ls_disaddr1, :ls_disaddr2, :ls_disloc, :ls_dispin, :ls_disstcd, :ls_shipgstin, :ls_shiplglnm, :ls_shiptrdnm,
	:ls_shipaddr1, :ls_shipaddr2, :ls_shiploc, :ls_shippin, :ls_shipstcd, :ls_paynm, :ls_payacctdet, :ls_paymode, :ls_payfininsbr, :ls_payterm, :ls_payinstr, :ls_paycrtrn, :ls_paydirdr, :ls_paycrday, :ls_paypaidamt, :ls_paypaymtdue,
	:ls_refinvrm, :ls_invstdt, :ls_invenddt, :ls_inv_no, :ls_invdt, :ls_othrefno, :ls_recadvrefr, :ls_recadvdt, :ls_tendrefr, :ls_contrrefr, :ls_extrefr, :ls_projrefr, :ls_porefr, :ls_porefdt, :ls_url, :ls_docs, :ls_infodtls, :ls_expshipbno,
	:ls_expshipbdt, :ls_expport, :ls_exprefclm, :ls_expforcur, :ls_expcntcode, :ls_expduty, :ls_transid, :ls_transname, :ls_transmode, :ls_distance, :ls_transdocno, :ls_transdocdt, :ls_vehno, :ls_vehtype
 from fb_einvoice
 where docno = :fs_docno;

 
 if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while selecting header data : '+sqlca.sqlerrtext)
	rollback using sqlca;
	return -1;
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','No invoice s found')
	rollback using sqlca;
	return -1;
end if

if isnull(ls_version) then 
	ls_version = 'null';
else
	ls_version = '"'+ls_version+'"'
end if

if isnull(ls_irn) then 
	ls_irn = 'null';
else
	ls_irn = '"'+ls_irn+'"'
end if

if isnull(ls_taxsch) then 
	ls_taxsch = 'null';
else
	ls_taxsch = '"'+ls_taxsch+'"'
end if

if isnull(ls_suptyp) then 
	ls_suptyp = 'null';
else
	ls_suptyp = '"'+ls_suptyp+'"'
end if

if isnull(ls_regrev) then 
	ls_regrev = 'null';
else
	ls_regrev = '"'+ls_regrev+'"'
end if

if isnull(ls_ecmgstin) then 
	ls_ecmgstin = 'null';
else
	ls_ecmgstin = '"'+ls_ecmgstin+'"'
end if

if isnull(ls_igstonintra) then 
	ls_igstonintra = 'null';
else
	ls_igstonintra = '"'+ls_igstonintra+'"'
end if

if isnull(ls_doctyp) then 
	ls_doctyp = 'null';
else
	ls_doctyp = '"'+ls_doctyp+'"'
end if

if isnull(ls_docno) then 
	ls_docno = 'null';
else
	ls_docno = '"'+ls_docno+'"'
end if

if isnull(ls_docdt) then 
	ls_docdt = 'null';
else
	ls_docdt = '"'+ls_docdt+'"'
end if

if isnull(ls_sgstin) then 
	ls_sgstin = 'null';
else
	ls_sgstin = '"'+ls_sgstin+'"'
end if
 
if isnull(ls_slglnm) then 
	ls_slglnm = 'null';
else
	ls_slglnm = '"'+ls_slglnm+'"'
end if

if isnull(ls_strdnm) then 
	ls_strdnm = 'null';
else
	ls_strdnm = '"'+ls_strdnm+'"'
end if

if isnull(ls_saddr1) then 
	ls_saddr1 = 'null';
else
	ls_saddr1 = '"'+ls_saddr1+'"'
end if

if isnull(ls_saddr2) then 
	ls_saddr2 = 'null';
else
	ls_saddr2 = '"'+ls_saddr2+'"'
end if

if isnull(ls_sloc) then 
	ls_sloc = 'null';
else
	ls_sloc = '"'+ls_sloc+'"'
end if

if isnull(ls_spin) then ls_spin = 'null';

if isnull(ls_sstcd) then 
	ls_sstcd = 'null';
else
	ls_sstcd = '"'+ls_sstcd+'"'
end if

if isnull(ls_sph) then 
	ls_sph = 'null';
else
	ls_sph = '"'+ls_sph+'"'
end if

if isnull(ls_sem) then 
	ls_sem = 'null';
else
	ls_sem = '"'+ls_sem+'"'
end if

if isnull(ls_bgstin) then 
	ls_bgstin = 'null';
else
	ls_bgstin = '"'+ls_bgstin+'"'
end if

if isnull(ls_blglnm) then 
	ls_blglnm = 'null';
else
	ls_blglnm = '"'+ls_blglnm+'"'
end if

if isnull(ls_btrdnm) then 
	ls_btrdnm = 'null';
else
	ls_btrdnm = '"'+ls_btrdnm+'"'
end if

if isnull(ls_baddr1) then 
	ls_baddr1 = 'null';
else
	ls_baddr1 = '"'+ls_baddr1+'"'
end if

if isnull(ls_baddr2) then 
	ls_baddr2 = 'null';
else
	ls_baddr2 = '"'+ls_baddr2+'"'
end if

if isnull(ls_bloc) then 
	ls_bloc = 'null';
else
	ls_bloc = '"'+ls_bloc+'"'
end if

if isnull(ls_bpin) then ls_bpin = 'null';

if isnull(ls_bstcd) then 
	ls_bstcd = 'null';
else
	ls_bstcd = '"'+ls_bstcd+'"'
end if

if isnull(ls_bpos) then 
	ls_bpos = 'null';
else
	ls_bpos = '"'+ls_bpos+'"'
end if

if isnull(ls_bph) then 
	ls_bph = 'null';
else
	ls_bph = '"'+ls_bph+'"'
end if

if isnull(ls_bem) then 
	ls_bem = 'null';
else
	ls_bem = '"'+ls_bem+'"'
end if

if isnull(ls_distrdnm) then 
	ls_distrdnm = 'null';
else
	ls_distrdnm = '"'+ls_distrdnm+'"'
end if

if isnull(ls_disaddr1) then 
	ls_disaddr1 = 'null';
else
	ls_disaddr1 = '"'+ls_disaddr1+'"'
end if

if isnull(ls_disaddr2) then 
	ls_disaddr2 = 'null';
else
	ls_disaddr2 = '"'+ls_disaddr2+'"'
end if

if isnull(ls_disloc) then 
	ls_disloc = 'null';
else
	ls_disloc = '"'+ls_disloc+'"'
end if

if isnull(ls_dispin) then ls_dispin = 'null';

if isnull(ls_disstcd) then 
	ls_disstcd = 'null';
else
	ls_disstcd = '"'+ls_disstcd+'"'
end if

if isnull(ls_shipgstin) then 
	ls_shipgstin = 'null';
else
	ls_shipgstin = '"'+ls_shipgstin+'"'
end if
 
if isnull(ls_shiplglnm) then 
	ls_shiplglnm = 'null';
else
	ls_shiplglnm = '"'+ls_shiplglnm+'"'
end if 

if isnull(ls_shiptrdnm) then 
	ls_shiptrdnm = 'null';
else
	ls_shiptrdnm = '"'+ls_shiptrdnm+'"'
end if

if isnull(ls_shipaddr1) then 
	ls_shipaddr1 = 'null';
else
	ls_shipaddr1 = '"'+ls_shipaddr1+'"'
end if

if isnull(ls_shipaddr2) then 
	ls_shipaddr2 = 'null';
else
	ls_shipaddr2 = '"'+ls_shipaddr2+'"'
end if
 
if isnull(ls_shiploc) then 
	ls_shiploc = 'null';
else
	ls_shiploc = '"'+ls_shiploc+'"'
end if

if isnull(ls_shippin) then ls_shippin = 'null';

if isnull(ls_shipstcd) then 
	ls_shipstcd = 'null';
else
	ls_shipstcd = '"'+ls_shipstcd+'"'
end if

if isnull(ls_paynm) then 
	ls_paynm = 'null';
else
	ls_paynm = '"'+ls_paynm+'"'
end if

if isnull(ls_payacctdet) then 
	ls_payacctdet = 'null';
else
	ls_payacctdet = '"'+ls_payacctdet+'"'
end if

if isnull(ls_paymode) then 
	ls_paymode = 'null';
else
	ls_paymode = '"'+ls_paymode+'"'
end if

if isnull(ls_payfininsbr) then 
	ls_payfininsbr = 'null';
else
	ls_payfininsbr = '"'+ls_payfininsbr+'"'
end if

if isnull(ls_payterm) then 
	ls_payterm = 'null';
else
	ls_payterm = '"'+ls_payterm+'"'
end if

if isnull(ls_payinstr) then 
	ls_payinstr = 'null';
else
	ls_payinstr = '"'+ls_payinstr+'"'
end if

if isnull(ls_paycrtrn) then 
	ls_paycrtrn = 'null';
else
	ls_paycrtrn = '"'+ls_paycrtrn+'"'
end if

if isnull(ls_paydirdr) then 
	ls_paydirdr = 'null';
else
	ls_paydirdr = '"'+ls_paydirdr+'"'
end if

if isnull(ls_paycrday) then ls_paycrday = '0';

if isnull(ls_paypaidamt) then ls_paypaidamt = '0';

if isnull(ls_paypaymtdue) then ls_paypaymtdue = '0';

if isnull(ls_refinvrm) then 
	ls_refinvrm = '"NOT NEEDED"';
else
	ls_refinvrm = '"'+ls_refinvrm+'"'
end if

if isnull(ls_invstdt) then 
	ls_invstdt = 'null';
else
	ls_invstdt = '"'+ls_invstdt+'"'
end if

if isnull(ls_invenddt) then 
	ls_invenddt = 'null';
else
	ls_invenddt = '"'+ls_invenddt+'"'
end if

if isnull(ls_inv_no) then 
	ls_inv_no = 'null';
else
	ls_inv_no = '"'+ls_inv_no+'"'
end if

if isnull(ls_invdt) then 
	ls_invdt = 'null';
else
	ls_invdt = '"'+ls_invdt+'"'
end if

if isnull(ls_othrefno) then 
	ls_othrefno = 'null';
else
	ls_othrefno = '"'+ls_othrefno+'"'
end if

if isnull(ls_recadvrefr) then 
	ls_recadvrefr = 'null';
else
	ls_recadvrefr = '"'+ls_recadvrefr+'"'
end if

if isnull(ls_recadvdt) then 
	ls_recadvdt = 'null';
else
	ls_recadvdt = '"'+ls_recadvdt+'"'
end if

if isnull(ls_tendrefr) then 
	ls_tendrefr = 'null';
else
	ls_tendrefr = '"'+ls_tendrefr+'"'
end if

if isnull(ls_contrrefr) then 
	ls_contrrefr = 'null';
else
	ls_contrrefr = '"'+ls_contrrefr+'"'
end if

if isnull(ls_extrefr) then 
	ls_extrefr = 'null';
else
	ls_extrefr = '"'+ls_extrefr+'"'
end if

if isnull(ls_projrefr) then 
	ls_projrefr = 'null';
else
	ls_projrefr = '"'+ls_projrefr+'"'
end if

if isnull(ls_porefr) then 
	ls_porefr = 'null';
else
	ls_porefr = '"'+ls_porefr+'"'
end if

if isnull(ls_porefdt) then 
	ls_porefdt = 'null';
else
	ls_porefdt = '"'+ls_porefdt+'"'
end if

if isnull(ls_url) then 
	ls_url = 'null';
else
	ls_url = '"'+ls_url+'"'
end if

if isnull(ls_docs) then 
	ls_docs = 'null';
else
	ls_docs = '"'+ls_docs+'"'
end if

if isnull(ls_infodtls) then 
	ls_infodtls = 'null';
else
	ls_infodtls = '"'+ls_infodtls+'"'
end if

if isnull(ls_expshipbno) then 
	ls_expshipbno = 'null';
else
	ls_expshipbno = '"'+ls_expshipbno+'"'
end if

if isnull(ls_expshipbdt) then 
	ls_expshipbdt = 'null';
else
	ls_expshipbdt = '"'+ls_expshipbdt+'"'
end if

if isnull(ls_expport) then 
	ls_expport = 'null';
else
	ls_expport = '"'+ls_expport+'"'
end if

if isnull(ls_exprefclm) then 
	ls_exprefclm = 'null';
else
	ls_exprefclm = '"'+ls_exprefclm+'"'
end if

if isnull(ls_expforcur) then 
	ls_expforcur = 'null';
else
	ls_expforcur = '"'+ls_expforcur+'"'
end if

if isnull(ls_expcntcode) then 
	ls_expcntcode = 'null';
else
	ls_expcntcode = '"'+ls_expcntcode+'"'
end if

if isnull(ls_expduty) then ls_expduty = '0';

if isnull(ls_transid) then 
	ls_transid = 'null';
else
	ls_transid = '"'+ls_transid+'"'
end if

//if isnull(ls_transname) then 
//	ls_transname = 'null';
//else
//	ls_transname = '"'+ls_transname+'"'
//end if

ls_transname = 'null';

if isnull(ls_transmode) then 
	ls_transmode = 'null';
else
	ls_transmode = '"'+ls_transmode+'"'
end if

if isnull(ls_distance) then ls_distance = '0';

if isnull(ls_transdocno) then 
	ls_transdocno = 'null';
else
	ls_transdocno = '"'+ls_transdocno+'"'
end if

if isnull(ls_transdocdt) then 
	ls_transdocdt = 'null';
else
	ls_transdocdt = '"'+ls_transdocdt+'"'
end if

if isnull(ls_vehno) then 
	ls_vehno = 'null';
else
	ls_vehno = '"'+ls_vehno+'"'
end if
 
if isnull(ls_vehtype) then 
	ls_vehtype = 'null';
else
	ls_vehtype = '"'+ls_vehtype+'"'
end if


declare c2 cursor for
	select SLNO, PRDDESC, ISSERVC, HSNCD, BARCDE, BCHNM, to_char(BCHEXPDT,'dd/mm/yyyy'), to_char(BCHWRDT,'dd/mm/yyyy'), to_char(QTY), to_char(FREEQTY), UNIT, to_char(UNITPRICE), to_char(TOTAMT), to_char(DISCOUNT), to_char(PRETAXVAL), to_char(ASSAMT), to_char(GSTRT), to_char(IGSTAMT), to_char(CGSTAMT), to_char(SGSTAMT), 
	to_char(CESRT), to_char(CESAMT), to_char(CESNONADVLAMT), to_char(STATECESRT), to_char(STATECESAMT), to_char(STATECESNONADVLAMT), to_char(OTHCHRG), to_char(TOTITEMVAL), ORDLINEREF, ORGCNTRY, PRDSLNO, ATTNM, ATTVAL
	from fb_einvoice
	where docno = :fs_docno;
	
open c2;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while opening cursor c2 : '+sqlca.sqlerrtext)
	rollback using sqlca;
	return -1
elseif sqlca.sqlcode = 0 then
	setnull(ls_slno); setnull(ls_prddesc); setnull(ls_isservc); setnull(ls_hsncd); setnull(ls_barcde); setnull(ls_bchnm); setnull(ls_bchexpdt); setnull(ls_bchwrdt); setnull(ls_qty); setnull(ls_freeqty); setnull(ls_uom); setnull(ls_unitprice); setnull(ls_totamt); setnull(ls_discount); setnull(ls_pretaxval); setnull(ls_assamt); setnull(ls_gstrt); setnull(ls_igstamt); setnull(ls_cgstamt); setnull(ls_sgstamt); setnull(ls_cesrt); setnull(ls_cesamt); setnull(ls_cesnonadvlamt); setnull(ls_statecesrt); setnull(ls_statecesamt); setnull(ls_statecesnonadvlamt); setnull(ls_othchrg); setnull(ls_totitemval); setnull(ls_ordlineref); setnull(ls_orgcntry); setnull(ls_prdslno); setnull(ls_attnm); setnull(ls_attval);
	setnull(ls_bchdtls); setnull(ls_attribdtls);
	ls_itemlist = '['
	fetch c2 into :ls_slno, :ls_prddesc, :ls_isservc, :ls_hsncd, :ls_barcde, :ls_bchnm, :ls_bchexpdt, :ls_bchwrdt, :ls_qty, :ls_freeqty, :ls_uom, :ls_unitprice, :ls_totamt, :ls_discount, :ls_pretaxval, :ls_assamt, :ls_gstrt, :ls_igstamt, :ls_cgstamt, :ls_sgstamt, :ls_cesrt, :ls_cesamt, :ls_cesnonadvlamt, :ls_statecesrt, :ls_statecesamt, :ls_statecesnonadvlamt, :ls_othchrg, :ls_totitemval, :ls_ordlineref, :ls_orgcntry, :ls_prdslno, :ls_attnm, :ls_attval;
	do while sqlca.sqlcode <> 100
		
		if isnull(ls_slno) then 
			ls_slno = 'null';
		else
			ls_slno = '"'+ls_slno+'"'
		end if
		
		if isnull(ls_prddesc) then 
			ls_prddesc = 'null';
		else
			ls_prddesc = '"'+ls_prddesc+'"'
		end if
		
		if isnull(ls_isservc) then 
			ls_isservc = 'null';
		else
			ls_isservc = '"'+ls_isservc+'"'
		end if
		
		if isnull(ls_hsncd) then 
			ls_hsncd = 'null';
		else
			ls_hsncd = '"'+ls_hsncd+'"'
		end if
		
		if isnull(ls_barcde) then 
			ls_barcde = 'null';
		else
			ls_barcde = '"'+ls_barcde+'"'
		end if
		
		if isnull(ls_bchnm) then 
			ls_bchnm = 'null';
		else
			ls_bchnm = '"'+ls_bchnm+'"'
		end if
		
		if isnull(ls_bchexpdt) then 
			ls_bchexpdt = 'null';
		else
			ls_bchexpdt = '"'+ls_bchexpdt+'"'
		end if

		if isnull(ls_bchwrdt) then 
			ls_bchwrdt = 'null';
		else
			ls_bchwrdt = '"'+ls_bchwrdt+'"'
		end if
		
		if isnull(ls_qty) then ls_qty = '0';
		
		if isnull(ls_freeqty) then ls_freeqty = '0';
			
		if isnull(ls_uom) then 
			ls_uom = 'null';
		else
			ls_uom = '"'+ls_uom+'"'
		end if
		
		if isnull(ls_unitprice) then ls_unitprice = '0';
		
		if isnull(ls_totamt) then ls_totamt = '0';
		
		if isnull(ls_discount) then ls_discount = '0';
		
		if isnull(ls_pretaxval) then ls_pretaxval = '0';
		
		if isnull(ls_assamt) then ls_assamt = '0';
		
		if isnull(ls_gstrt) then ls_gstrt = '0';
		
		if isnull(ls_igstamt) then ls_igstamt = '0';
		
		if isnull(ls_cgstamt) then ls_cgstamt = '0';
		
		if isnull(ls_sgstamt) then ls_sgstamt = '0';
		
		if isnull(ls_cesrt) then ls_cesrt = '0';
		
		if isnull(ls_cesamt) then ls_cesamt = '0';
		
		if isnull(ls_cesnonadvlamt) then ls_cesnonadvlamt = '0';
		
		if isnull(ls_statecesrt) then ls_statecesrt = '0';
		
		if isnull(ls_statecesamt) then ls_statecesamt = '0';
		
		if isnull(ls_statecesnonadvlamt) then ls_statecesnonadvlamt = '0';
		
		if isnull(ls_othchrg) then ls_othchrg = '0';
		
		if isnull(ls_totitemval) then ls_totitemval = '0';
		
		if isnull(ls_ordlineref) then 
			ls_ordlineref = 'null';
		else
			ls_ordlineref = '"'+ls_ordlineref+'"'
		end if
		
		if isnull(ls_orgcntry) then 
			ls_orgcntry = 'null';
		else
			ls_orgcntry = '"'+ls_orgcntry+'"'
		end if
		
		if isnull(ls_prdslno) then 
			ls_prdslno = 'null';
		else
			ls_prdslno = '"'+ls_prdslno+'"'
		end if
		
		if isnull(ls_attnm) then 
			ls_attnm = 'null';
		else
			ls_attnm = '"'+ls_attnm+'"'
		end if
		
		if isnull(ls_attval) then 
			ls_attval = 'null';
		else
			ls_attval = '"'+ls_attval+'"'
		end if		
		
		ls_bchdtls = '{"BchNm": '+ls_bchnm+',"BchExpDt": '+ls_bchexpdt+',"BchWrDt": '+ls_bchwrdt+'}'
		ls_attribdtls = '[{"AttNm": '+ls_attnm+',"AttVal": '+ls_attval+'}]'
		
		ls_itemlist = ls_itemlist + '{"SlNo": '+ls_slno+',"PrdDesc": '+ls_prddesc+',"IsServc": '+ls_isservc+',"HsnCd": '+ls_hsncd+',"Barcde": '+ls_barcde+',"BchDtls": '+ls_bchdtls+',"Qty": '+ls_qty+',"FreeQty": '+ls_freeqty+',"Unit": '+ls_uom+',"UnitPrice": '+ls_unitprice+',"TotAmt": '+ls_totamt+',"Discount": '+ls_discount+',"PreTaxVal": '+ls_pretaxval+',"AssAmt": '+ls_assamt+',"GstRt": '+ls_gstrt+',"IgstAmt": '+ls_igstamt+',"CgstAmt": '+ls_cgstamt+',"SgstAmt": '+ls_sgstamt+',"CesRt": '+ls_cesrt+',"CesAmt": '+ls_cesamt+',"CesNonAdvlAmt": '+ls_cesnonadvlamt+',"StateCesRt": '+ls_statecesrt+',"StateCesAmt": '+ls_statecesamt+',"StateCesNonAdvlAmt": '+ls_statecesnonadvlamt+',"OthChrg": '+ls_othchrg+',"TotItemVal": '+ls_totitemval+',"OrdLineRef": '+ls_ordlineref+',"OrgCntry": '+ls_orgcntry+',"PrdSlNo": '+ls_prdslno+',"AttribDtls": '+ls_attribdtls+'},';
			
		setnull(ls_slno); setnull(ls_prddesc); setnull(ls_isservc); setnull(ls_hsncd); setnull(ls_barcde); setnull(ls_bchnm); setnull(ls_bchexpdt); setnull(ls_bchwrdt); setnull(ls_qty); setnull(ls_freeqty); setnull(ls_uom); setnull(ls_unitprice); setnull(ls_totamt); setnull(ls_discount); setnull(ls_pretaxval); setnull(ls_assamt); setnull(ls_gstrt); setnull(ls_igstamt); setnull(ls_cgstamt); setnull(ls_sgstamt); setnull(ls_cesrt); setnull(ls_cesamt); setnull(ls_cesnonadvlamt); setnull(ls_statecesrt); setnull(ls_statecesamt); setnull(ls_statecesnonadvlamt); setnull(ls_othchrg); setnull(ls_totitemval); setnull(ls_ordlineref); setnull(ls_orgcntry); setnull(ls_prdslno); setnull(ls_attnm); setnull(ls_attval);
		setnull(ls_bchdtls); setnull(ls_attribdtls);
		fetch c2 into :ls_slno, :ls_prddesc, :ls_isservc, :ls_hsncd, :ls_barcde, :ls_bchnm, :ls_bchexpdt, :ls_bchwrdt, :ls_qty, :ls_freeqty, :ls_uom, :ls_unitprice, :ls_totamt, :ls_discount, :ls_pretaxval, :ls_assamt, :ls_gstrt, :ls_igstamt, :ls_cgstamt, :ls_sgstamt, :ls_cesrt, :ls_cesamt, :ls_cesnonadvlamt, :ls_statecesrt, :ls_statecesamt, :ls_statecesnonadvlamt, :ls_othchrg, :ls_totitemval, :ls_ordlineref, :ls_orgcntry, :ls_prdslno, :ls_attnm, :ls_attval;
	loop
	close c2;
	ls_itemlist = mid(ls_itemlist,1,len(ls_itemlist)-1) + ']';	
end if

ls_trandtls = '{"TaxSch": '+ls_taxsch+',"SupTyp": '+ls_suptyp+',"RegRev": '+ls_regrev+',"EcmGstin": '+ls_ecmgstin+',"IgstOnIntra": '+ls_igstonintra+'}'

ls_docdtls = '{"DocTyp":'+ls_doctyp+',"DocNo": '+ls_docno+',"DocDt": '+ls_docdt+'}'

ls_sellerdtls = '{"SGstin": '+ls_sgstin+',"SLglNm": '+ls_slglnm+',"STrdNm": '+ls_strdnm+',"SAddr1": '+ls_saddr1+',"SAddr2": '+ls_saddr2+',"SLoc": '+ls_sloc+',"SPin": '+ls_spin+',"SStcd": '+ls_sstcd+',"SPh": '+ls_sph+',"SEm": '+ls_sem+'}';

ls_buyerdtls = '{"BGstin": '+ls_bgstin+',"BLglNm": '+ls_blglnm+',"BTrdNm": '+ls_btrdnm+',"BAddr1": '+ls_baddr1+',"BAddr2": '+ls_baddr2+',"BLoc": '+ls_bloc+',"BPin": '+ls_bpin+',"BStcd": '+ls_bstcd+',"BPos": '+ls_bpos+',"BPh": '+ls_bph+',"BEm": '+ls_bem+'}' ;

ls_dispdtls ='{"DisTrdNm": '+ls_distrdnm+',"DisAddr1": '+ls_disaddr1+',"DisAddr2": '+ls_disaddr2+',"DisLoc": '+ls_disloc+',"DisPin": '+ls_dispin+',"DisStcd": '+ls_disstcd+'}';

ls_shipdtls = '{"ShipGstin": '+ls_shipgstin+',"ShipLglNm": '+ls_shiplglnm+',"ShipTrdNm": '+ls_shiptrdnm+',"ShipAddr1": '+ls_shipaddr1+',"ShipAddr2": '+ls_shipaddr2+',"ShipLoc": '+ls_shiploc+',"ShipPin": '+ls_shippin+',"ShipStcd": '+ls_shipstcd+'}';

ls_paydtls = '{"PayNm": '+ls_paynm+',"PayAcctDet": '+ls_payacctdet+',"PayMode": '+ls_paymode+',"PayFinInsBr": '+ls_payfininsbr+',"PayTerm": '+ls_payterm+',"PayInstr": '+ls_payinstr+',"PayCrtrn": '+ls_paycrtrn+',"PayDirDr": '+ls_paydirdr+',"PayCrDay": '+ls_paycrday+',"PayPaidAmt": '+ls_paypaidamt+',"PayPaymtDue": '+ls_paypaymtdue+'}';

ls_docperddtls = '{"InvStDt": '+ls_invstdt+',"InvEndDt": '+ls_invenddt+'}';

ls_predocdtls = '[{"InvNo": '+ls_inv_no+',"InvDt": '+ls_invdt+',"OthRefNo": '+ls_othrefno+'}]';

ls_contrdtls = '[{"RecAdvRefr": '+ls_recadvrefr+',"RecAdvDt": '+ls_recadvdt+',"TendRefr": '+ls_tendrefr+',"ContrRefr": '+ls_contrrefr+',"ExtRefr": '+ls_extrefr+',"ProjRefr": '+ls_projrefr+',"PORefr": '+ls_porefr+',"PORefDt": '+ls_porefdt+'}]';

ls_refdtls = '{"RefInvRm": '+ls_refinvrm+',"DocPerdDtls": '+ls_docperddtls+',"PrecDocDtls": '+ls_predocdtls+',"ContrDtls": '+ls_contrdtls+'}';

ls_addldocdtls = '[{"Url": '+ls_url+',"Docs": '+ls_docs+',"InfoDtls": '+ls_infodtls+'}]';

ls_expdtls = '{"ExpShipBNo": '+ls_expshipbno+',"ExpShipBDt": '+ls_expshipbdt+',"ExpPort": '+ls_expport+',"ExpRefClm": '+ls_exprefclm+',"ExpForCur": '+ls_expforcur+',"ExpCntCode": '+ls_expcntcode+',"ExpDuty": '+ls_expduty+'}';

ls_ewbdtls = '{"TransId": '+ls_transid+',"TransName": '+ls_transname+',"TransMode": '+ls_transmode+',"Distance": '+ls_distance+',"TransDocNo": '+ls_transdocno+',"TransDocDt": '+ls_transdocdt+',"VehNo": '+ls_vehno+',"VehType": '+ls_vehtype+'}';

ls_json_string = '{	"Version": '+ls_version+',"Irn": '+ls_irn+',"TranDtls": '+ls_trandtls+',"DocDtls": '+ls_docdtls+',"SellerDtls": '+ls_sellerdtls+',"BuyerDtls": '+ls_buyerdtls+',"DispDtls": '+ls_dispdtls+',	"ShipDtls": '+ls_shipdtls+',"ItemList": '+ls_itemlist+',"PayDtls": '+ls_paydtls+',	"RefDtls": '+ls_refdtls+',	"AddlDocDtls": '+ls_addldocdtls+',	"ExpDtls": '+ls_expdtls+',"EwbDtls": '+ls_ewbdtls+'}';

//--------------------------------------------------------------------------

//if fileexists("c:\temp\"+"a"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json") = true then
//	filedelete("c:\temp\"+"a"+string(today(),"-ddmmyy_")+string(now(),"hhmmss")+".json")
//end if
//
//ls_file = "c:\temp\"+"a"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json"
//
//li_filenum =  fileopen(ls_file,linemode!,write!,lockreadwrite!,replace!)
//
//ls_rec = ls_json_string
//
//
//filewrite(li_filenum,ls_rec)
//fileclose(li_filenum) 
////
//--------------------------------------------------------------------------

if isnull(ls_json_string) then
	messagebox('Warning','JSON string is null')
	rollback using sqlca;
	return -1
end if

if wf_callapi(ls_json_string,fs_docno) = -1 then
	rollback using sqlca;
	return -1;
end if
end function

public function integer wf_callapi (string fs_json_string, string fs_docno);Integer li_rc, li_StatusCode
String ls_ContentType, ls_body, ls_string, ls_text, ls_json_string, ls_responsestring, ls_rec, ls_place
long li_filenum
HttpClient lnv_HttpClient
lnv_HttpClient = Create HttpClient
////// JSON response parsing
String ls_Error, ls_response, ls_qrcode, ls_irn, ls_response_status, ls_errormessage, ls_ackno, ls_ackdt
LONG ll_errorrecord, ll_errorrecordDET, ll_rootitem
JsonPackage lnv_package
JsonParser lnv_JsonParser 
lnv_package = create JsonPackage
lnv_JsonParser = Create JsonParser
////// QR code
Integer li_temp_qr
String ls_qrdata
Blob lblb_blob
HttpClient lnv_HttpClient_QR
lnv_HttpClient_QR = Create HttpClient

if gs_gstn_stcd = '18' then
	ls_place = 'ASS'
elseif gs_gstn_stcd = '19' then
	ls_place = 'WEB'
elseif gs_gstn_stcd = '16' then
	ls_place = 'TRI'	
end if

// Send request using GET method
//li_rc = lnv_HttpClient.SendRequest("GET", "http://demo.appeon.com/PB/webapi_client/employee/102")

//ls_text = sle_1.text

////////////////////////////////////////////////////////////////////////////////////

//ls_json_string = '{	"Version": "1.1","Irn": null,"TranDtls": {"TaxSch": "GST","SupTyp": "B2B","RegRev": "Y","EcmGstin": null,"IgstOnIntra": "N"	},"DocDtls": {"DocTyp":"INV","DocNo": "789873","DocDt": "14/08/2020"},"SellerDtls": {"SGstin": "29AAACD5108M000","SLglNm": "ABC company pvt ltd","STrdNm": "ABC company pvt ltd",		"SAddr1": "Building Flat no Road Street","SAddr2": "Address 2 of the supplier","SLoc": "GANDHINAGAR","SPin": 560002,"SStcd": "29","SPh": "9898989898","SEm": "abc1235@gmail.com"},	"BuyerDtls": {"BGstin": "29CXGPM0212D1ZW","BLglNm": "XYZ company pvt ltd","BTrdNm": "XYZ company pvt ltd","BAddr1": "NO 1061 3RD CROSS NEAR ST MARYS SCHOOL","BAddr2": "KALYAN NAGAR T DASARAHALLI","BLoc": "BANGALORE","BPin": 560019,"BStcd": "29","BPos": "29","BPh": "9898989898","BEm": "abc1235@gmail.com"},	"DispDtls": {"DisTrdNm": "ABC company pvt ltd","DisAddr1": "7th block, kuvempu layout","DisAddr2": "Address 2 of the supplier","DisLoc": "Bangalore","DisPin": 560043,"DisStcd": "29"},	"ShipDtls": {"ShipGstin": "28AAACG0569P1Z3","ShipLglNm": "CBE company pvt ltd","ShipTrdNm": "CBE company pvt ltd","ShipAddr1": "7th block, kuvempu layout","ShipAddr2": "Address 2 of the supplier","ShipLoc": "Bangalore","ShipPin": 560043,"ShipStcd": "28"},	"ItemList": [{"SlNo": "1","PrdDesc": "FORMULA 1 NUTRITIONAL SHAKE MIX-VANILLA","IsServc": "N","HsnCd": "21069099","Barcde": null,"BchDtls": {"BchNm": null,"BchExpDt": null,"BchWrDt": null},"Qty": 3.68,"FreeQty": 0,"Unit": "UNT","UnitPrice": 7.18,"TotAmt": 26.42,"Discount": 10,"PreTaxVal": 16.42,"AssAmt": 16.42,"GstRt": 18,"IgstAmt": 0,"CgstAmt": 1.47,"SgstAmt": 1.47,"CesRt": 0,"CesAmt": 0,"CesNonAdvlAmt": 0,"StateCesRt": 0,"StateCesAmt": 0,"StateCesNonAdvlAmt": 0,"OthChrg": 0,"TotItemVal": 19.36,"OrdLineRef": "NONE","OrgCntry": null,"PrdSlNo": "1247","AttribDtls": [{"AttNm": null,"AttVal": null}]}],	"PayDtls": {"PayNm": null,"PayAcctDet": null,"PayMode": null,"PayFinInsBr": null,"PayTerm": null,"PayInstr": null,"PayCrtrn": null,"PayDirDr": null,"PayCrDay": 0,"PayPaidAmt": 0,"PayPaymtDue": 0},	"RefDtls": {"RefInvRm": "NOT NEEDED","DocPerdDtls": {"InvStDt": "01/02/2020","InvEndDt": "20/02/2020"},"PrecDocDtls": [{"InvNo": "2672","InvDt": "20/02/2020","OthRefNo": "1114534"}],"ContrDtls": [{"RecAdvRefr": "376237","RecAdvDt": "22/02/2020","TendRefr": "333","ContrRefr": "444","ExtRefr": "563","ProjRefr": "222","PORefr": "111","PORefDt": "20/02/2020"}]},	"AddlDocDtls": [{"Url": "www","Docs": "scuh76bhdw","InfoDtls": "No details"}],	"ExpDtls": {"ExpShipBNo": "123456","ExpShipBDt": "01/03/2020","ExpPort": "123","ExpRefClm": "N","ExpForCur": "007","ExpCntCode": "12","ExpDuty": 123},"EwbDtls": {"TransId": "27AAACB0446L1ZS","TransName": "BLUE DART EXPRESS LIMITED","TransMode": "1","Distance": 110,"TransDocNo": "123","TransDocDt": "12/08/2020","VehNo": "KA01AB1234","VehType": "R"	}}'

////////////////////////////////////////////////////////////////////////////////////

//li_rc = lnv_HttpClient.SendRequest("GET", "http://chart.apis.google.com/chart?cht=qr&chs=230x230&chof=gif&&chl=Hello Google, this is My First Qr Code PB 2019 R2&choe=UTF-8&")
//li_rc = lnv_HttpClient.SendRequest("GET", "http://chart.apis.google.com/chart?cht=qr&chs=230x230&chof=gif&&chl=&ls_text&choe=UTF-8&")
if(gs_gstnno <>'19AACCM2257J1ZB') then
	lnv_HttpClient.SetRequestHeader("Ocp-Apim-Subscription-Key","7774783a863940438ca4cc2d5c1af765");
elseif(gs_gstnno ='19AACCM2257J1ZB') then
	lnv_HttpClient.SetRequestHeader("Ocp-Apim-Subscription-Key","5deffa7f35644b0da49ef6a2ef5a093c");
end if
lnv_HttpClient.SetRequestHeader("Gstin",gs_gstnno);
lnv_HttpClient.SetRequestHeader("sourcetype","ERP");
lnv_HttpClient.SetRequestHeader("referenceno","WEP002017");
lnv_HttpClient.SetRequestHeader("outputtype","JSON");
lnv_HttpClient.SetRequestHeader("Location",ls_place);
lnv_HttpClient.SetRequestHeader("Content-Type","application/json");
lnv_HttpClient.SetRequestHeader("SignedValue","N");

li_rc = lnv_HttpClient.SendRequest("POST", "https://api.wepgst.com/asp/rg/Einvoice/v1.03/GenerateIRN", fs_json_string, EncodingUTF8!)

// Obtain the response message
if li_rc = 1 then
 // Obtain the response status
 li_StatusCode = lnv_HttpClient.GetResponseStatusCode()
 	if li_StatusCode = 200 then
		// Obtain the header
		ls_ContentType = lnv_HttpClient.GetResponseHeader("Content-Type") // Obtain the specifid header
	
		// Obtain the response data
		//lnv_HttpClient.GetResponseBody(ls_string, EncodingUTF8!) // Encoding of the response data is known to be EncodingUTF8!.
		lnv_HttpClient.GetResponseBody(ls_responsestring) // No encoding is specified, because encoding of the response data is unknown


//============================================================================================

//	if fileexists("c:\temp\"+"response"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json") = true then
//		filedelete("c:\temp\"+"response"+string(today(),"-ddmmyy_")+string(now(),"hhmmss")+".json")
//	end if
//
//	ls_file = "c:\temp\"+"response"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json"
//	
//	li_filenum =  fileopen(ls_file,linemode!,write!,lockreadwrite!,replace!)
//	
//	ls_rec = ls_responsestring
//	
//	filewriteex(li_filenum,ls_rec)
//	fileclose(li_filenum) 
	
	
//============================================================================================
		ls_error = lnv_package.LoadString(ls_responsestring)		
		
		
		if Len(ls_error) = 0 then
			ls_response = lnv_package.GetValue("OutputResponse")
			//dw_1.ImportJson(ls_response)
		else
			Messagebox("Error while loading API Response", ls_Error)
			return -1
		end if
		
		ls_Error = lnv_package.LoadString(ls_response)
		
		if Len(ls_Error) = 0 then
			ls_response_status = lnv_package.GetValue("Status")
			if ls_response_status = "0" then				
				ls_error = lnv_JsonParser.LoadString(ls_response)
				if Len(ls_Error) = 0 then
					ll_rootitem = lnv_JsonParser.getRootItem()
					ll_errorrecord = lnv_JsonParser.getItemArray(ll_rootitem,"ErrorRecords")
					if ll_errorrecord = -1 then
						ll_errorrecord = lnv_JsonParser.getItemArray(ll_rootitem,"ErrorDetails")
						if ll_errorrecord = -1 then
							Messagebox("Error occured while getting response array", ls_errormessage)
							return -1
						end if
					end if
					ll_errorrecorddet = lnv_JsonParser.GetChildItem(ll_errorrecord, 1)
					if ll_errorrecord = -1 then
						Messagebox("Error occured while getting child item of array", ls_errormessage)
						return -1
					end if					
					ls_errormessage = lnv_JsonParser.GetItemString(ll_errorrecorddet,"errormessage")
					Messagebox("Warning : E-Invoice Not Generated", ls_errormessage)
					return -1
				else
					Messagebox("Error occured while loading response in parser", ls_Error)
					return -1
				end if
			end if
			ls_ackno = lnv_package.GetValue("AckNo")
			ls_ackdt = lnv_package.GetValue("AckDt")				
			ls_qrcode = lnv_package.GetValue("SignedQRCode")
			ls_irn = lnv_package.GetValue("Irn")
			//messagebox('QR',ls_qrcode)
			//dw_1.ImportJson(ls_response)
		else
			Messagebox("Error while loading Output Reponse", ls_Error)
			return -1
		end if
		/////////////// QR generation
		
		
		////store responce
		insert into fb_Garden_Ho_einvoice(ghe_docno,ghe_garden_snm,ghe_signed_qr,ghe_irn,ghe_ackno,ghe_ackdt,ghe_entry_date,ghe_entry_by,ghe_Remarks)
								values (:fs_docno,:gs_garden_snm,:ls_qrcode,:ls_irn,:ls_ackno,to_date(:ls_ackdt,'yyyy-mm-dd hh24:mi:ss') ,sysdate,:GS_USER,'SAVED');
		if sqlca.sqlcode = -1 then
			messagebox('Warning','Error occured while inserting IRN and QR Code in Dummy table'+sqlca.sqlerrtext)			
		end if			
		////
		
		//li_rc = lnv_HttpClient.SendRequest("GET", "http://chart.apis.google.com/chart?cht=qr&chs=230x230&chof=gif&&chl="+ls_qrcode+"&choe=UTF-8&")//stopped from 03042024 By Piyush
		li_rc = lnv_HttpClient.SendRequest("GET", "https://luxmitea.com/PTUAPI/api/QrCodeConverter?sQrcode="+ls_qrcode+"&sDocno="+fs_docno+"&sGardenShorName="+gs_garden_snm+"")//Live
		
		// Obtain the response message
		if li_rc = 1 then
			// Obtain the response status
			li_StatusCode = lnv_HttpClient.GetResponseStatusCode()
			if li_StatusCode = 200 then
				// Obtain the header
				ls_ContentType = lnv_HttpClient.GetResponseHeader("Content-Type") // Obtain the specifid header
		
				// Obtain the response data
		
				lnv_HttpClient.GetResponseBody(lblb_blob) // Obtain the response data and convert to a blob
				update fb_einvoice set qr_code = :lblb_blob, irn = :ls_irn, ackno = :ls_ackno, ackdt =  to_date(:ls_ackdt,'yyyy-mm-dd hh24:mi:ss')  where docno = :fs_docno;
				if sqlca.sqlcode = -1 then
					messagebox('Error','Error occured while upting IRN and QR Code'+sqlca.sqlerrtext)
					rollback using sqlca;
					return 1;
				end if
				commit using sqlca;
				messagebox('Message','E-Invoice has been successfully generate for Tax-Invoice No. : '+fs_docno)
				dw_1.retrieve();
				return 1
			end if
		elseif li_rc = -1 then
			messagebox('Error','Error occured while API Posting : General Error')
			return -1
		elseif li_rc = -2 then
			messagebox('Error','Error occured while API Posting : Invalid URL')
			return -1
		elseif li_rc = -3 then
			messagebox('Error','Error occured while API Posting : Cannot connect to the Internet')
			return -1
		elseif li_rc = -4 then
			messagebox('Error','Error occured while API Posting : Timed out')
			return -1
		elseif li_rc = -5 then
			messagebox('Error','Error occured while API Posting : Code conversion failed')
			return -1
		elseif li_rc = -6 then
			messagebox('Error','Error occured while API Posting : Unsupported character sets')
			return -1		
		else 
			messagebox('Error','Error occured while API Posting : Unknown Error')
			return -1
		end if							
		
		/////////////// QR closing
	else
		messagebox('Error','Unsuccessful Response')
		return -1
	end if
elseif li_rc = -1 then
	messagebox('Error','Error occured while API Posting : General Error')
	return -1
elseif li_rc = -2 then
	messagebox('Error','Error occured while API Posting : Invalid URL')
	return -1
elseif li_rc = -3 then
	messagebox('Error','Error occured while API Posting : Cannot connect to the Internet')
	return -1
elseif li_rc = -4 then
	messagebox('Error','Error occured while API Posting : Timed out')
	return -1
elseif li_rc = -5 then
	messagebox('Error','Error occured while API Posting : Code conversion failed')
	return -1
elseif li_rc = -6 then
	messagebox('Error','Error occured while API Posting : Unsupported character sets')
	return -1
else 
	messagebox('Error','Error occured while API Posting : Unknown Error')
	return -1
end if




//  messagebox('Warning',ls_responsestring)// Obtain the response data and convert to a blob
//  
//	if fileexists("c:\temp\"+"response"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json") = true then
//		filedelete("c:\temp\"+"response"+string(today(),"-ddmmyy_")+string(now(),"hhmmss")+".json")
//	end if
//
//	ls_file = "c:\temp\"+"response"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json"
//	
//	li_filenum =  fileopen(ls_file,linemode!,write!,lockreadwrite!,replace!)
//	
//	ls_rec = ls_responsestring
//	
//	filewrite(li_filenum,ls_rec)
//	fileclose(li_filenum) 
		  

end function

public function long wf_gen_csv ();string ls_serial, ls_location, ls_suptyp, ls_regrev, ls_ecmgstin, ls_igstonintra, ls_doctyp, ls_docno, ls_docdt, ls_sgstin, ls_slglnm, ls_strdnm, ls_saddr1, ls_saddr2, ls_sloc, ls_spin, ls_sstcd, ls_sph, ls_sem
string ls_bgstin, ls_blglnm, ls_btrdnm, ls_baddr1, ls_baddr2, ls_bloc, ls_bpin, ls_bstcd, ls_bpos, ls_bph, ls_bem, ls_distrdnm, ls_disaddr1, ls_disaddr2, ls_disloc, ls_dispin, ls_disstcd, ls_shipgstin, ls_shiplglnm, ls_shiptrdnm
string ls_shipaddr1, ls_shipaddr2, ls_shiploc, ls_shippin, ls_shipstcd, ls_paynm, ls_payacctdet, ls_paymode, ls_payfininsbr, ls_payterm, ls_payinstr, ls_paycrtrn, ls_paydirdr, ls_paycrday, ls_paypaidamt, ls_paypaymtdue
string ls_refinvrm, ls_invstdt, ls_invenddt, ls_inv_no, ls_invdt, ls_othrefno, ls_recadvrefr, ls_recadvdt, ls_tendrefr, ls_contrrefr, ls_extrefr, ls_projrefr, ls_porefr, ls_porefdt, ls_url, ls_docs, ls_infodtls, ls_expshipbno
string ls_expshipbdt, ls_expport, ls_exprefclm, ls_expforcur, ls_expcntcode, ls_expduty, ls_transid, ls_transname, ls_transmode, ls_distance, ls_transdocno, ls_transdocdt, ls_vehno, ls_vehtype

string ls_slno, ls_prddesc, ls_isservc, ls_hsncd, ls_barcde, ls_bchnm, ls_bchexpdt, ls_bchwrdt, ls_qty, ls_freeqty, ls_uom, ls_unitprice, ls_totamt, ls_discount, ls_pretaxval, ls_assamt, ls_gstrt, ls_igstamt, ls_cgstamt, ls_sgstamt
string ls_cesrt, ls_cesamt, ls_cesnonadvlamt, ls_statecesrt, ls_statecesamt, ls_statecesnonadvlamt, ls_othchrg, ls_totitemval, ls_ordlineref, ls_orgcntry, ls_prdslno, ls_attnm, ls_attval

string ls_trandtls, ls_docdtls, ls_sellerdtls, ls_buyerdtls, ls_dispdtls, ls_shipdtls, ls_itemlist, ls_bchdtls, ls_attribdtls, ls_paydtls, ls_refdtls, ls_docperddtls, ls_predocdtls, ls_contrdtls, ls_addldocdtls, ls_expdtls, ls_ewbdtls

string ls_rec
long li_filenum, li_ctr
li_ctr = 0
setpointer(hourglass!) 
//
If not DirectoryExists ("c:\einv_upload") Then
	CreateDirectory ("c:\einv_upload")
End If


if fileexists("c:\einv_upload\"+"einv_"+string(today(),"dd.mm.yyyy")+" "+string(now(),"hhmmss")+".csv") = true then
	filedelete("c:\einv_upload\"+"einv_"+string(today(),"dd.mm.yyyy")+" "+string(now(),"hhmmss")+".csv")
end if

li_filenum =  fileopen("c:\einv_upload\"+"einv_"+string(today(),"dd.mm.yyyy")+" "+string(now(),"hhmmss")+".csv",linemode!,write!,lockreadwrite!,replace!)

ls_file = "c:\einv_upload\"+"einv_"+string(today(),"dd.mm.yyyy")+" "+string(now(),"hhmmss")+".csv"

ls_rec = "Slno,Location,Supply Type,RegrRev,Ecom Gstin,Igst on Intra,Doc Type,Doc No,Doc Date,Seller Details,Seller Gstin,Seller Legal Name,Seller Trade Name,Seller Address1,Seller Address2,Seller Location,Seller Pincode,Seller Statecode,Seller Phone num,Seller Email,Buyer Details,Buyer Gstin,Buyer Legal Name,Buyer Trade Name,Buyer Address1,Buyer Address2,Buyer Location,Buyer Pincode,Buyer State Name,Buyer Place of supply,Buyer Phone number,Buyer Email,Dispatch Details,Dispatch Legal Name,Dispatch Address1,Dispatch Address2,Dispatch Location,Dispatch Pincode,Dispatch Statecode,Shipping Details,Ship to Gstin,Shipping Legal name,Shipping Trade Name,Shipping Address1,Shipping Address2,Shipping Location,Shipping Pincode,Shipping Statecode,Item List,Item List Slno,Product Description,Is Service,Hsn Code,Barcode,Batch Details,Batch Name,Batch Expiry Date,Batch Warranty Date,Qty,Freeqty,Unit,Unit Price,SellingTotal Amount,Discount,Pre Taxble Val,Assesble Value (Total Amount- Discount),Gst Rate,Igst Amount,Cgst Amount,Sgst Amount,Cess Rate,Cess Amount,Cess Non AdVal Amount,State cess Rate,State cess Val,State cess Non Adval Amount,Other Charges,Total Item Val,Order Line Refrence No,Origin Country,Product Serial Number,Attribute Details,Attribute Name of Item,Attribute Value of the Item,Payment Details,PayeeName,Payee Account Details,Mode Of Payment,Ifsc Code,Terms Of Payment,Payment Instruction,Credit Transfer,Direct Debit,Credit Days,sum of amount which have been paid in advance,Balance Amount to be Paid,Reference Details,Invoice Remarks,Doc Period Details,Invoice Period Start date,Invoice Period End date,Preceeding Invoice Number,Preceeding Invoice Date,Other Reference,Contract Details,Receipt Advice Number,Date of Receipt Advice Number,Tender Ref Number,Contract Ref Number,External Reference Number,Project Ref No,Purchase Order Ref No,Purchase Order Ref Date,Additional Doc Details,Supporting document URL,Supporting document in Base64 Format,Any additional information,Export Details,Shipping Bill No,Shipping Bill date,Port Code,Options for supplier for refund,Foreign Currency,Country code,ExpDuty,Eway bill Details,Transporter Gstin,Transporter Name,TransMode,Distance,Tranport Document Number,Transport Document Date,Vehicle Number,Vehicle Type"

filewrite(li_filenum,ls_rec)

setnull(ls_rec)

//	
DECLARE c1 CURSOR FOR
select to_char(rownum) "Slno", null "Location", SUPTYP "Supply Type", REGREV "RegrRev", ECMGSTIN "Ecom Gstin", IGSTONINTRA "Igst on Intra", DOCTYP "Doc Type", DOCNO "Doc No",
       to_char(DOCDT,'dd-mm-yyyy') "Doc Date", null "Seller Details", SGSTIN "Seller Gstin", initcap(replace(SLGLNM,',',' ')) "Seller Legal Name", replace(STRDNM,',',' ') "Seller Trade Name", replace(SADDR1,',',' ') "Seller Address1", 
       replace(SADDR2,',',' ') "Seller Address2", replace(SLOC,',',' ') "Seller Location", to_char(SPIN) "Seller Pincode", replace(SSTCD,',',' ') "Seller Statecode", replace(SPH,',',' ') "Seller Phone num", replace(SEM,',',' ') "Seller Email", null "Buyer Details",
       BGSTIN "Buyer Gstin", initcap(replace(BLGLNM,',',' ')) "Buyer Legal Name", replace(BTRDNM,',',' ') "Buyer Trade Name", replace(BADDR1,',',' ') "Buyer Address1", replace(BADDR2,',',' ') "Buyer Address2", replace(BLOC,',',' ') "Buyer Location", 
       to_char(BPIN) "Buyer Pincode", replace(BSTCD,',',' ') "Buyer State Name", replace(BPOS,',',' ') "Buyer Place of supply", replace(BPH,',',' ') "Buyer Phone number", replace(BEM,',',' ') "Buyer Email", null "Dispatch Details",
       replace(DISTRDNM,',',' ') "Dispatch Legal Name", replace(DISADDR1,',',' ') "Dispatch Address1", replace(DISADDR2,',',' ') "Dispatch Address2", replace(DISLOC,',',' ') "Dispatch Location", to_char(DISPIN) "Dispatch Pincode", replace(DISSTCD,',',' ') "Dispatch Statecode",
       null "Shipping Details", SHIPGSTIN "Ship to Gstin", replace(SHIPLGLNM,',',' ') "Shipping Legal name", replace(SHIPTRDNM,',',' ') "Shipping Trade Name", replace(SHIPADDR1,',',' ') "Shipping Address1", replace(SHIPADDR2,',',' ') "Shipping Address2", 
       replace(SHIPLOC,',',' ') "Shipping Location", to_char(SHIPPIN) "Shipping Pincode", replace(SHIPSTCD,',',' ') "Shipping Statecode", null "Item List", SLNO "Item List Slno", replace(PRDDESC,',',' ') "Product Description", 
       ISSERVC "Is Service", replace(HSNCD,',',' ') "Hsn Code", BARCDE "Barcode", null "Batch Details", BCHNM "Batch Name", to_char(BCHEXPDT,'dd-mm-yyyy') "Batch Expiry Date", to_char(BCHWRDT,'dd-mm-yyyy') "Batch Warranty Date", to_char(nvl(QTY,0)) "Qty",
       to_char(nvl(FREEQTY,0)) "Freeqty", replace(UNIT,',',' ') "Unit", to_char(nvl(UNITPRICE,0)) "Unit Price", to_char(nvl(TOTAMT,0)) "SellingTotal Amount", to_char(nvl(DISCOUNT,0)) "Discount", to_char(nvl(PRETAXVAL,0)) "Pre Taxble Val", to_char(nvl(ASSAMT,0)) "Assesble Value",
       to_char(nvl(GSTRT,0)) "Gst Rate", to_char(nvl(IGSTAMT,0)) "Igst Amount", to_char(nvl(CGSTAMT,0)) "Cgst Amount", to_char(nvl(SGSTAMT,0)) "Sgst Amount", to_char(nvl(CESRT,0)) "Cess Rate", to_char(nvl(CESAMT,0)) "Cess Amount", to_char(nvl(CESNONADVLAMT,0)) "Cess Non AdVal Amount",  
       to_char(nvl(STATECESRT,0)) "State cess Rate", to_char(nvl(STATECESAMT,0)) "State cess Val", to_char(nvl(STATECESNONADVLAMT,0)) "State cess Non Adval Amount", to_char(nvl(OTHCHRG,0)) "Other Charges", to_char(nvl(TOTITEMVAL,0)) "Total Item Val", 
       ORDLINEREF "Order Line Refrence No", ORGCNTRY "Origin Country", replace(PRDSLNO,',',' ') "Product Serial Number", null "Attribute Details", ATTNM "Attribute Name of Item", ATTVAL "Attribute Value of the Item",        
       null "Payment Details", PAYNM "PayeeName", PAYACCTDET "Payee Account Details", PAYMODE "Mode Of Payment", PAYFININSBR "Ifsc Code", PAYTERM "Terms Of Payment", 
       PAYINSTR "Payment Instruction", PAYCRTRN "Credit Transfer", PAYDIRDR "Direct Debit", to_char(NVL(PAYCRDAY,0)) "Credit Days", to_char(NVL(PAYPAIDAMT,0)) "paid in advance", 
       to_char(NVL(PAYPAYMTDUE,0)) "Balance Amount to be Paid", null "Reference Details", NVL(REFINVRM,'NOT NEEDED') "Invoice Remarks", null "Doc Period Details", to_char(INVSTDT,'dd-mm-yyyy') "Invoice Period Start date",
       to_char(INVENDDT,'dd-mm-yyyy') "Invoice Period End date", INVNO "Preceeding Invoice Number", to_char(INVDT,'dd-mm-yyyy') "Preceeding Invoice Date", OTHREFNO "Other Reference", null "Contract Details", 
       RECADVREFR "Receipt Advice Number", to_char(RECADVDT,'dd-mm-yyyy') "Date of Receipt Advice Number", TENDREFR "Tender Ref Number", CONTRREFR "Contract Ref Number", EXTREFR "External Reference Number",
       PROJREFR "Project Ref No", POREFR "Purchase Order Ref No", to_char(POREFDT,'dd-mm-yyyy') "Purchase Order Ref Date", null "Additional Doc Details", URL "Supporting document URL",
       DOCS "Supporting document", INFODTLS "Any additional information", null "Export Details", EXPSHIPBNO "Shipping Bill No", to_char(EXPSHIPBDT,'dd-mm-yyyy') "Shipping Bill date", 
       EXPPORT "Port Code", EXPREFCLM "Options for refund", EXPFORCUR "Foreign Currency", EXPCNTCODE "Country code", to_char(nvl(EXPDUTY,0)) "ExpDuty", null "Eway bill Details",
       TRANSID "Transporter Gstin", null "Transporter Name", TRANSMODE "TransMode", to_char(nvl(DISTANCE,0)) "Distance", TRANSDOCNO "Tranport Document Number", to_char(TRANSDOCDT,'dd-mm-yyyy') "Transport Document Date",
       VEHNO "Vehicle Number", VEHTYPE "Vehicle Type"
from fb_einvoice
where nvl(IRN,'x') = 'x' AND NVL(xls_gen,'N') = 'N' ;
	 
 open c1;
	
	if sqlca.sqlcode = 0 then
		
		setnull(ls_serial); setnull(ls_location); setnull(ls_suptyp); setnull(ls_regrev); setnull(ls_ecmgstin); setnull(ls_igstonintra); setnull(ls_doctyp); 
		setnull(ls_docno); setnull(ls_docdt); setnull(ls_sellerdtls); setnull(ls_sgstin); setnull(ls_slglnm); setnull(ls_strdnm); setnull(ls_saddr1); setnull(ls_saddr2); setnull(ls_sloc);
		setnull(ls_spin); setnull(ls_sstcd); setnull(ls_sph); setnull(ls_sem); setnull(ls_buyerdtls); setnull(ls_bgstin); setnull(ls_blglnm); setnull(ls_btrdnm); setnull(ls_baddr1); setnull(ls_baddr2); setnull(ls_bloc); setnull(ls_bpin); setnull(ls_bstcd); setnull(ls_bpos); 
		setnull(ls_bph); setnull(ls_bem); setnull(ls_dispdtls); setnull(ls_distrdnm); setnull(ls_disaddr1); setnull(ls_disaddr2); setnull(ls_disloc); setnull(ls_dispin); setnull(ls_disstcd); setnull(ls_shipdtls); setnull(ls_shipgstin); setnull(ls_shiplglnm); setnull(ls_shiptrdnm); setnull(ls_shipaddr1); 
		setnull(ls_shipaddr2); setnull(ls_shiploc); setnull(ls_shippin); setnull(ls_shipstcd); setnull(ls_itemlist); setnull(ls_slno); setnull(ls_prddesc); setnull(ls_isservc); setnull(ls_hsncd); setnull(ls_barcde); setnull(ls_bchdtls); setnull(ls_bchnm); setnull(ls_bchexpdt); setnull(ls_bchwrdt); 
		setnull(ls_qty); setnull(ls_freeqty); setnull(ls_uom); setnull(ls_unitprice); setnull(ls_totamt); setnull(ls_discount); setnull(ls_pretaxval); setnull(ls_assamt); setnull(ls_gstrt); setnull(ls_igstamt); setnull(ls_cgstamt); setnull(ls_sgstamt); setnull(ls_cesrt); setnull(ls_cesamt); 
		setnull(ls_cesnonadvlamt); setnull(ls_statecesrt); setnull(ls_statecesamt); setnull(ls_statecesnonadvlamt); setnull(ls_othchrg); setnull(ls_totitemval); setnull(ls_ordlineref); setnull(ls_orgcntry); setnull(ls_prdslno); setnull(ls_attribdtls); setnull(ls_attnm); setnull(ls_attval); setnull(ls_paydtls); setnull(ls_paynm); 
		setnull(ls_payacctdet); setnull(ls_paymode); setnull(ls_payfininsbr); setnull(ls_payterm); setnull(ls_payinstr); setnull(ls_paycrtrn); setnull(ls_paydirdr); setnull(ls_paycrday); setnull(ls_paypaidamt); setnull(ls_paypaymtdue); setnull(ls_refdtls); setnull(ls_refinvrm); setnull(ls_docperddtls); setnull(ls_invstdt); 
		setnull(ls_invenddt); setnull(ls_inv_no); setnull(ls_invdt); setnull(ls_othrefno); setnull(ls_contrdtls); setnull(ls_recadvrefr); setnull(ls_recadvdt); setnull(ls_tendrefr); setnull(ls_contrrefr); setnull(ls_extrefr); setnull(ls_projrefr); setnull(ls_porefr); setnull(ls_porefdt); setnull(ls_addldocdtls); 
		setnull(ls_url); setnull(ls_docs); setnull(ls_infodtls); setnull(ls_expdtls); setnull(ls_expshipbno); setnull(ls_expshipbdt); setnull(ls_expport); setnull(ls_exprefclm); setnull(ls_expforcur); setnull(ls_expcntcode); setnull(ls_expduty); setnull(ls_ewbdtls); setnull(ls_transid); setnull(ls_transname); setnull(ls_transmode);
		setnull(ls_distance); setnull(ls_transdocno); setnull(ls_transdocdt); setnull(ls_vehno);  setnull(ls_vehtype); 	
		
		fetch c1 into :ls_serial, :ls_location, :ls_suptyp, :ls_regrev, :ls_ecmgstin, :ls_igstonintra, :ls_doctyp, :ls_docno, :ls_docdt, :ls_sellerdtls, :ls_sgstin, :ls_slglnm, :ls_strdnm, :ls_saddr1, :ls_saddr2, :ls_sloc,
			:ls_spin, :ls_sstcd, :ls_sph, :ls_sem, :ls_buyerdtls, :ls_bgstin, :ls_blglnm, :ls_btrdnm, :ls_baddr1, :ls_baddr2, :ls_bloc, :ls_bpin, :ls_bstcd, :ls_bpos, 
			:ls_bph, :ls_bem, :ls_dispdtls, :ls_distrdnm, :ls_disaddr1, :ls_disaddr2, :ls_disloc, :ls_dispin, :ls_disstcd, :ls_shipdtls, :ls_shipgstin, :ls_shiplglnm, :ls_shiptrdnm, :ls_shipaddr1, 
			:ls_shipaddr2, :ls_shiploc, :ls_shippin, :ls_shipstcd, :ls_itemlist, :ls_slno, :ls_prddesc, :ls_isservc, :ls_hsncd, :ls_barcde, :ls_bchdtls, :ls_bchnm, :ls_bchexpdt, :ls_bchwrdt, 
			:ls_qty, :ls_freeqty, :ls_uom, :ls_unitprice, :ls_totamt, :ls_discount, :ls_pretaxval, :ls_assamt, :ls_gstrt, :ls_igstamt, :ls_cgstamt, :ls_sgstamt, :ls_cesrt, :ls_cesamt, 
			:ls_cesnonadvlamt, :ls_statecesrt, :ls_statecesamt, :ls_statecesnonadvlamt, :ls_othchrg, :ls_totitemval, :ls_ordlineref, :ls_orgcntry, :ls_prdslno, :ls_attribdtls, :ls_attnm, :ls_attval, :ls_paydtls, :ls_paynm, 
			:ls_payacctdet, :ls_paymode, :ls_payfininsbr, :ls_payterm, :ls_payinstr, :ls_paycrtrn, :ls_paydirdr, :ls_paycrday, :ls_paypaidamt, :ls_paypaymtdue, :ls_refdtls, :ls_refinvrm, :ls_docperddtls, :ls_invstdt, 
			:ls_invenddt, :ls_inv_no, :ls_invdt, :ls_othrefno, :ls_contrdtls, :ls_recadvrefr, :ls_recadvdt, :ls_tendrefr, :ls_contrrefr, :ls_extrefr, :ls_projrefr, :ls_porefr, :ls_porefdt, :ls_addldocdtls, 
			:ls_url, :ls_docs, :ls_infodtls, :ls_expdtls, :ls_expshipbno, :ls_expshipbdt, :ls_expport, :ls_exprefclm, :ls_expforcur, :ls_expcntcode, :ls_expduty, :ls_ewbdtls, :ls_transid, :ls_transname, :ls_transmode,
			:ls_distance, :ls_transdocno, :ls_transdocdt, :ls_vehno,  :ls_vehtype;
		do while sqlca.sqlcode <> 100
//			
//			
			if isnull(ls_serial) then ls_serial = ''; 
			
			if isnull(ls_location) then ls_location = ''; 
			
			if isnull(ls_suptyp) then ls_suptyp = ''; 
			
			if isnull(ls_regrev) then ls_regrev = '';
			
			if isnull(ls_ecmgstin) then ls_ecmgstin = '';
			
			if isnull(ls_igstonintra) then ls_igstonintra = '';
			
			if isnull(ls_doctyp) then ls_doctyp = '';
			
			if isnull(ls_docno) then ls_docno = '';
			
			if isnull(ls_docdt) then ls_docdt = '';
			
			if isnull(ls_sellerdtls) then ls_sellerdtls = '';
			
			if isnull(ls_sgstin) then ls_sgstin = '';
			
			if isnull(ls_slglnm) then ls_slglnm = '';
			
			if isnull(ls_strdnm) then ls_strdnm = '';
			
			if isnull(ls_saddr1) then ls_saddr1 = '';
			
			if isnull(ls_saddr2) then ls_saddr2 = '';
			
			if isnull(ls_sloc) then ls_sloc = '';
			
			if isnull(ls_spin) then ls_spin = '';
			
			if isnull(ls_sstcd) then ls_sstcd = '';
			
			if isnull(ls_sph) then ls_sph = '';
			
			if isnull(ls_sem) then ls_sem = '';
			
			if isnull(ls_buyerdtls) then ls_buyerdtls = '';
			
			if isnull(ls_bgstin) then ls_bgstin = '';
			
			if isnull(ls_blglnm) then ls_blglnm = '';
			
			if isnull(ls_btrdnm) then ls_btrdnm = '';
			
			if isnull(ls_baddr1) then ls_baddr1 = '';
			
			if isnull(ls_baddr2) then ls_baddr2 = '';
			
			if isnull(ls_bloc) then ls_bloc = '';
			
			if isnull(ls_bpin) then ls_bpin = '';
			
			if isnull(ls_bstcd) then ls_bstcd = '';
			
			if isnull(ls_bpos) then ls_bpos = '';
			
			if isnull(ls_bph) then ls_bph = '';
			
			if isnull(ls_bem) then ls_bem = '';
			
			if isnull(ls_dispdtls) then ls_dispdtls = '';
			
			if isnull(ls_distrdnm) then ls_distrdnm = '';
			
			if isnull(ls_disaddr1) then ls_disaddr1 = '';
			
			if isnull(ls_disaddr2) then ls_disaddr2 = '';
			
			if isnull(ls_disloc) then ls_disloc = '';
			
			if isnull(ls_dispin) then ls_dispin = '';
			
			if isnull(ls_disstcd) then ls_disstcd = '';
			
			if isnull(ls_shipdtls) then ls_shipdtls = '';
			
			if isnull(ls_shipgstin) then ls_shipgstin = '';
			
			if isnull(ls_shiplglnm) then ls_shiplglnm = '';
			
			if isnull(ls_shiptrdnm) then ls_shiptrdnm = '';
			
			if isnull(ls_shipaddr1) then ls_shipaddr1 = '';
			
			if isnull(ls_shipaddr2) then ls_shipaddr2 = '';
			
			if isnull(ls_shiploc) then ls_shiploc = '';
			
			if isnull(ls_shippin) then ls_shippin = '';
			
			if isnull(ls_shipstcd) then ls_shipstcd = '';
			
			if isnull(ls_itemlist) then ls_itemlist = '';
			
			if isnull(ls_slno) then	ls_slno = '';
			
			if isnull(ls_prddesc) then ls_prddesc = '';
			
			if isnull(ls_isservc) then ls_isservc = '';
			
			if isnull(ls_hsncd) then ls_hsncd = '';
			
			if isnull(ls_barcde) then ls_barcde = '';
			
			if isnull(ls_bchdtls) then ls_bchdtls = '';
			
			if isnull(ls_bchnm) then ls_bchnm = '';
			
			if isnull(ls_bchexpdt) then ls_bchexpdt = '';
			
			if isnull(ls_bchwrdt) then ls_bchwrdt = '';
			
			if isnull(ls_qty) then ls_qty = '0';
			
			if isnull(ls_freeqty) then ls_freeqty = '0';
				
			if isnull(ls_uom) then ls_uom = '';
			
			if isnull(ls_unitprice) then ls_unitprice = '0';
			
			if isnull(ls_totamt) then ls_totamt = '0';
			
			if isnull(ls_discount) then ls_discount = '0';
			
			if isnull(ls_pretaxval) then ls_pretaxval = '0';
			
			if isnull(ls_assamt) then ls_assamt = '0';
			
			if isnull(ls_gstrt) then ls_gstrt = '0';
			
			if isnull(ls_igstamt) then ls_igstamt = '0';
			
			if isnull(ls_cgstamt) then ls_cgstamt = '0';
			
			if isnull(ls_sgstamt) then ls_sgstamt = '0';
			
			if isnull(ls_cesrt) then ls_cesrt = '0';
			
			if isnull(ls_cesamt) then ls_cesamt = '0';
			
			if isnull(ls_cesnonadvlamt) then ls_cesnonadvlamt = '0';
			
			if isnull(ls_statecesrt) then ls_statecesrt = '0';
			
			if isnull(ls_statecesamt) then ls_statecesamt = '0';
			
			if isnull(ls_statecesnonadvlamt) then ls_statecesnonadvlamt = '0';
			
			if isnull(ls_othchrg) then ls_othchrg = '0';
			
			if isnull(ls_totitemval) then ls_totitemval = '0';
			
			if isnull(ls_ordlineref) then ls_ordlineref = '';
			
			if isnull(ls_orgcntry) then ls_orgcntry = '';
			
			if isnull(ls_prdslno) then ls_prdslno = '';
			
			if isnull(ls_attribdtls) then ls_attribdtls = '';
			
			if isnull(ls_attnm) then ls_attnm = '';
			
			if isnull(ls_attval) then ls_attval = '';
			
			if isnull(ls_paydtls) then ls_paydtls = '';
			
			if isnull(ls_paynm) then ls_paynm = '';
			
			if isnull(ls_payacctdet) then ls_payacctdet = '';
			
			if isnull(ls_paymode) then ls_paymode = '';
			
			if isnull(ls_payfininsbr) then ls_payfininsbr = '';
			
			if isnull(ls_payterm) then ls_payterm = '';
			
			if isnull(ls_payinstr) then ls_payinstr = '';
			
			if isnull(ls_paycrtrn) then ls_paycrtrn = '';
			
			if isnull(ls_paydirdr) then ls_paydirdr = '';
			
			if isnull(ls_paycrday) then ls_paycrday = '0';
			
			if isnull(ls_paypaidamt) then ls_paypaidamt = '0';
			
			if isnull(ls_paypaymtdue) then ls_paypaymtdue = '0';
			
			if isnull(ls_refdtls) then ls_refdtls = '0';
			
			if isnull(ls_refinvrm) then ls_refinvrm = '';
			
			if isnull(ls_docperddtls) then ls_docperddtls = '';
			
			if isnull(ls_invstdt) then ls_invstdt = '';
			
			if isnull(ls_invenddt) then ls_invenddt = '';
			
			if isnull(ls_inv_no) then ls_inv_no = '';
			
			if isnull(ls_invdt) then ls_invdt = '';
			
			if isnull(ls_othrefno) then ls_othrefno = ''; 
			
			if isnull(ls_contrdtls) then ls_contrdtls = '';
			
			if isnull(ls_recadvrefr) then ls_recadvrefr = '';
			
			if isnull(ls_recadvdt) then ls_recadvdt = '';
			
			if isnull(ls_tendrefr) then ls_tendrefr = '';
			
			if isnull(ls_contrrefr) then ls_contrrefr = '';
			
			if isnull(ls_extrefr) then ls_extrefr = '';
			
			if isnull(ls_projrefr) then ls_projrefr = '';
			
			if isnull(ls_porefr) then ls_porefr = '';
			
			if isnull(ls_porefdt) then ls_porefdt = '';
			
			if isnull(ls_addldocdtls) then ls_addldocdtls = '';
			
			if isnull(ls_url) then ls_url = '';
			
			if isnull(ls_docs) then ls_docs = '';
			
			if isnull(ls_infodtls) then ls_infodtls = '';  
			
			if isnull(ls_expdtls) then ls_expdtls = ''; 
			
			if isnull(ls_expshipbno) then ls_expshipbno = '';
			
			if isnull(ls_expshipbdt) then ls_expshipbdt = '';
			
			if isnull(ls_expport) then ls_expport = '';
			
			if isnull(ls_exprefclm) then ls_exprefclm = '';
			
			if isnull(ls_expforcur) then ls_expforcur = '';
			
			if isnull(ls_expcntcode) then ls_expcntcode = '';
			
			if isnull(ls_expduty) then ls_expduty = '0';
			
			if isnull(ls_ewbdtls) then ls_ewbdtls = '';
			
			if isnull(ls_transid) then ls_transid = '';
			
			if isnull(ls_transname) then ls_transname = '';
			
			if isnull(ls_transmode) then ls_transmode = '';
			
			if isnull(ls_distance) then ls_distance = '0';
			
			if isnull(ls_transdocno) then ls_transdocno = '';
			
			if isnull(ls_transdocdt) then ls_transdocdt = '';
			
			if isnull(ls_vehno) then ls_vehno = '';
			
			if isnull(ls_vehtype) then ls_vehtype = '';

//
//			
			ls_rec = ls_serial+','+ls_location+','+ls_suptyp+','+ls_regrev+','+ls_ecmgstin+','+ls_igstonintra+','+ls_doctyp+','+ls_docno+','+ls_docdt+','+ls_sellerdtls+','+ls_sgstin+','+ls_slglnm+','+ls_strdnm+','+ls_saddr1+','+ls_saddr2+','+ls_sloc+','
			ls_rec = ls_rec + ls_spin+','+ls_sstcd+','+ls_sph+','+ls_sem+','+ls_buyerdtls+','+ls_bgstin+','+ls_blglnm+','+ls_btrdnm+','+ls_baddr1+','+ls_baddr2+','+ls_bloc+','+ls_bpin+','+ls_bstcd+','+ls_bpos+','
			ls_rec = ls_rec + ls_bph+','+ls_bem+','+ls_dispdtls+','+ls_distrdnm+','+ls_disaddr1+','+ls_disaddr2+','+ls_disloc+','+ls_dispin+','+ls_disstcd+','+ls_shipdtls+','+ls_shipgstin+','+ls_shiplglnm+','+ls_shiptrdnm+','+ls_shipaddr1+','
			ls_rec = ls_rec + ls_shipaddr2+','+ls_shiploc+','+ls_shippin+','+ls_shipstcd+','+ls_itemlist+','+ls_slno+','+ls_prddesc+','+ls_isservc+','+ls_hsncd+','+ls_barcde+','+ls_bchdtls+','+ls_bchnm+','+ls_bchexpdt+','+ls_bchwrdt+','
			ls_rec = ls_rec + ls_qty+','+ls_freeqty+','+ls_uom+','+ls_unitprice+','+ls_totamt+','+ls_discount+','+ls_pretaxval+','+ls_assamt+','+ls_gstrt+','+ls_igstamt+','+ls_cgstamt+','+ls_sgstamt+','+ls_cesrt+','+ls_cesamt+','
			ls_rec = ls_rec + ls_cesnonadvlamt+','+ls_statecesrt+','+ls_statecesamt+','+ls_statecesnonadvlamt+','+ls_othchrg+','+ls_totitemval+','+ls_ordlineref+','+ls_orgcntry+','+ls_prdslno+','+ls_attribdtls+','+ls_attnm+','+ls_attval+','+ls_paydtls+','+ls_paynm+','
			ls_rec = ls_rec + ls_payacctdet+','+ls_paymode+','+ls_payfininsbr+','+ls_payterm+','+ls_payinstr+','+ls_paycrtrn+','+ls_paydirdr+','+ls_paycrday+','+ls_paypaidamt+','+ls_paypaymtdue+','+ls_refdtls+','+ls_refinvrm+','+ls_docperddtls+','+ls_invstdt+','
			ls_rec = ls_rec + ls_invenddt+','+ls_inv_no+','+ls_invdt+','+ls_othrefno+','+ls_contrdtls+','+ls_recadvrefr+','+ls_recadvdt+','+ls_tendrefr+','+ls_contrrefr+','+ls_extrefr+','+ls_projrefr+','+ls_porefr+','+ls_porefdt+','+ls_addldocdtls+','
			ls_rec = ls_rec + ls_url+','+ls_docs+','+ls_infodtls+','+ls_expdtls+','+ls_expshipbno+','+ls_expshipbdt+','+ls_expport+','+ls_exprefclm+','+ls_expforcur+','+ls_expcntcode+','+ls_expduty+','+ls_ewbdtls+','+ls_transid+','+ls_transname+','+ls_transmode+','
			ls_rec = ls_rec + ls_distance+','+ls_transdocno+','+ls_transdocdt+','+ls_vehno+','+ls_vehtype;
			
			filewrite(li_filenum,ls_rec)
//		
			update fb_einvoice set xls_gen = 'Y' where docno = :ls_docno;
			if sqlca.sqlcode = -1 then
				messagebox('Error','Error occured while updating CSV indicator of '+ls_docno+' : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return -1
			end if
//			
			li_ctr++
//			
			setnull(ls_serial); setnull(ls_location); setnull(ls_suptyp); setnull(ls_regrev); setnull(ls_ecmgstin); setnull(ls_igstonintra); setnull(ls_doctyp); 
			setnull(ls_docno); setnull(ls_docdt); setnull(ls_sellerdtls); setnull(ls_sgstin); setnull(ls_slglnm); setnull(ls_strdnm); setnull(ls_saddr1); setnull(ls_saddr2); setnull(ls_sloc);
			setnull(ls_spin); setnull(ls_sstcd); setnull(ls_sph); setnull(ls_sem); setnull(ls_buyerdtls); setnull(ls_bgstin); setnull(ls_blglnm); setnull(ls_btrdnm); setnull(ls_baddr1); setnull(ls_baddr2); setnull(ls_bloc); setnull(ls_bpin); setnull(ls_bstcd); setnull(ls_bpos); 
			setnull(ls_bph); setnull(ls_bem); setnull(ls_dispdtls); setnull(ls_distrdnm); setnull(ls_disaddr1); setnull(ls_disaddr2); setnull(ls_disloc); setnull(ls_dispin); setnull(ls_disstcd); setnull(ls_shipdtls); setnull(ls_shipgstin); setnull(ls_shiplglnm); setnull(ls_shiptrdnm); setnull(ls_shipaddr1); 
			setnull(ls_shipaddr2); setnull(ls_shiploc); setnull(ls_shippin); setnull(ls_shipstcd); setnull(ls_itemlist); setnull(ls_slno); setnull(ls_prddesc); setnull(ls_isservc); setnull(ls_hsncd); setnull(ls_barcde); setnull(ls_bchdtls); setnull(ls_bchnm); setnull(ls_bchexpdt); setnull(ls_bchwrdt); 
			setnull(ls_qty); setnull(ls_freeqty); setnull(ls_uom); setnull(ls_unitprice); setnull(ls_totamt); setnull(ls_discount); setnull(ls_pretaxval); setnull(ls_assamt); setnull(ls_gstrt); setnull(ls_igstamt); setnull(ls_cgstamt); setnull(ls_sgstamt); setnull(ls_cesrt); setnull(ls_cesamt); 
			setnull(ls_cesnonadvlamt); setnull(ls_statecesrt); setnull(ls_statecesamt); setnull(ls_statecesnonadvlamt); setnull(ls_othchrg); setnull(ls_totitemval); setnull(ls_ordlineref); setnull(ls_orgcntry); setnull(ls_prdslno); setnull(ls_attribdtls); setnull(ls_attnm); setnull(ls_attval); setnull(ls_paydtls); setnull(ls_paynm); 
			setnull(ls_payacctdet); setnull(ls_paymode); setnull(ls_payfininsbr); setnull(ls_payterm); setnull(ls_payinstr); setnull(ls_paycrtrn); setnull(ls_paydirdr); setnull(ls_paycrday); setnull(ls_paypaidamt); setnull(ls_paypaymtdue); setnull(ls_refdtls); setnull(ls_refinvrm); setnull(ls_docperddtls); setnull(ls_invstdt); 
			setnull(ls_invenddt); setnull(ls_inv_no); setnull(ls_invdt); setnull(ls_othrefno); setnull(ls_contrdtls); setnull(ls_recadvrefr); setnull(ls_recadvdt); setnull(ls_tendrefr); setnull(ls_contrrefr); setnull(ls_extrefr); setnull(ls_projrefr); setnull(ls_porefr); setnull(ls_porefdt); setnull(ls_addldocdtls); 
			setnull(ls_url); setnull(ls_docs); setnull(ls_infodtls); setnull(ls_expdtls); setnull(ls_expshipbno); setnull(ls_expshipbdt); setnull(ls_expport); setnull(ls_exprefclm); setnull(ls_expforcur); setnull(ls_expcntcode); setnull(ls_expduty); setnull(ls_ewbdtls); setnull(ls_transid); setnull(ls_transname); setnull(ls_transmode);
			setnull(ls_distance); setnull(ls_transdocno); setnull(ls_transdocdt); setnull(ls_vehno);  setnull(ls_vehtype); 	
			
			fetch c1 into :ls_serial, :ls_location, :ls_suptyp, :ls_regrev, :ls_ecmgstin, :ls_igstonintra, :ls_doctyp, :ls_docno, :ls_docdt, :ls_sellerdtls, :ls_sgstin, :ls_slglnm, :ls_strdnm, :ls_saddr1, :ls_saddr2, :ls_sloc,
				:ls_spin, :ls_sstcd, :ls_sph, :ls_sem, :ls_buyerdtls, :ls_bgstin, :ls_blglnm, :ls_btrdnm, :ls_baddr1, :ls_baddr2, :ls_bloc, :ls_bpin, :ls_bstcd, :ls_bpos, 
				:ls_bph, :ls_bem, :ls_dispdtls, :ls_distrdnm, :ls_disaddr1, :ls_disaddr2, :ls_disloc, :ls_dispin, :ls_disstcd, :ls_shipdtls, :ls_shipgstin, :ls_shiplglnm, :ls_shiptrdnm, :ls_shipaddr1, 
				:ls_shipaddr2, :ls_shiploc, :ls_shippin, :ls_shipstcd, :ls_itemlist, :ls_slno, :ls_prddesc, :ls_isservc, :ls_hsncd, :ls_barcde, :ls_bchdtls, :ls_bchnm, :ls_bchexpdt, :ls_bchwrdt, 
				:ls_qty, :ls_freeqty, :ls_uom, :ls_unitprice, :ls_totamt, :ls_discount, :ls_pretaxval, :ls_assamt, :ls_gstrt, :ls_igstamt, :ls_cgstamt, :ls_sgstamt, :ls_cesrt, :ls_cesamt, 
				:ls_cesnonadvlamt, :ls_statecesrt, :ls_statecesamt, :ls_statecesnonadvlamt, :ls_othchrg, :ls_totitemval, :ls_ordlineref, :ls_orgcntry, :ls_prdslno, :ls_attribdtls, :ls_attnm, :ls_attval, :ls_paydtls, :ls_paynm, 
				:ls_payacctdet, :ls_paymode, :ls_payfininsbr, :ls_payterm, :ls_payinstr, :ls_paycrtrn, :ls_paydirdr, :ls_paycrday, :ls_paypaidamt, :ls_paypaymtdue, :ls_refdtls, :ls_refinvrm, :ls_docperddtls, :ls_invstdt, 
				:ls_invenddt, :ls_inv_no, :ls_invdt, :ls_othrefno, :ls_contrdtls, :ls_recadvrefr, :ls_recadvdt, :ls_tendrefr, :ls_contrrefr, :ls_extrefr, :ls_projrefr, :ls_porefr, :ls_porefdt, :ls_addldocdtls, 
				:ls_url, :ls_docs, :ls_infodtls, :ls_expdtls, :ls_expshipbno, :ls_expshipbdt, :ls_expport, :ls_exprefclm, :ls_expforcur, :ls_expcntcode, :ls_expduty, :ls_ewbdtls, :ls_transid, :ls_transname, :ls_transmode,
				:ls_distance, :ls_transdocno, :ls_transdocdt, :ls_vehno,  :ls_vehtype;
			
		loop
		close c1;
	else
		messagebox('Error: During Opening of Cursor',sqlca.sqlerrtext)
		return -1
	end if
//	
	fileclose(li_filenum)
//	
	setpointer(arrow!) 
	messagebox('Confirmation','Total No Of Records : '+string(li_ctr))
	return 1
//end if
end function

on w_einv_dboard.create
this.cb_1=create cb_1
this.cbx_2=create cbx_2
this.cb_6=create cb_6
this.cb_4=create cb_4
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cbx_2,&
this.cb_6,&
this.cb_4,&
this.cb_2,&
this.dw_1}
end on

on w_einv_dboard.destroy
destroy(this.cb_1)
destroy(this.cbx_2)
destroy(this.cb_6)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
dw_1.modify("t_co.text = '"+gs_co_name+"'")
//dw_1.modify("t_gnm.text = '"+gs_co_nameadd+"'")

this.tag = Message.StringParm
ll_user_level = long(this.tag)

end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if

end event

type cb_1 from commandbutton within w_einv_dboard
integer x = 3867
integer y = 8
integer width = 329
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Get Einvoice"
end type

event clicked;opensheetwithparm(w_einvget_dboard,this.tag,w_mdi,0,layered!)
end event

type cbx_2 from checkbox within w_einv_dboard
boolean visible = false
integer x = 3845
integer y = 24
integer width = 352
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select &All"
end type

event clicked;if cbx_2.text = 'Select &All' then
	cbx_2.text = '&Undo'
	for ll_rec=1 to dw_1.rowcount()
		dw_1.setitem(ll_rec,'appr_flag','Y')
		dw_1.setitem(ll_rec,'ati_confirm_by',gs_user)
		dw_1.setitem(ll_rec,'ati_confirm_dt',datetime(today()))
	next
else
	cbx_2.text = 'Select &All'
	for ll_rec=1 to dw_1.rowcount()
		 dw_1.setitem(ll_rec,'appr_flag','N')
		 setnull(ls_aprv_by);setnull(ld_aprv_dt);
		 dw_1.setitem(ll_rec,'ati_confirm_by',ls_aprv_by)
		 dw_1.setitem(ll_rec,'ati_confirm_dt',ld_aprv_dt)		
	next
end if

end event

type cb_6 from commandbutton within w_einv_dboard
boolean visible = false
integer x = 576
integer y = 8
integer width = 370
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Generate CSV"
end type

event clicked;long ll_count


li_temp = wf_gen_csv()

if li_temp = 1 then
	commit using sqlca;
	messagebox('Information!','The CSV File Has Been Generated At C:\einv_upload, Please Check !!!')
	return
elseif li_temp = -1 then
	rollback using sqlca;
end if


end event

type cb_4 from commandbutton within w_einv_dboard
integer x = 306
integer y = 8
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

type cb_2 from commandbutton within w_einv_dboard
integer x = 41
integer y = 8
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;dw_1.Retrieve()
end event

type dw_1 from datawindow within w_einv_dboard
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer y = 116
integer width = 4197
integer height = 2124
integer taborder = 30
string dataobject = "dw_einv_dboard"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
//		IF wf_check_fillcol(currentrow) = -1 THEN
//			return 1
//		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'aus_entry_by',gs_user)
		dw_1.setitem(newrow,'aus_entry_dt',datetime(today()))
//		dw_1.setcolumn('sip_brokid')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;string ls_taxinv
if dwo.name = 'einv_ind' and data = 'Y' then
	setpointer(hourglass!)
	ls_taxinv = dw_1.getitemstring(row,'docno')
	if MessageBox("Generate E-invoice Alert", 'Do You Want To Generate E-invoice ....?' ,Exclamation!, YesNo!, 1) = 1 then
		if wf_genjson(ls_taxinv) = -1 then
			rollback using sqlca;
			return 1;
		end if
	end if
end if
if dwo.name = 'cancel' and data = 'Y' then
	setpointer(hourglass!)
	ls_taxinv = dw_1.getitemstring(row,'docno')
	if MessageBox("Cancel Invoice", 'Do You Want To Cancel ....?' ,Exclamation!, YesNo!, 1) = 1 then
		
	select distinct  'x' into :ls_temp  from fb_einvoice where docno=:ls_taxinv and irn is null;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Invoice detait !',sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 0 then
			delete from 	 fb_einvoice where docno=:ls_taxinv;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Deleting From Einvoice',sqlca.sqlerrtext)
				return 1
			end if	
			update fb_saleinvoice set SI_EINV_IND='' where SI_TAXINVNO=:ls_taxinv;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Updating Sale Invoice Indicator',sqlca.sqlerrtext)
				return 1
			end if	
			commit;
			messagebox('Message','Invoice has been successfully Cancelled : '+ls_taxinv)
				dw_1.retrieve();
				return 1
		end if
	end if
end if
end event

