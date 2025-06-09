$PBExportHeader$w_gtelaf056.srw
forward
global type w_gtelaf056 from window
end type
type em_1 from editmask within w_gtelaf056
end type
type st_1 from statictext within w_gtelaf056
end type
type cb_3 from commandbutton within w_gtelaf056
end type
type cb_2 from commandbutton within w_gtelaf056
end type
type cb_1 from commandbutton within w_gtelaf056
end type
type cb_4 from commandbutton within w_gtelaf056
end type
type dw_1 from datawindow within w_gtelaf056
end type
type dw_2 from datawindow within w_gtelaf056
end type
end forward

global type w_gtelaf056 from window
integer width = 6967
integer height = 2484
boolean titlebar = true
string title = "(w_gtelaf056) P.F. Form 5 Import"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
event ue_option ( )
em_1 em_1
st_1 st_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_4 cb_4
dw_1 dw_1
dw_2 dw_2
end type
global w_gtelaf056 w_gtelaf056

type variables
string ls_temp,ls_AC_CD, ls_DIV_CD, ls_PARTY_NAME, ls_remark,ls_year, ls_type
long ll_empcd,ll_user_level, l_count, ll_doc_srl,ll_emp
double ld_dramt,ld_cramt
string ls_EMP_TYPE, ls_SL_NO, ls_EMP_NAME, ls_PF_NO, ls_years_bf, ls_INCOMING_TRANSFER, ls_CONT_THIS_YR, ls_INTEREST, ls_ADVANCE_REFUNDED, ls_ADVANCE_MADE, ls_CARRIED_OVER, ls_SETTLEMENT_AMT, ls_OUTGOING_TRANSFER, ls_LAPSED_AMT, ls_CARRIED_FORWARD, ls_REMARKS, ls_SETTLEMENT_STATUS, ls_SETTLEMENT_DATE
n_cst_powerfilter iu_powerfilter



end variables

event ue_option();	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_1)
		case "PRINTPREVIEW"
				this.dw_1.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_1.modify("datawindow.print.preview = no")
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

on w_gtelaf056.create
this.em_1=create em_1
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_4=create cb_4
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.em_1,&
this.st_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.cb_4,&
this.dw_1,&
this.dw_2}
end on

on w_gtelaf056.destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.settransobject(sqlca)
//ddlb_1.Enabled = TRUE
this.tag = Message.StringParm
//ll_user_level = long(this.tag)
// wf_getreports(ll_user_level)
end event

type em_1 from editmask within w_gtelaf056
integer x = 494
integer y = 28
integer width = 224
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "YYYY"
end type

type st_1 from statictext within w_gtelaf056
integer x = 347
integer y = 40
integer width = 343
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_gtelaf056
boolean visible = false
integer x = 1317
integer y = 24
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 


IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
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

type cb_2 from commandbutton within w_gtelaf056
integer x = 763
integer y = 24
integer width = 265
integer height = 100
integer taborder = 50
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


dw_1.retrieve(long(em_1.text))


setpointer(arrow!)
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No data found  !!!')
	return 1
end if


end event

type cb_1 from commandbutton within w_gtelaf056
integer x = 41
integer y = 20
integer width = 274
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Import"
end type

event clicked;integer l_fnum,l_loops,l_x
long ll_i,l_flen,l_bytes_read,l_newpos,l_rec_len,l_max_ref_no,l_fexit
string l_rec_val,ls_filename,lf_fnamed,ls_ack_catg,ls_std_price
string l_field1,l_field1a,l_field2,l_field3,l_field4,l_field5,l_field6,l_field7,l_field8,l_field9
string l_field10,l_field11,l_field12,l_field13,l_field14,l_field15,l_field16,l_field17,l_field18,l_field19,l_field32,l_field35,l_field36
date ld_dt1
string l_byte,lf_fnext
string             ls_pathname
long               ll_rc
oleobject        loo_excel
string lstr_currdata
integer c1
string ls_dsgncd


l_count = 0 

