$PBExportHeader$w_gtedsr015.srw
forward
global type w_gtedsr015 from window
end type
type em_1 from editmask within w_gtedsr015
end type
type st_1 from statictext within w_gtedsr015
end type
type cb_3 from commandbutton within w_gtedsr015
end type
type cb_1 from commandbutton within w_gtedsr015
end type
type cb_2 from commandbutton within w_gtedsr015
end type
type dw_1 from datawindow within w_gtedsr015
end type
end forward

global type w_gtedsr015 from window
integer width = 5403
integer height = 2360
boolean titlebar = true
string title = "(Gtedsr015) - Tax Invoice Details(Other than Tea)"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_1 em_1
st_1 st_1
cb_3 cb_3
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_gtedsr015 w_gtedsr015

type variables
string ls_brok, ls_brokid, ls_unit, ls_unitnm
n_cst_powerfilter iu_powerfilter
end variables

event ue_option();choose case gs_ueoption
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

on w_gtedsr015.create
this.em_1=create em_1
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.em_1,&
this.st_1,&
this.cb_3,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_gtedsr015.destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

//dp_1.value = datetime('01'+right(string(today(),'dd/mm/yyyy'),8))



end event

type em_1 from editmask within w_gtedsr015
integer x = 370
integer y = 12
integer width = 219
integer height = 92
integer taborder = 60
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
string mask = "YYYYMM"
end type

type st_1 from statictext within w_gtedsr015
integer x = 41
integer y = 28
integer width = 315
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year Month:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_gtedsr015
integer x = 1184
integer y = 8
integer width = 347
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Make CSV"
boolean cancel = true
end type

event clicked;string ls_cust, ls_iss_locn,ls_iss_gstn,  ls_rec_locn,ls_rec_gstn, ls_taxinvoice,ls_rec,ls_gnsm,ls_item_hsn,ls_date,ra_yrmn
datetime ld_date
double ld_amt,ld_cgst_per,ld_sgst_per,ld_igst_per,ld_cgst_amt,ld_sgst_amt,ld_igst_amt,ld_other_amt
integer li_filenum, li_rec, li_ctr
li_ctr=0;
setpointer(hourglass!) 


if  len(trim(em_1.text)) = 0 or isnull(em_1.text) or em_1.text = 'none' then
	messagebox ('Year Month is blank','please Enter the Year Month')
	return 1
end if;


ra_yrmn = em_1.text

setnull(ls_cust);setnull(ls_iss_locn);setnull(ls_iss_gstn);setnull(ls_rec_locn);setnull(ls_rec_gstn);setnull(ls_taxinvoice);setnull(ls_gnsm);setnull(ld_date);setnull(ls_item_hsn);
 ld_amt = 0;ld_cgst_per = 0;ld_sgst_per = 0;ld_igst_per = 0;ld_cgst_amt = 0;ld_sgst_amt = 0;ld_igst_amt = 0;ld_other_amt=0;
 
