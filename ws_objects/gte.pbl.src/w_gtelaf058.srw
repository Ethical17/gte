$PBExportHeader$w_gtelaf058.srw
forward
global type w_gtelaf058 from window
end type
type cb_3 from commandbutton within w_gtelaf058
end type
type cb_2 from commandbutton within w_gtelaf058
end type
type cb_1 from commandbutton within w_gtelaf058
end type
type cb_4 from commandbutton within w_gtelaf058
end type
type dw_2 from datawindow within w_gtelaf058
end type
type dw_1 from datawindow within w_gtelaf058
end type
end forward

global type w_gtelaf058 from window
integer width = 6967
integer height = 2484
boolean titlebar = true
string title = "(w_gtelaf058) Labour Master Import"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
event ue_option ( )
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_4 cb_4
dw_2 dw_2
dw_1 dw_1
end type
global w_gtelaf058 w_gtelaf058

type variables
string ls_temp,ls_AC_CD, ls_DIV_CD, ls_PARTY_NAME, ls_remark
long ll_empcd,ll_user_level, l_count, ll_doc_srl,ll_emp
double ld_dramt,ld_cramt
string ls_emp_name, ls_emp_dob, ls_emp_sex , ls_emp_marital , ls_emp_fathername, ls_field_id , ls_id, ls_emp_type, ls_emp_jdate, ls_emp_add, ls_empno
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

on w_gtelaf058.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_4=create cb_4
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1,&
this.cb_4,&
this.dw_2,&
this.dw_1}
end on

on w_gtelaf058.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_4)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
//ddlb_1.Enabled = TRUE
this.tag = Message.StringParm
//ll_user_level = long(this.tag)
// wf_getreports(ll_user_level)
end event

type cb_3 from commandbutton within w_gtelaf058
boolean visible = false
integer x = 1294
integer y = 20
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

type cb_2 from commandbutton within w_gtelaf058
integer x = 357
integer y = 16
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


dw_1.retrieve()


setpointer(arrow!)
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No data found  !!!')
	return 1
end if


end event

type cb_1 from commandbutton within w_gtelaf058
integer x = 55
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
					ls_emp_name = trim(dw_2.GetItemstring( c1 ,"emp_name"))
					ls_emp_dob = trim(dw_2.GetItemString( c1 ,"emp_dob"))
					ls_emp_sex = trim(dw_2.GetItemstring( c1 ,"emp_sex"))
					ls_emp_marital = trim(dw_2.GetItemString( c1 ,"emp_marital"))
					ls_emp_fathername = trim(dw_2.GetItemstring( c1 ,"emp_fathername"))
					ls_field_id = trim(dw_2.GetItemstring( c1 ,"field_id"))
					ls_id = trim(dw_2.GetItemstring( c1 ,"ls_id"))
					ls_emp_type = trim(dw_2.GetItemstring( c1 ,"emp_type"))	
					ls_emp_jdate = trim(dw_2.GetItemstring( c1 ,"emp_jdate"))	
					ls_emp_add = trim(dw_2.GetItemstring( c1 ,"emp_add"))	
					
					
					if c1 = 1 then
//						select distinct 'x' into :ls_temp from fb_employee where emp_entry_by like '%%' ;
//		 
//						if sqlca.sqlcode = -1 then
//							messagebox('Error','Error occured while getting detail '+sqlca.sqlerrtext)
//							//messagebox('Error','This File Is Already Processed, Can Not Be Imported!!!',information!)
//							rollback using sqlca;
//							return 
//						elseif sqlca.sqlcode = 0 then
//							if messagebox('Warning','Data already exists, Do you want to delete and re-import?',question!,yesno!,1) = 1 then
//								delete from fb_pfform1 ;
//							else
//								return 1;
//							end if
//						end if
					end if
					
						 if len(ls_emp_name) > 0  then
							select distinct 'X' into :ls_temp from fb_employee where emp_name = :ls_emp_name and trunc(emp_dob) = to_date(:ls_emp_dob,'dd/mm/yyyy') and upper(emp_add) = upper(:ls_emp_add);
							if sqlca.sqlcode = 0 then
								messagebox('Warning','A Labour with same Name, D.O.B. and Address already exists in system. ( Check Line No. '+string(c1)+' )')
								rollback using sqlca;
								return 1;
							elseif sqlca.sqlcode = -1 then
								 messagebox("SQL Error while checking record "+string(c1),SQLCA.SQLErrtext,Information!)
								 rollback using sqlca;
								 return 1
							elseif sqlca.sqlcode = 100 then	
								if ls_emp_type <> 'LT' then
									messagebox('Warning','Employee Type should be LT')
									rollback using sqlca;
									return 1
								end if
								select max(emp_id) into :ls_empno from fb_employee where emp_type = 'LT' and emp_id like 'T%';
								ls_empno = 'T'+string(long(right(ls_empno,5)) + 1,'00000')
								insert into fb_employee (emp_id,emp_name, emp_dob, emp_sex , emp_marital , emp_fathername, field_id , ls_id, emp_type, emp_jdate, emp_add,emp_active,emp_inactivetype
																,emp_entry_by, emp_entry_dt)
							                              values (:ls_empno,upper(:ls_emp_name), to_date(:ls_emp_dob,'dd/mm/yyyy'), upper(:ls_emp_sex), upper(:ls_emp_marital),upper(:ls_emp_fathername),:ls_field_id, :ls_id, upper(:ls_emp_type), to_date(:ls_emp_jdate,'dd/mm/yyyy')
																	,:ls_emp_add,'1','Regular',:gs_user||' (IMP)',sysdate);	 
								if sqlca.sqlcode = -1 then
									messagebox("SQL Error while inserting record "+string(c1),SQLCA.SQLErrtext,Information!)
									rollback using sqlca;
									return 1
								elseif sqlca.sqlcode = 0 and c1 = dw_2.rowcount() then
									commit;
							  	end if
							end if
							
						 elseif len(ls_emp_name) = 0 or isnull(ls_emp_name) then
							 messagebox('Error: Invalid Employee Name ',l_field1+', Please Check !!!')
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

type cb_4 from commandbutton within w_gtelaf058
integer x = 631
integer y = 16
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

type dw_2 from datawindow within w_gtelaf058
event ue_leftbuttonup pbm_dwnlbuttonup
boolean visible = false
integer x = 32
integer y = 132
integer width = 3593
integer height = 2244
integer taborder = 60
string title = "none"
string dataobject = "dw_gtelaf058a"
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

type dw_1 from datawindow within w_gtelaf058
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 32
integer y = 132
integer width = 4658
integer height = 2244
integer taborder = 50
string title = "none"
string dataobject = "dw_gtelaf058"
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