l_fexit = GetFileOpenName("Select Product File", &
+ ls_filename, lf_fnamed, "CSV", & 
+ "All Files (*.*),*.*")

lf_fnext = upper(right(lf_fnamed, 4))
lf_fnamed = upper(left(lf_fnamed,len(lf_fnamed) - 4))

setpointer(HourGlass!)

//if messagebox('Confirmation','This File Belongs To "Import Orders" ',question!,yesno!,2) = 1 then
//	ls_ack_catg = 'I'
//else
	ls_ack_catg = 'N'
//end if

l_count = 0 

if fileexists(ls_filename) then
	
	if(lf_fnext = ".CSV") then
//		  IF l_fexit = 1 THEN   
//		open(w_import_rows_information)
//		
//		l_flen = filelength(ls_filename)
//		l_fnum = fileopen(ls_filename)
//		l_bytes_read = fileread(l_fnum,l_byte)
//		do while l_bytes_read <> -100
//				l_rec_val = l_byte
//				l_rec_len = len(l_rec_val)
//				l_rec_val = right(l_rec_val,l_rec_len)
//				
//				l_field1  = f_get_string_position(l_rec_val,',')
//				l_field2  = em_1.text
//				l_field3  = em_2.text
//				l_field4  = f_get_string_position(l_rec_val,',')
//				l_field5  = f_get_string_position(l_rec_val,',')
//				l_field6  = f_get_string_position(l_rec_val,',')
//				l_field7  = f_get_string_position(l_rec_val,',')
//				l_field8  = f_get_string_position(l_rec_val,',')
//				l_field9  = f_get_string_position(l_rec_val,',')
//				l_field10  = f_get_string_position(l_rec_val,',')
//				l_field11  = f_get_string_position(l_rec_val,',')
//				
//				select replace(:l_field1,'"',''),replace(:l_field2,'"',''),replace(:l_field3,'"',''),replace(:l_field4,'"',''),replace(:l_field5,'"',''),replace(:l_field6,'"',''),replace(:l_field7,'"',''),
//						replace(:l_field8,'"',''),replace(:l_field9,'"',''),replace(:l_field10,'"',''),replace(:l_field11,'"','')
//				  into :l_field1, :l_field2, :l_field3, :l_field4, :l_field5, :l_field6, :l_field7,:l_field8, :l_field9, :l_field10, :l_field11
//				 from dual;
//	
//				if sqlca.sqlcode = -1 then
//					messagebox('Error During Replacing Double Quotes',sqlca.sqlerrtext)
//						close(w_import_rows_information)
//					fileclose(l_fnum)
//					rollback using sqlca;
//					return 1
//				end if	
//		
//			select distinct 'x' into :ls_temp from fb_battingorder where BO_YEAR =:l_field2 and  BO_SALENO = :l_field3;
//	 
//			if sqlca.sqlcode = -1 then
//				messagebox('Error','Error occured while getting sale detail '+sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 
//			elseif sqlca.sqlcode = 0 then
//				if messagebox('Warning','Data for this crop year and sale no already exists, Do you want to delete and re-import?',question!,yesno!,1) = 1 then
//					delete from fb_battingorder where BO_YEAR =:l_field2 and  BO_SALENO = :l_field3;
//				else
//					return 1;
//				end if
//			end if
//	
//			insert into fb_battingorder (BO_ZONE, BO_YEAR, BO_SALENO, BO_GARDEN, BO_CURRYRQTY, BO_CURRYRRATE, BO_CURRYRRANK, BO_PREYRQTY, BO_PREYRRATE, BO_PREYRRANK)
//				values (ltrim(rtrim(:l_field1)),to_number(ltrim(rtrim(:l_field2))),to_number(ltrim(rtrim(:l_field3))),ltrim(rtrim(:l_field4)), to_number(ltrim(rtrim(:l_field5))),to_number(ltrim(rtrim(:l_field6))),
//							to_number(ltrim(rtrim(:l_field7))),to_number(ltrim(rtrim(:l_field8))),to_number(ltrim(rtrim(:l_field9))),to_number(ltrim(rtrim(:l_field10))));
//	
//				if sqlca.sqlcode = -1 then
//					messagebox("SQL Error: During Import",SQLCA.SQLErrtext,Information!)
//						close(w_import_rows_information)				
//					fileclose(l_fnum)
//						rollback using sqlca;
//					return 
//				end if
//		
//				l_bytes_read = fileread(l_fnum,l_byte)
//				l_count = l_count + 1
//				w_import_rows_information.sle_1.text= string(l_count) 
//		loop
//		commit using sqlca;
//	
//		fileclose(l_fnum)
//		setpointer(arrow!)
//		close(w_import_rows_information)
//		dw_1.visible = true
//	
//		messagebox("Import File Information",'Total ' + string(l_count) + ' Rows Imported.....')
//	else
//		messagebox("file","File Does Not Exists -> " + ls_filename)
//	end if
else		
		dw_2.reset()
		loo_excel = CREATE OLEObject
		loo_excel.ConnectToNewObject( "excel.application" )
		loo_excel.visible = false
		loo_excel.workbooks.open( ls_filename )
		loo_excel.ActiveCell.CurrentRegion.Select()
		loo_excel.Selection.Copy()
		ll_rc = dw_2.ImportClipBoard ()
		ClipBoard('')
		loo_excel.workbooks.close()
		loo_excel.disconnectobject()
		DESTROY loo_excel
		dw_2.settransobject(sqlca)
		 if(dw_2.RowCount() > 0) then		 
		 		
				open(w_import_rows_information)
		 	     for c1=1 to dw_2.RowCount()
					ls_emp_type = trim(dw_2.GetItemString( c1 ,"emp_type"))
					ls_sl_no = trim(dw_2.GetItemstring( c1 ,"sl_no"))
					ls_emp_name = trim(dw_2.GetItemstring( c1 ,"emp_name"))
					ls_type = trim(dw_2.GetItemString( c1 ,"type")) 
					ls_pf_no = trim(dw_2.GetItemString( c1 ,"pf_no"))
					ls_years_bf = dw_2.GetItemstring( c1 ,"years_bf")
					ls_incoming_transfer = dw_2.GetItemstring( c1 ,"incoming_transfer")
					ls_cont_this_yr = dw_2.GetItemString( c1 ,"cont_this_yr")
					ls_interest = trim(dw_2.GetItemString( c1 ,"interest"))
					ls_advance_refunded = dw_2.GetItemString( c1 ,"advance_refunded")
					ls_advance_made = dw_2.GetItemString( c1 ,"advance_made")
					ls_carried_over = trim(dw_2.GetItemString( c1 ,"carried_over"))
					ls_settlement_amt = trim(dw_2.GetItemString( c1 ,"settlement_amt"))
					ls_outgoing_transfer = trim(dw_2.GetItemString( c1 ,"outgoing_transfer"))
					ls_lapsed_amt = trim(dw_2.GetItemString( c1 ,"lapsed_amt"))
					ls_carried_forward = trim(dw_2.GetItemString( c1 ,"carried_forward"))
					ls_year = trim(dw_2.GetItemString( c1 ,"year")) 
					ls_remarks = trim(dw_2.GetItemString( c1 ,"remarks"))
