$PBExportHeader$w_attn_cancel.srw
forward
global type w_attn_cancel from window
end type
type sle_1 from singlelineedit within w_attn_cancel
end type
type st_2 from statictext within w_attn_cancel
end type
type cb_2 from commandbutton within w_attn_cancel
end type
type cbx_1 from checkbox within w_attn_cancel
end type
type st_1 from statictext within w_attn_cancel
end type
type em_1 from editmask within w_attn_cancel
end type
end forward

global type w_attn_cancel from window
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
sle_1 sle_1
st_2 st_2
cb_2 cb_2
cbx_1 cbx_1
st_1 st_1
em_1 em_1
end type
global w_attn_cancel w_attn_cancel

type variables
long ll_cnt, ll_cnt1,ix,ll_user_level,ll_last,ll_last1, ll_ctr, li_temp
string ls_acsaleno, ls_aucsaleno, ls_ausid,ls_spmanid,ls_spid,ls_spbid,ls_invno,ls_grade, ls_temp, ls_ac_dt,ls_appr_ind,ls_tmp_id, ls_saleno, ls_file
string ls_aus_id, ls_brok, ls_iss_locn, ls_rec_locn, ls_iss_gstn, ls_rec_gstn, ls_hsn, ls_iss_gstin, ls_rec_gstin, ls_aprv_by, ls_yrmn
long ll_stno,ll_endno,ll_nochest,ll_season, ll_rec
boolean lb_neworder, lb_query
double ld_saleval,ld_due,ld_bankchrg, ld_amount, ld_totval, ld_paid, ld_balamt,ld_bnkchrgproportion, ld_chqamt,ld_net,ld_brokerage, ld_cgst_per, ld_sgst_per, ld_igst_per,ld_cgst_amt, ld_sgst_amt, ld_igst_amt, ld_inspchrg,ld_miscchrg
datetime ld_dt, ld_aus_dt,ld_aus_date, ld_prompt_dt, ld_acsaledt, ld_aprv_dt
string ls_frdt,ls_reason
end variables

on w_attn_cancel.create
this.sle_1=create sle_1
this.st_2=create st_2
this.cb_2=create cb_2
this.cbx_1=create cbx_1
this.st_1=create st_1
this.em_1=create em_1
this.Control[]={this.sle_1,&
this.st_2,&
this.cb_2,&
this.cbx_1,&
this.st_1,&
this.em_1}
end on

on w_attn_cancel.destroy
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.em_1)
end on

type sle_1 from singlelineedit within w_attn_cancel
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

type st_2 from statictext within w_attn_cancel
integer x = 64
integer y = 152
integer width = 169
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

type cb_2 from commandbutton within w_attn_cancel
integer x = 146
integer y = 468
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

event clicked;ls_frdt = trim(em_1.text)

ls_reason =sle_1.text



select count(*),a.lww_id into :li_temp,:ls_temp from fb_labourdailyattendance a,fb_labourwagesweek b  where a.lww_id=b.lww_id and lda_date = to_date(:ls_frdt,'dd/mm/yyyy') and  nvl(LWW_PAYCALFLAG,'0')='0' group by a.lww_id;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Attendance Date Count',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning!','Invalid Date, Attendance For This Date Is Not Available or Calculation has been Made, Please Check !!!')
	return 1
