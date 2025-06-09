$PBExportHeader$w_reverse_process.srw
forward
global type w_reverse_process from window
end type
type cb_3 from commandbutton within w_reverse_process
end type
type cb_1 from commandbutton within w_reverse_process
end type
type cb_2 from commandbutton within w_reverse_process
end type
end forward

global type w_reverse_process from window
integer width = 1033
integer height = 608
boolean titlebar = true
string title = "E-invoicing dashboard"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_3 cb_3
cb_1 cb_1
cb_2 cb_2
end type
global w_reverse_process w_reverse_process

type variables
long ll_cnt, ll_cnt1,ix,ll_user_level,ll_last,ll_last1, ll_ctr, li_temp
string ls_acsaleno, ls_aucsaleno, ls_ausid,ls_spmanid,ls_spid,ls_spbid,ls_invno,ls_grade, ls_temp, ls_ac_dt,ls_appr_ind,ls_tmp_id, ls_saleno, ls_file
string ls_aus_id, ls_brok, ls_iss_locn, ls_rec_locn, ls_iss_gstn, ls_rec_gstn, ls_hsn, ls_iss_gstin, ls_rec_gstin, ls_aprv_by, ls_yrmn
long ll_stno,ll_endno,ll_nochest,ll_season, ll_rec
boolean lb_neworder, lb_query
double ld_saleval,ld_due,ld_bankchrg, ld_amount, ld_totval, ld_paid, ld_balamt,ld_bnkchrgproportion, ld_chqamt,ld_net,ld_brokerage, ld_cgst_per, ld_sgst_per, ld_igst_per,ld_cgst_amt, ld_sgst_amt, ld_igst_amt, ld_inspchrg,ld_miscchrg
datetime ld_dt, ld_aus_dt,ld_aus_date, ld_prompt_dt, ld_acsaledt, ld_aprv_dt
end variables

on w_reverse_process.create
this.cb_3=create cb_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.Control[]={this.cb_3,&
this.cb_1,&
this.cb_2}
end on

on w_reverse_process.destroy
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type cb_3 from commandbutton within w_reverse_process
integer x = 187
integer y = 328
integer width = 594
integer height = 104
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Cancel Voucher"
end type

event clicked;//opensheetwithparm(w_voucher_cancel,this.tag,w_mdi,0,layered!)
end event

type cb_1 from commandbutton within w_reverse_process
integer x = 187
integer y = 220
integer width = 594
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "E-Invoice System Cancel"
end type

event clicked;opensheetwithparm(w_einvoice_cancel,this.tag,w_mdi,0,layered!)
end event

type cb_2 from commandbutton within w_reverse_process
integer x = 183
integer y = 108
integer width = 594
integer height = 104
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Attendance Cancel"
end type

event clicked;opensheetwithparm(w_attn_cancel,this.tag,w_mdi,0,layered!)
end event

