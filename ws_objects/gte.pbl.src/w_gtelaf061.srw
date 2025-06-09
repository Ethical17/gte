$PBExportHeader$w_gtelaf061.srw
forward
global type w_gtelaf061 from window
end type
type ddlb_1 from dropdownlistbox within w_gtelaf061
end type
type st_1 from statictext within w_gtelaf061
end type
type cbx_1 from checkbox within w_gtelaf061
end type
type cb_3 from commandbutton within w_gtelaf061
end type
type dw_2 from datawindow within w_gtelaf061
end type
type cb_2 from commandbutton within w_gtelaf061
end type
type cb_1 from commandbutton within w_gtelaf061
end type
type cb_4 from commandbutton within w_gtelaf061
end type
type dw_1 from datawindow within w_gtelaf061
end type
end forward

global type w_gtelaf061 from window
integer width = 6967
integer height = 2484
boolean titlebar = true
string title = "(w_gtelaf061) Batch Labour Inactivation / Activation"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
event ue_option ( )
ddlb_1 ddlb_1
st_1 st_1
cbx_1 cbx_1
cb_3 cb_3
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
cb_4 cb_4
dw_1 dw_1
end type
global w_gtelaf061 w_gtelaf061

type variables
string ls_temp,ls_AC_CD, ls_DIV_CD, ls_PARTY_NAME, ls_remark, ls_imp_for
long ll_empcd,ll_user_level, l_count, ll_doc_srl,ll_emp
double ld_dramt,ld_cramt
string ls_contribution, ls_advance_made, ls_advance_refund, ls_advance_interest, ls_emp_name, ls_pf_no, ls_frdt, ls_todt, ls_emp_id, ls_yrmn
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

on w_gtelaf061.create
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.cbx_1=create cbx_1
this.cb_3=create cb_3
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.ddlb_1,&
this.st_1,&
this.cbx_1,&
this.cb_3,&
this.dw_2,&
this.cb_2,&
this.cb_1,&
this.cb_4,&
this.dw_1}
end on

on w_gtelaf061.destroy
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.cbx_1)
destroy(this.cb_3)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
//ddlb_1.Enabled = TRUE
this.tag = Message.StringParm
//ll_user_level = long(this.tag)
// wf_getreports(ll_user_level)
end event