elseif sqlca.sqlcode = 0 then
	if(li_temp>0) then
		//Insert Labour daily Attendance Cancel
		insert into FB_LABDALYATT_cncl (LDA_DATE, LABOUR_ID, KAMSUB_ID, LDA_WAGES, LDA_STATUS, JOB_ID, LWW_ID, LDA_ELP, LDA_MFJ_COUNT1, LDA_MFJ_COUNT2, LDA_MFJ_COUNT3, LDA_SECTIONID1, LDA_SECTIONID2,
						LDA_SECTIONID3, LDA_LWWIND, LDA_ENTRY_BY, LDA_ENTRY_DT, LDA_ROSEND_DT, LDA_NATURE, LDA_MFJ_JUNGLIFOOT, LDA_PRORATAIND, LDA_TASKIND, LDA_TASK, LDA_LATTA, LDA_DAILY_RATEIND,cancel_by,cancel_date,
						cancel_reason )
		select LDA_DATE, LABOUR_ID, KAMSUB_ID, LDA_WAGES, LDA_STATUS, JOB_ID, LWW_ID, LDA_ELP, LDA_MFJ_COUNT1, LDA_MFJ_COUNT2, LDA_MFJ_COUNT3, LDA_SECTIONID1, LDA_SECTIONID2, LDA_SECTIONID3,
						 LDA_LWWIND, LDA_ENTRY_BY, LDA_ENTRY_DT, LDA_ROSEND_DT, LDA_NATURE, LDA_MFJ_JUNGLIFOOT, LDA_PRORATAIND, LDA_TASKIND, LDA_TASK, LDA_LATTA, LDA_DAILY_RATEIND ,:gs_user,sysdate,:ls_reason
		from fb_labourdailyattendance where lda_date = to_char(:ls_frdt,'dd/mm/yyyy') ;
			if sqlca.sqlcode = -1 then
				messagebox('Error : During Insertion of Daliy Labour Attendance',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			else 	
				//Insert Labour daily Expense Cancel
				insert into FB_DAILYEXPENSE_cncl (DE_DATE, EACSUBHEAD_ID, DE_SALARYTODAYTY, DE_WAGESTODAYTY, DE_STORESTODAYTY, DE_OTHERSTODAYTY, DE_SALARYTODATETY, DE_WAGESTODATETY, 
																DE_STORESTODATETY, DE_OTHERSTODATETY, SECTION_ID, DE_ROSEND_DT,cancel_by,cancel_date,cancel_reason) 
				select DE_DATE, EACSUBHEAD_ID, DE_SALARYTODAYTY, DE_WAGESTODAYTY, DE_STORESTODAYTY, DE_OTHERSTODAYTY, DE_SALARYTODATETY, DE_WAGESTODATETY, 
						DE_STORESTODATETY, DE_OTHERSTODATETY, SECTION_ID, DE_ROSEND_DT ,:gs_user,sysdate,:ls_reason 
				from FB_DAILYEXPENSE where DE_DATE=to_char(:ls_frdt,'dd/mm/yyyy') ;
				if sqlca.sqlcode = -1 then
				 	messagebox('SQL Error: During Insertion of Daliy Expense',sqlca.sqlerrtext)
					 rollback using sqlca;
				 	return 1
				else
					//Procedure to manage Daliy Expense
					declare p2 procedure for up_labourExpenseCancel (:ls_frdt);			
					if sqlca.sqlcode = -1 then
				 		messagebox('SQL Error: During Procedure Declare',sqlca.sqlerrtext)
					 	rollback using sqlca;
				 		return 1
					end if			
					execute p2;			
					if sqlca.sqlcode = -1 then
				 		messagebox('SQL Error: During Procedure Execute',sqlca.sqlerrtext)
					 	rollback using sqlca;
				 		return 1
					else
						//Delete from Labour daily Attendance Cancel
						delete from fb_labourdailyattendance  where trunc(lda_date) = to_date(:ls_frdt,'dd/mm/yyyy');
						if sqlca.sqlcode = -1 then
							messagebox('SQL Error: During Labour Daily Attendance Data Delete',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						else
							//Insert Task Active Cancel
							insert into FB_TASKACTIVEDAILY_cncl(TASK_ID, TASK_DATE, TASKDATE_ID, TASK_PMATODAYTY, TASK_PFATODAYTY, TASK_TMATODAYTY, TASK_TFATODAYTY, TASK_OMATODAYTY, TASK_OFATODAYTY, TASK_PMADTODAYTY,
 											TASK_PFADTODAYTY, TASK_TMADTODAYTY, TASK_TFADTODAYTY, TASK_OMADTODAYTY, TASK_OFADTODAYTY, TASK_PMCTODAYTY, TASK_PFCTODAYTY, TASK_TMCTODAYTY, TASK_TFCTODAYTY, TASK_OMCTODAYTY,
											  TASK_OFCTODAYTY, TASK_PMATODATETY, TASK_PFATODATETY, TASK_TMATODATETY, TASK_TFATODATETY, TASK_OMATODATETY, TASK_OFATODATETY, TASK_PMADTODATETY, TASK_PFADTODATETY, 
											  TASK_TMADTODATETY, TASK_TFADTODATETY, TASK_OMADTODATETY, TASK_OFADTODATETY, TASK_PMCTODATETY, TASK_PFCTODATETY, TASK_TMCTODATETY, TASK_TFCTODATETY, TASK_OMCTODATETY, 
											  TASK_OFCTODATETY, TASK_TOTWAGESTODAYTY, TASK_TOTWAGESTODATETY, SECTION_ID, TASK_PMAWTODAYTY, TASK_PFAWTODAYTY, TASK_PMADWTODAYTY, TASK_PFADWTODAYTY, TASK_PMCWTODAYTY, 
											  TASK_PFCWTODAYTY, TASK_TMAWTODAYTY, TASK_TFAWTODAYTY, TASK_TMADWTODAYTY, TASK_TFADWTODAYTY, TASK_TMCWTODAYTY, TASK_TFCWTODAYTY, TASK_OMAWTODAYTY, TASK_OFAWTODAYTY, 
											  TASK_OMADWTODAYTY, TASK_OFADWTODAYTY, TASK_OMCWTODAYTY, TASK_OFCWTODAYTY, TASK_PMAWTODATETY, TASK_PFAWTODATETY, TASK_PMADWTODATETY, TASK_PFADWTODATETY, TASK_PMCWTODATETY, 
											  TASK_PFCWTODATETY, TASK_TMAWTODATETY, TASK_TFAWTODATETY, TASK_TMADWTODATETY, TASK_TFADWTODATETY, TASK_TMCWTODATETY, TASK_TFCWTODATETY, TASK_OMAWTODATETY, TASK_OFAWTODATETY, 
											  TASK_OMADWTODATETY, TASK_OFADWTODATETY, TASK_OMCWTODATETY, TASK_OFCWTODATETY,cancel_by,cancel_date,cancel_reason)
							select TASK_ID, TASK_DATE, TASKDATE_ID, TASK_PMATODAYTY, TASK_PFATODAYTY, TASK_TMATODAYTY, TASK_TFATODAYTY, TASK_OMATODAYTY, TASK_OFATODAYTY, TASK_PMADTODAYTY, TASK_PFADTODAYTY,
												TASK_TMADTODAYTY, TASK_TFADTODAYTY, TASK_OMADTODAYTY, TASK_OFADTODAYTY,   TASK_PMCTODAYTY, TASK_PFCTODAYTY, TASK_TMCTODAYTY, TASK_TFCTODAYTY, TASK_OMCTODAYTY, TASK_OFCTODAYTY, 
												TASK_PMATODATETY, TASK_PFATODATETY, TASK_TMATODATETY, TASK_TFATODATETY,   TASK_OMATODATETY, TASK_OFATODATETY, TASK_PMADTODATETY, TASK_PFADTODATETY, TASK_TMADTODATETY, 
												TASK_TFADTODATETY, TASK_OMADTODATETY, TASK_OFADTODATETY, TASK_PMCTODATETY, TASK_PFCTODATETY, TASK_TMCTODATETY, TASK_TFCTODATETY, TASK_OMCTODATETY, TASK_OFCTODATETY, 
												TASK_TOTWAGESTODAYTY, TASK_TOTWAGESTODATETY, SECTION_ID, TASK_PMAWTODAYTY, TASK_PFAWTODAYTY, TASK_PMADWTODAYTY, TASK_PFADWTODAYTY, TASK_PMCWTODAYTY, TASK_PFCWTODAYTY, 
												TASK_TMAWTODAYTY, TASK_TFAWTODAYTY, TASK_TMADWTODAYTY, TASK_TFADWTODAYTY, TASK_TMCWTODAYTY, TASK_TFCWTODAYTY, TASK_OMAWTODAYTY, TASK_OFAWTODAYTY, TASK_OMADWTODAYTY, 
												TASK_OFADWTODAYTY, TASK_OMCWTODAYTY, TASK_OFCWTODAYTY, TASK_PMAWTODATETY, TASK_PFAWTODATETY, TASK_PMADWTODATETY, TASK_PFADWTODATETY, TASK_PMCWTODATETY, TASK_PFCWTODATETY, 
												TASK_TMAWTODATETY, TASK_TFAWTODATETY, TASK_TMADWTODATETY, TASK_TFADWTODATETY, TASK_TMCWTODATETY, TASK_TFCWTODATETY, TASK_OMAWTODATETY, TASK_OFAWTODATETY, TASK_OMADWTODATETY, 
												TASK_OFADWTODATETY, TASK_OMCWTODATETY, TASK_OFCWTODATETY ,:gs_user,sysdate,:ls_reason
							from FB_TASKACTIVEDAILY where TASK_DATE = to_date(:ls_frdt,'dd/mm/yyyy');
							if sqlca.sqlcode = -1 then
								messagebox('SQL Error: During Insertion of Task Active daily',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1							
							end if
							//Insert Task Active measurment Cancel
							insert into fb_taskactivemeas_cncl(TASKSECTION_ID, TASK_PMACOUNTTODAYTY, TASK_PFACOUNTTODAYTY, TASK_TMACOUNTTODAYTY, TASK_TFACOUNTTODAYTY, TASK_OMACOUNTTODAYTY, TASK_OFACOUNTTODAYTY, 
										TASK_PMADCOUNTTODAYTY, TASK_PFADCOUNTTODAYTY, TASK_TMADCOUNTTODAYTY, TASK_TFADCOUNTTODAYTY, TASK_OMADCOUNTTODAYTY, TASK_OFADCOUNTTODAYTY, TASK_PMCCOUNTTODAYTY, 
										TASK_PFCCOUNTTODAYTY, TASK_TMCCOUNTTODAYTY, TASK_TFCCOUNTTODAYTY, TASK_OMCCOUNTTODAYTY, TASK_OFCCOUNTTODAYTY, TASK_PMACOUNTTODATETY, TASK_PFACOUNTTODATETY, 
										TASK_TMACOUNTTODATETY, TASK_TFACOUNTTODATETY, TASK_OMACOUNTTODATETY, TASK_OFACOUNTTODATETY, TASK_PMADCOUNTTODATETY, TASK_PFADCOUNTTODATETY, TASK_TMADCOUNTTODATETY, 
										TASK_TFADCOUNTTODATETY, TASK_OMADCOUNTTODATETY, TASK_OFADCOUNTTODATETY, TASK_PMCCOUNTTODATETY, TASK_PFCCOUNTTODATETY, TASK_TMCCOUNTTODATETY, TASK_TFCCOUNTTODATETY, 
										TASK_OMCCOUNTTODATETY, TASK_OFCCOUNTTODATETY,cancel_by,cancel_date,cancel_reason)
							select TASKSECTION_ID, TASK_PMACOUNTTODAYTY, TASK_PFACOUNTTODAYTY, TASK_TMACOUNTTODAYTY, TASK_TFACOUNTTODAYTY, TASK_OMACOUNTTODAYTY, TASK_OFACOUNTTODAYTY, 
										TASK_PMADCOUNTTODAYTY, TASK_PFADCOUNTTODAYTY, TASK_TMADCOUNTTODAYTY, TASK_TFADCOUNTTODAYTY, TASK_OMADCOUNTTODAYTY, TASK_OFADCOUNTTODAYTY, TASK_PMCCOUNTTODAYTY, 
										TASK_PFCCOUNTTODAYTY, TASK_TMCCOUNTTODAYTY, TASK_TFCCOUNTTODAYTY, TASK_OMCCOUNTTODAYTY, TASK_OFCCOUNTTODAYTY, TASK_PMACOUNTTODATETY, TASK_PFACOUNTTODATETY, 
										TASK_TMACOUNTTODATETY, TASK_TFACOUNTTODATETY, TASK_OMACOUNTTODATETY, TASK_OFACOUNTTODATETY, TASK_PMADCOUNTTODATETY, TASK_PFADCOUNTTODATETY, TASK_TMADCOUNTTODATETY, 
										TASK_TFADCOUNTTODATETY, TASK_OMADCOUNTTODATETY, TASK_OFADCOUNTTODATETY, TASK_PMCCOUNTTODATETY, TASK_PFCCOUNTTODATETY, TASK_TMCCOUNTTODATETY, TASK_TFCCOUNTTODATETY, 
										TASK_OMCCOUNTTODATETY, TASK_OFCCOUNTTODATETY,:gs_user,sysdate,:ls_reason 
							from fb_taskactivemeasurement where TASKSECTION_ID in (select TASKDATE_ID from fb_taskactivedaily 
																		  where TASK_ID in (select distinct TASK_ID from fb_taskactivedaily where TASK_DATE = to_date(:ls_frdt,'dd/mm/yyyy')) and 
																				TASK_DATE = to_date(:ls_frdt,'dd/mm/yyyy') and SECTION_ID in (select distinct SECTION_ID from fb_taskactivedaily where TASK_DATE = to_date(:ls_frdt,'dd/mm/yyyy')));
							if sqlca.sqlcode = -1 then
								messagebox('SQL Error: During Insertion of Task Active measurment Cancel',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1							
							end if
							//Insert Mobile Attendance Cancel
							insert into FB_MB_ATT_cncl(LMA_DATE, LMA_MACNO, LMA_WORKERID, LMA_KAMSUBHEADID, LMA_KAMSUBNAM, LMA_TIME1, LMA_SECTIONID1, LMA_COSTCENTRE1, LMA_GRWT1, LMA_TRWT1, LMA_RDWT1, LMA_RDOFF,
										 LMA_NTWT1, LMA_USRCD1, LMA_TIME2, LMA_SECTIONID2, LMA_COSTCENTRE2, LMA_GRWT2, LMA_TRWT2, LMA_RDWT2, LMA_RDOF2, LMA_NTWT2, LMA_USRCD2, LMA_TIME3, LMA_SECTIONID3, LMA_COSTCENTRE3, 
										 LMA_GRWT3, LMA_TRWT3, LMA_RDWT3, LMA_RDOF3, LMA_NTWT3, LMA_USRCD3, LMA_TIME4, LMA_SECTIONID4, LMA_COSTCENTRE4, LMA_GRWT4, LMA_TRWT4, LMA_RDWT4, LMA_RDOF4, LMA_NTWT4, LMA_USRCD4, 
										 LMA_GRWTT, LMA_TRWTT, LMA_RDWTT, LMA_RDOFT, LMA_NTWTT, LMA_PST_IND, LMA_STATUS,cancel_by,cancel_date,cancel_reason)
							select LMA_DATE, LMA_MACNO, LMA_WORKERID, LMA_KAMSUBHEADID, LMA_KAMSUBNAM, LMA_TIME1, LMA_SECTIONID1, LMA_COSTCENTRE1, LMA_GRWT1, LMA_TRWT1, LMA_RDWT1, LMA_RDOFF,
										 LMA_NTWT1, LMA_USRCD1, LMA_TIME2, LMA_SECTIONID2, LMA_COSTCENTRE2, LMA_GRWT2, LMA_TRWT2, LMA_RDWT2, LMA_RDOF2, LMA_NTWT2, LMA_USRCD2, LMA_TIME3, LMA_SECTIONID3, LMA_COSTCENTRE3, 
										 LMA_GRWT3, LMA_TRWT3, LMA_RDWT3, LMA_RDOF3, LMA_NTWT3, LMA_USRCD3, LMA_TIME4, LMA_SECTIONID4, LMA_COSTCENTRE4, LMA_GRWT4, LMA_TRWT4, LMA_RDWT4, LMA_RDOF4, LMA_NTWT4, LMA_USRCD4, 
										 LMA_GRWTT, LMA_TRWTT, LMA_RDWTT, LMA_RDOFT, LMA_NTWTT, LMA_PST_IND, LMA_STATUS,:gs_user,sysdate,:ls_reason
							from fb_mobile_attendance where trunc(lma_date) = to_date(:ls_frdt,'dd/mm/yyyy');
							if sqlca.sqlcode = -1 then
								messagebox('SQL Error: During Insertion of Labour Mobile Attendance',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1							
							end if
							//delete from task Active Measurement
							delete from fb_taskactivemeasurement 
							 where TASKSECTION_ID in (select TASKDATE_ID from fb_taskactivedaily 
																  where TASK_ID in (select distinct TASK_ID from fb_taskactivedaily where TASK_DATE = to_date(:ls_frdt,'dd/mm/yyyy')) and 
																		TASK_DATE = to_date(:ls_frdt,'dd/mm/yyyy') and SECTION_ID in (select distinct SECTION_ID from fb_taskactivedaily where TASK_DATE = to_date(:ls_frdt,'dd/mm/yyyy')));
							if sqlca.sqlcode = -1 then
								messagebox('SQL Error: During Task Active Measurement Data Delete',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1							
							end if
							//delete from task Active Daily
							delete from fb_taskactivedaily where TASK_DATE = to_date(:ls_frdt,'dd/mm/yyyy');   
							if sqlca.sqlcode = -1 then
								messagebox('SQL Error: During task Active daily Data Delete',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1							
							end if
							//delete from Mobile Attendance
							delete from fb_mobile_attendance where trunc(lma_date) = to_date(:ls_frdt,'dd/mm/yyyy');
							if sqlca.sqlcode = -1 then
								messagebox('SQL Error: During Mobile Attendance Data Delete',sqlca.sqlerrtext)
								rollback using sqlca;
								return 1							
							end if
						end if
					end if						
				end if	
			end if
			commit;
			messagebox('Successfull','Data Has been Cancelled for date '+ls_frdt)
		end if	
end if		
end event

type cbx_1 from checkbox within w_attn_cancel
integer x = 146
integer y = 356
integer width = 494
integer height = 84
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Mobile Attendance"
boolean checked = true
end type

type st_1 from statictext within w_attn_cancel
integer x = 64
integer y = 40
integer width = 133
integer height = 56
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Date"
boolean focusrectangle = false
end type

type em_1 from editmask within w_attn_cancel
integer x = 279
integer y = 40
integer width = 320
integer height = 72
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "DD/MM/YYYY"
end type

event modified;if not isdate(em_1.text) or isnull(em_1.text) then
	messagebox('Warning!', 'Please Enter A Valid Date !!!')
	return 1
end if
end event

