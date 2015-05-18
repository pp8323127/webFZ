<%@ page contentType="text/html; charset=big5" pageEncoding="big5" language="java"  import="java.io.*,java.util.*,eg.mvc.*,java.text.*,javax.naming.*,com.lowagie.text.*,com.lowagie.text.pdf.*,com.lowagie.text.html.simpleparser.*,java.awt.Color"%>
<%
ArrayList mvcobjAL = (ArrayList)session.getAttribute("mvcobjAL");
String fdate = request.getParameter("fdate");
String fltno = request.getParameter("fltno");
String sector = request.getParameter("sector");

response.reset();
response.setContentType("application/pdf");
response.setHeader("Content-Disposition", "attachment; filename=mvc.pdf");
OutputStream outputStream = response.getOutputStream();

try 
{
	Document document = new Document();
	PdfWriter.getInstance(document, outputStream);

	BaseFont bfChinese = BaseFont.createFont("MHei-Medium","UniCNS-UCS2-H", BaseFont.NOT_EMBEDDED);
	Font fontChinese = new Font(bfChinese, 10, Font.NORMAL, Color.BLACK);	
	document.open();
	
	float[] titlewidths = {0.99f};
	PdfPTable titleTable = new PdfPTable(titlewidths);
	titleTable.setWidthPercentage(99f);
	PdfPCell tCell = new PdfPCell(new Phrase(fdate+" "+fltno+" "+sector, fontChinese));	

	tCell.setBorder(0);
	tCell.setFixedHeight(30f);
	tCell.setHorizontalAlignment(1);
	tCell.setVerticalAlignment(1);
	titleTable.addCell(tCell);
	
	float[] widths = {0.15f, 0.4f, 0.15f, 0.05f, 0.25f};
	PdfPTable catTable = new PdfPTable(widths);
	catTable.setWidthPercentage(99f);
	catTable.setHorizontalAlignment(0);

	PdfPCell oneCell = new PdfPCell(new Phrase("卡號", fontChinese));	
	PdfPCell twoCell = new PdfPCell(new Phrase("姓名", fontChinese));
	PdfPCell threeCell = new PdfPCell(new Phrase("生日", fontChinese));
	PdfPCell fourCell = new PdfPCell(new Phrase("姓別", fontChinese));
	PdfPCell fiveCell = new PdfPCell(new Phrase("頭銜", fontChinese));
	
	oneCell.setHorizontalAlignment(1);
	oneCell.setVerticalAlignment(1);
	oneCell.setBackgroundColor(Color.cyan);
	oneCell.setFixedHeight(20f);
	
	twoCell.setHorizontalAlignment(1);
	twoCell.setVerticalAlignment(1);
	twoCell.setBackgroundColor(Color.cyan);
	
	threeCell.setHorizontalAlignment(1);
	threeCell.setVerticalAlignment(1);
	threeCell.setBackgroundColor(Color.cyan);
	
	fourCell.setHorizontalAlignment(1);
	fourCell.setVerticalAlignment(1);
	fourCell.setBackgroundColor(Color.cyan);
	
	fiveCell.setHorizontalAlignment(1);
	fiveCell.setVerticalAlignment(1);
	fiveCell.setBackgroundColor(Color.cyan);

	catTable.addCell(oneCell);
	catTable.addCell(twoCell);
	catTable.addCell(threeCell);
	catTable.addCell(fourCell);
	catTable.addCell(fiveCell);


	String meal_str = "";
	String beverage_str = "";
	String magazine_str = "";
	String newspaper_str = "";
	String tempbgcolor = "";
	Hashtable objHT = new Hashtable();
	int count =0;
	for(int i=1; i<mvcobjAL.size()-1; i++)
	{
		MVCObj aobj = (MVCObj) mvcobjAL.get(i-1);
		MVCObj obj = (MVCObj) mvcobjAL.get(i);
		MVCObj bobj = (MVCObj) mvcobjAL.get(i+1);

	if(!aobj.getCardnum().equals(obj.getCardnum()))
	{
		if(count%2==1)
		{
			tempbgcolor = "#33FF99";
		}
		else
		{
			tempbgcolor = "#33CCFF";
		}
		count++;
		objHT.clear();

		oneCell = new PdfPCell(new Phrase(obj.getCardnum()+"  "+obj.getCard_type(), fontChinese));
		if(obj.getCname() != null)
		{
			obj.setCname(obj.getCname().replaceAll(" ",""));
		}
		if(obj.getEname() != null)
		{
			obj.setEname(obj.getEname().replaceAll(" ",""));
		}
		if(obj.getEname2() != null)
		{
			obj.setEname2(obj.getEname2().replaceAll(" ",""));
		}
		twoCell = new PdfPCell(new Phrase(obj.getCname()+" "+obj.getEname()+" "+obj.getEname2(), fontChinese));
		threeCell = new PdfPCell(new Phrase(obj.getBrthdt(), fontChinese));
		fourCell = new PdfPCell(new Phrase(obj.getGender(), fontChinese));
		
		if(obj.getTitle() != null)
		{
			obj.setTitle(obj.getTitle().replaceAll(" ",""));
		}
		if(obj.getTitle_desc() != null)
		{
			obj.setTitle_desc(obj.getTitle_desc().replaceAll(" ",""));
		}
		
		fiveCell = new PdfPCell(new Phrase(obj.getCompany_cname()+"  "+obj.getTitle_desc()+"  "+obj.getCompany_ename()+"  "+obj.getTitle(), fontChinese));

		oneCell.setHorizontalAlignment(1);
		oneCell.setVerticalAlignment(1);
		twoCell.setHorizontalAlignment(1);
		twoCell.setVerticalAlignment(1);
		threeCell.setHorizontalAlignment(1);
		threeCell.setVerticalAlignment(1);
		fourCell.setHorizontalAlignment(1);
		fourCell.setVerticalAlignment(1);
		fiveCell.setHorizontalAlignment(1);
		fiveCell.setVerticalAlignment(1);

		oneCell.setBackgroundColor(Color.lightGray);
		twoCell.setBackgroundColor(Color.lightGray);
		threeCell.setBackgroundColor(Color.lightGray);
		fourCell.setBackgroundColor(Color.lightGray);
		fiveCell.setBackgroundColor(Color.lightGray);

		catTable.addCell(oneCell);
		catTable.addCell(twoCell);
		catTable.addCell(threeCell);
		catTable.addCell(fourCell);
		catTable.addCell(fiveCell);

		oneCell = new PdfPCell(new Phrase("Note", fontChinese));		
		twoCell = new PdfPCell(new Phrase(obj.getNote(), fontChinese));
		twoCell.setColspan(4);

		oneCell.setBackgroundColor(Color.PINK);
		twoCell.setBackgroundColor(Color.PINK);
		oneCell.setHorizontalAlignment(1);
		oneCell.setVerticalAlignment(1);

		catTable.addCell(oneCell);
		catTable.addCell(twoCell);
	}
	
	if(obj.getCode_desc()!=null && !"".equals(obj.getCode_desc()))
	{
		//if(objHT.size()<=0)
		if(objHT.get(obj.getType_desc())==null)
		{
			objHT.put(obj.getType_desc(),obj.getCode_desc().trim());  
		}
		else
		{
			objHT.put(obj.getType_desc(),objHT.get(obj.getType_desc())+" / "+obj.getCode_desc().trim()); 
		}
	}

	if(!obj.getCardnum().equals(bobj.getCardnum()))
	{
		Set keyset = objHT.keySet();
        Iterator it = keyset.iterator();
        while(it.hasNext())
    	{
    	    String key = String.valueOf(it.next());
    	    String value = (String) objHT.get(key);

			oneCell = new PdfPCell(new Phrase(key, fontChinese));		
			twoCell = new PdfPCell(new Phrase(value, fontChinese));
			twoCell.setColspan(4);

			oneCell.setHorizontalAlignment(1);
			oneCell.setVerticalAlignment(1);

			catTable.addCell(oneCell);
			catTable.addCell(twoCell);
		}
	}
}
	document.add(titleTable);
	document.add(catTable);
	document.close();
}
catch (Exception e) 
{
	//e.printStackTrace();
	out.println(e.toString());
} 
finally 
{		
	if (outputStream!= null) 
	{
		outputStream.flush();
		outputStream.close();
		outputStream= null;
	}
}
%>