type ddlb_1 from dropdownlistbox within w_gtelaf061
integer x = 434
integer y = 24
integer width = 599
integer height = 376
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string item[] = {"Making Inactive","Making Active"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_gtelaf061
integer x = 46
integer y = 40
integer width = 384
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Importing For : "
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_gtelaf061
integer x = 1696
integer y = 36
integer width = 421
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Unapproved"
boolean checked = true
end type

type cb_3 from commandbutton within w_gtelaf061
integer x = 1371
integer y = 20
integer width = 274
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "Process"
end type

event clicked;long ll_count
string ls_labour_id, ls_entry_dt

select count(*) into :ll_count from fb_labour_inactive where nvl(li_pst_ind, 'N') = 'N';

if sqlca.sqlcode = -1 then 
	messagebox('Error', 'Error occured while counting inactive records : '+sqlca.sqlerrtext)
	return 1
end if	

if ll_count = 0 then 
	messagebox('Message','No records found for processing')
	return 1
else
	if messagebox('Message',string(ll_count)+' Unprocessed records found, Do you want to process',Exclamation!, YesNo!, 1) = 2 then
		return 1
	end if
end if 

ll_count = 0;

declare c1 cursor for 
	select labour_id, to_char(li_entry_dt,'dd/mm/yyyy'), LI_IMPORTED_FOR  from fb_labour_inactive where nvl(li_pst_ind, 'N') = 'N';
	
open c1;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while opening cursor : '+ sqlca.sqlerrtext)
	return 1
end if

setnull(ls_labour_id); setnull(ls_entry_dt); setnull(ls_imp_for);
fetch c1 into :ls_labour_id, :ls_entry_dt, :ls_imp_for;

do while sqlca.sqlcode <> 100
	if ls_imp_for = 'I' then
		update fb_employee set emp_active = 0, emp_inactivetype = 'NameOut', emp_jobleavingdate = sysdate, emp_entry_by = :gs_user, emp_entry_dt = sysdate where emp_id = :ls_labour_id and emp_type in ('LP', 'LT', 'LO');
		
		if sqlca.sqlcode = 1 then
			messagebox('Error','Error occured while making labour ID ('+ls_labour_id+') inactive in master : '+ sqlca.sqlerrtext)
			return 1
		end if		
	elseif ls_imp_for = 'A' then
		update fb_employee set emp_active = 1, emp_inactivetype = 'Regular', emp_jobleavingdate = null, emp_entry_by = :gs_user, emp_entry_dt = sysdate where emp_id = :ls_labour_id and emp_type in ('LP', 'LT', 'LO');
		
		if sqlca.sqlcode = 1 then
			messagebox('Error','Error occured while making labour ID ('+ls_labour_id+') inactive in master : '+ sqlca.sqlerrtext)
			return 1
		end if	
	end if
	
	update fb_labour_inactive set li_confirm_by = :gs_user, li_confirm_dt = sysdate, li_pst_ind = 'Y' where labour_id = :ls_labour_id and trunc(li_entry_dt) = to_date(:ls_entry_dt, 'dd/mm/yyyy') and li_imported_for = :ls_imp_for ;
	
	if sqlca.sqlcode = 1 then
		messagebox('Error','Error occured while updating indicator of labour ID ('+ls_labour_id+') : '+ sqlca.sqlerrtext)
		return 1
	end if	
	
	ll_count += 1;
	
	setnull(ls_labour_id); setnull(ls_entry_dt); setnull(ls_imp_for);
	fetch c1 into :ls_labour_id, :ls_entry_dt, :ls_imp_for;	
loop

close c1;

commit using sqlca;
messagebox('Message', 'Processing complete, '+string(ll_count)+' Records Processed')


end event

type dw_2 from datawindow within w_gtelaf061
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer x = 32
integer y = 132
integer width = 4155
integer height = 2244
integer taborder = 60
string title = "none"
string dataobject = "dw_gtelaf061a"
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

type cb_2 from commandbutton within w_gtelaf061
integer x = 2126
integer y = 20
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

event clicked;string ls_ind 

dw_1.settransobject(sqlca)

setpointer(hourglass!)

if cbx_1.checked then
	ls_ind = 'Y'
else
	ls_ind = 'N'
end if

dw_1.retrieve(ls_ind)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found !!!')
	return 1
end if

setpointer(arrow!)


end event

type cb_1 from commandbutton within w_gtelaf061
integer x = 1083
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

if isnull(ddlb_1.text) or ddlb_1.text = '' then
	messagebox('Warning', 'Kindly select a valid Importing For Reason')
	return 1
end if

if ddlb_1.text = 'Making Inactive' then
	ls_imp_for = 'I'
elseif ddlb_1.text = 'Making Active' then
	ls_imp_for = 'A'	
end if


l_fexit = GetFileOpenName("Select Product File", &
+ ls_filename, lf_fnamed, "CSV", & 
+ "All Files (*.*),*.*")

lf_fnext = upper(right(lf_fnamed, 4))
lf_fnamed = upper(left(lf_fnamed,len(lf_fnamed) - 4))

setpointer(HourGlass!)


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
//		dw_2.visible = true
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
					ls_emp_id = trim(dw_2.GetItemstring( c1 ,"labour_id"))
					
					if ls_imp_for = 'I' then
						select distinct 'x' into :ls_temp from fb_employee where emp_type in ('LP', 'LT', 'LO') and (emp_inactivetype = 'Regular' or emp_active = '1') and emp_id = :ls_emp_id;
					elseif ls_imp_for = 'A' then
						select distinct 'x' into :ls_temp from fb_employee where emp_type in ('LP', 'LT', 'LO') and (emp_inactivetype <> 'Regular' or emp_active = '0') and emp_id = :ls_emp_id;
					end if
					
					if isnull(ls_imp_for) then
						messagebox('Warning', 'Importing For is null')
						return 1
					end if
						
					if sqlca.sqlcode = -1 then
						messagebox('Error', 'Error occured while checking labour id ('+ls_emp_id+') :'+sqlca.sqlerrtext)
						return 1
					elseif sqlca.sqlcode = 0 then 
						insert into fb_labour_inactive(LABOUR_ID, LI_ENTRY_BY, LI_ENTRY_DT, LI_CONFIRM_BY, LI_CONFIRM_DT, LI_PST_IND, LI_IMPORTED_FOR )
						values(:ls_emp_id, :gs_user, sysdate, null, null, 'N', :ls_imp_for);
						
						if sqlca.sqlcode = -1 then
							messagebox('Error', 'Error occured while inserting labour id ('+ls_emp_id+') :'+sqlca.sqlerrtext)
							return 1
						end if
						l_count += 1;
					end if
					 w_import_rows_information.sle_1.text= string(l_count)
				  next
				  close(w_import_rows_information)
					messagebox("File",string(l_count) + " Rows Imported")
					dw_2.reset()		   
			else
					messagebox("File","File Does Not Exists -> " + ls_filename)
			end if
		
	end if
end if
end event

type cb_4 from commandbutton within w_gtelaf061
integer x = 2400
integer y = 20
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

type dw_1 from datawindow within w_gtelaf061
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 32
integer y = 132
integer width = 4311
integer height = 2244
integer taborder = 50
string title = "none"
string dataobject = "dw_gtelaf061"
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