//					ls_settlement_status = trim(dw_2.GetItemString( c1 ,"settlement_status")) 
//					ls_settlement_date = trim(dw_2.GetItemString( c1 ,"settlement_dt")) 
					
					
					if isnull(ls_years_bf) then ls_years_bf = '0';
					if isnull(ls_incoming_transfer) then ls_incoming_transfer = '0';
					if isnull(ls_cont_this_yr) then ls_cont_this_yr = '0';
					if isnull(ls_interest) then ls_interest = '0';
					if isnull(ls_advance_refunded) then ls_advance_refunded = '0';
					if isnull(ls_advance_made) then ls_advance_made = '0';
					if isnull(ls_carried_over) then ls_carried_over = '0';
					if isnull(ls_settlement_amt) then ls_settlement_amt = '0';
					if isnull(ls_outgoing_transfer) then ls_outgoing_transfer = '0';
					if isnull(ls_lapsed_amt) then ls_lapsed_amt = '0';
					if isnull(ls_carried_forward) then ls_carried_forward = '0';
					
					
					if c1 = 1 then
						select distinct 'x' into :ls_temp from fb_pfform5 where year = to_number(:ls_year);
		 
						if sqlca.sqlcode = -1 then
							messagebox('Error','Error occured while getting detail '+sqlca.sqlerrtext)
							//messagebox('Error','This File Is Already Processed, Can Not Be Imported!!!',information!)
							rollback using sqlca;
							return 
						elseif sqlca.sqlcode = 0 then