ChangeDirectory("c:\")
if DirectoryExists("temp") = false then
	CreateDirectory ("temp")
end if
	ChangeDirectory("temp")
if fileexists("c:\temp\miscsaledetail"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".csv") = true then
	filedelete("c:\temp\miscsaledetail"+string(today(),"-ddmmyy_")+string(now(),"hhmmss")+".csv")
end if

li_filenum =  fileopen("c:\temp\miscsaledetail"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".csv",linemode!,write!,lockreadwrite!,replace!)

DECLARE c1 CURSOR FOR
            select initcap(CUS_NAME) CUS_NAME, SI_ISS_LOCN,  UNIT_SHORTNAME, SI_REC_LOCN, UNIT_GSTNNO iss_gstin, CUS_GSTNNO rec_gstin,
           SI_TAXINVNO, SI_CNDATE inv_dt, ITEM_HSN_NO HSNno, sum(SID_QUANTITY * SID_RATE)+ nvl(SI_DELVCHRG,0)+nvl(SI_PACKCHRG,0)+nvl(SI_OTHCHRG,0) tot_amt,
           max(nvl(SID_CGST_PER,0)) SID_CGST_PER,  max(nvl(SID_SGST_PER,0)) SID_SGST_PER, max(nvl(SID_IGST_PER,0)) SID_IGST_PER, 
           sum(nvl(SID_CGST_AMT,0)) + nvl(SI_OCGST,0)+nvl(SI_DELVCHRG_CGST,0)+nvl(SI_PACKCHRG_CGST,0) SID_CGST_AMT, 
           sum(nvl(SID_SGST_AMT,0)) + nvl(SI_OSGST,0)+nvl(SI_DELVCHRG_SGST,0)+nvl(SI_PACKCHRG_SGST,0) SID_SGST_AMT, 
           sum (nvl(SID_IGST_AMT,0))+ nvl(SI_OIGST,0)+nvl(SI_DELVCHRG_IGST,0)+nvl(SI_PACKCHRG_IGST,0) SID_IGST_AMT, 
           nvl(SI_DELVCHRG,0)+nvl(SI_PACKCHRG,0)+nvl(SI_OTHCHRG,0) othercharges
        from fb_misc_saleinvoice a, fb_misc_sidetails b, fb_customer c, fb_statecode_master iss,  fb_statecode_master rec,fb_misc_item d, 
            (select UNIT_ID, UNIT_NAME, UNIT_SHORTNAME, UNIT_GSTNNO from fb_gardenmaster where unit_active_ind = 'Y') unit
        where a.si_id = b.si_id and si_taxinvno is not null and b.ITEM_ID = d.ITEM_ID and a.cus_id = c.cus_id and 
              SI_ISS_LOCN = iss.SM_CD(+) and SI_REC_LOCN = rec.SM_CD(+) and 
             to_char(si_cndate,'YYYYMM') = :ra_yrmn
        group by a.CUS_ID, initcap(CUS_NAME),SI_ISS_LOCN,  UNIT_SHORTNAME, initcap(iss.SM_DESC), SI_REC_LOCN, initcap(rec.SM_DESC), UNIT_GSTNNO, CUS_GSTNNO ,
           SI_TAXINVNO, SI_CNDATE, ITEM_HSN_NO,     
           nvl(SI_DELVCHRG,0),nvl(SI_PACKCHRG,0),nvl(SI_OTHCHRG,0),nvl(SI_OCGST,0),nvl(SI_DELVCHRG_CGST,0),nvl(SI_PACKCHRG_CGST,0),
           nvl(SI_OSGST,0),nvl(SI_DELVCHRG_SGST,0),nvl(SI_PACKCHRG_SGST,0), nvl(SI_OIGST,0),nvl(SI_DELVCHRG_IGST,0),nvl(SI_PACKCHRG_IGST,0) ;   

 open c1;

 if sqlca.sqlcode = 0 then
	setnull(ls_cust);setnull(ls_iss_locn);setnull(ls_iss_gstn);setnull(ls_rec_locn);setnull(ls_rec_gstn);setnull(ls_taxinvoice);setnull(ls_gnsm);setnull(ld_date);setnull(ls_item_hsn);
	 ld_amt = 0;ld_cgst_per = 0;ld_sgst_per = 0;ld_igst_per = 0;ld_cgst_amt = 0;ld_sgst_amt = 0;ld_igst_amt = 0;ld_other_amt=0;
 
	
   fetch c1 into :ls_cust, :ls_iss_locn,:ls_gnsm, :ls_rec_locn, :ls_iss_gstn, :ls_rec_gstn, :ls_taxinvoice, :ld_date, :ls_item_hsn,:ld_amt,:ld_cgst_per,:ld_sgst_per,:ld_igst_per,:ld_cgst_amt,:ld_sgst_amt,:ld_igst_amt,:ld_other_amt;

	do while sqlca.sqlcode <> 100
		
		ls_date = string(ld_date,'dd/mm/yyyy')
		if isnull(ls_cust) then; ls_cust=""; end if;
		if isnull(ls_iss_locn) then; ls_iss_locn=""; end if;
   		if isnull(ls_gnsm) then; ls_gnsm=""; end if;
		if isnull(ls_rec_locn) then; ls_rec_locn= ""; end if;
   		if isnull(ls_iss_gstn) then; ls_iss_gstn=""; end if;
   		if isnull(ls_rec_gstn) then; ls_rec_gstn=""; end if;		
		if isnull(ls_taxinvoice) then; ls_taxinvoice= ""; end if;
   		if isnull(ls_date) then; ls_date=""; end if;
   		if isnull(ls_item_hsn) then; ls_item_hsn=""; end if;
		if isnull(ld_amt) then; ld_amt=0; end if;
		if isnull(ld_cgst_per) then; ld_cgst_per=0; end if;
		if isnull(ld_sgst_per) then; ld_sgst_per=0; end if;
		if isnull(ld_igst_per) then; ld_igst_per=0; end if;
		if isnull(ld_cgst_amt) then; ld_cgst_amt=0; end if;
		if isnull(ld_sgst_amt) then; ld_sgst_amt=0; end if;
		if isnull(ld_igst_amt) then; ld_igst_amt=0; end if;
		if isnull(ld_other_amt) then; ld_other_amt=0; end if;
		
				
		ls_rec = ls_cust +"," + ls_iss_locn + "," + ls_gnsm + "," +ls_rec_locn + "," + ls_iss_gstn + "," + ls_rec_gstn + "," + ls_taxinvoice + ","+ ls_date + "," + ls_item_hsn + ","
		ls_rec = ls_rec + string(ld_amt)+"," + string(ld_cgst_per)+"," + string(ld_sgst_per)+"," + string(ld_igst_per)+"," + string(ld_cgst_amt)+"," + string(ld_sgst_amt)+"," + string(ld_igst_amt)+","+string(ld_other_amt)
		
		filewrite(li_filenum,ls_rec)
	
//		messagebox('11',ls_said)


		
		li_rec++
		li_ctr++
		
	setnull(ls_cust);setnull(ls_iss_locn);setnull(ls_iss_gstn);setnull(ls_rec_locn);setnull(ls_rec_gstn);setnull(ls_taxinvoice);setnull(ls_gnsm);setnull(ld_date);setnull(ls_item_hsn);
	 ld_amt = 0;ld_cgst_per = 0;ld_sgst_per = 0;ld_igst_per = 0;ld_cgst_amt = 0;ld_sgst_amt = 0;ld_igst_amt = 0;ld_other_amt=0;
 
	
  	 fetch c1 into :ls_cust, :ls_iss_locn,:ls_gnsm, :ls_rec_locn, :ls_iss_gstn, :ls_rec_gstn, :ls_taxinvoice, :ld_date, :ls_item_hsn,:ld_amt,:ld_cgst_per,:ld_sgst_per,:ld_igst_per,:ld_cgst_amt,:ld_sgst_amt,:ld_igst_amt,:ld_other_amt;

   loop
	close c1;
else
	messagebox('Error: During Opening of Cursor',sqlca.sqlerrtext)
	return 1
end if

fileclose(li_filenum)

setpointer(arrow!) 
messagebox('Confirmation','Total No Of Records : '+string(li_ctr))
return 1
end event

type cb_1 from commandbutton within w_gtedsr015
integer x = 649
integer y = 8
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;setpointer(hourglass!)

if  len(trim(em_1.text)) = 0 or isnull(em_1.text) or em_1.text = 'none' then
	messagebox ('Year Month is blank','please Enter the Year Month')
	return 1
end if;

dw_1.settransobject(sqlca)
dw_1.retrieve(em_1.text)

setpointer(arrow!)
if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found, Please Check !!!')
	return 1
end if


end event

type cb_2 from commandbutton within w_gtedsr015
integer x = 914
integer y = 8
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_gtedsr015
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 124
integer width = 5344
integer height = 2056
string dataobject = "dw_gtedsr015"
boolean hscrollbar = true
boolean vscrollbar = true
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

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