//							if messagebox('Warning','Data already exists, Do you want to delete and re-import?',question!,yesno!,2) = 1 then
//								delete from fb_pfform5 where year = to_number(:ls_year); 
//							else
//								return 1;
//							end if
							messagebox('Warning','Data already exists for this year '+sqlca.sqlerrtext)
							rollback using sqlca;
							return 
						end if
					end if
					
						 if len(ls_pf_no) > 0  then
							insert into fb_pfform5 (EMP_TYPE, SL_NO, EMP_NAME, PF_NO, YEARS_BF, INCOMING_TRANSFER, CONT_THIS_YR, INTEREST, ADVANCE_REFUNDED, ADVANCE_MADE, CARRIED_OVER, SETTLEMENT_AMT, OUTGOING_TRANSFER, LAPSED_AMT, CARRIED_FORWARD, REMARKS,SETTLEMENT_STATUS, SETTLEMENT_DATE, YEAR, TYPE, ENTRY_BY, ENTRY_DT)
							                              values (:ls_emp_type, to_number(:ls_sl_no), :ls_emp_name,to_number(:ls_pf_no),to_number(:ls_years_bf),to_number(:ls_incoming_transfer),to_number(:ls_cont_this_yr), to_number(:ls_interest), to_number(:ls_advance_refunded),
																	to_number(:ls_advance_made), to_number(:ls_carried_over), to_number(:ls_settlement_amt),to_number(:ls_outgoing_transfer), to_number(:ls_lapsed_amt), to_number(:ls_carried_forward),
																	:ls_remarks, NULL, NULL, :ls_year, :ls_type, :gs_user, sysdate);	 
							  if sqlca.sqlcode = -1 then
								  messagebox("SQL Error while inserting record "+string(c1),SQLCA.SQLErrtext,Information!)
								  rollback using sqlca;
								  return 1
							  elseif sqlca.sqlcode = 0 and c1 = dw_2.rowcount() then
									commit;
							  end if
							
						 elseif len(ls_pf_no) = 0 or isnull(ls_pf_no) then
							 messagebox('Error: Invalid P.F. No. ',l_field1+', Please Check !!!')
							 return 1
						  end if  
						 l_count = l_count + 1
						 w_import_rows_information.sle_1.text= string(l_count)
				  next
				  close(w_import_rows_information)
					messagebox("file","File Imported " + ls_filename + " Completed")
					dw_2.reset()
					dw_1.retrieve()
				   
		else
				messagebox("file","File Does Not Exists -> " + ls_filename)
		end if
	
end if
end if
end event

type cb_4 from commandbutton within w_gtelaf056
integer x = 1033
integer y = 24
integer width = 279
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)

		


end event

type dw_1 from datawindow within w_gtelaf056
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 32
integer y = 132
integer width = 5147
integer height = 2244
integer taborder = 50
string title = "none"
string dataobject = "dw_gtelaf056"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF

end event

event rbuttondown;dw_1.hide()
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF

end event

event itemchanged;dw_1.setitem(row,'settlement_date',today())
cb_3.enabled = true
end event

type dw_2 from datawindow within w_gtelaf056
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer x = 32
integer y = 132
integer width = 6857
integer height = 2244
integer taborder = 60
string title = "none"
string dataobject = "dw_gtelaf056a"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

event rbuttondown;dw_1.hide()
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF

end event

