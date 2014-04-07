<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="User.aspx.cs" Inherits="User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<head>
<meta charset="utf-8">	
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/jquery-ui-1.10.4.custom.js"></script>
    <script type="text/javascript" src="js/jquery.timepicker.js"></script>
    <link rel="stylesheet" type="text/css" href="css/jquery.timepicker.css" />
    <link href="css/jquery-ui-1.10.4.custom.css" rel="stylesheet">
</head>
    
    <style type="text/css">

        .round-button {
            display:block;
            width:44px;
            height:44px;
            line-height:42px;
            border: 1px solid #BBBBBB;
            border-radius: 50%;
            color:#444444;
            text-align:center;
            text-decoration:none;
            background: #EEEEEE;
            font-size:30px;
   
        }
        p.round-button {
            width:46px;
            height:46px;
            border: 1px solid ;
            padding: 3px;
            margin: 0 auto;
        }

        a.round-button:hover {

            box-shadow: 0 0 6px black;
            color:#222222;
        }
    </style>

        <p style="line-height: 0px; background-color:green; font-size: 12px; text-align:center;">Lägg till ett pass</p>
        <p class="round-button"><a href="User.aspx?Add" class="round-button">+</a></p>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
      .hiddencol { display: none; }
    </style>
    <script>
        window.onload = function () {
            $('#passx').show();
            $("#settingsx").show();
            $(".xxx").css('top', '-300px');
            if (window.location.href.indexOf('Settings') > 0) {
                tempMess();
            } else if (window.location.href.indexOf('Add') > 0) {
                showMessage2();
            }

            $("#message").css('opacity', 0);

            $("#vvxx").click(function () {
                alert($("#datepicker").datepicker("getDate").toString());
                document.getElementById("hdnResultValue").value = "Tajuddin";
            });

        }

        $(function () {
            $("#datepicker").datepicker();
        });

        showMessage = function () {
            $(".xxx").css('top', '-300px');
            tempMess();
            $("#message").delay(500).fadeTo('slow', 1);

        }

        tempMess = function () {
            $(".xxx").css('height', '260px');
            $(".xxx").animate({ "top": "+=400px" }, "slow");
            $('#div-pass').hide();
            $("#div-settings").show();
        }

        showMessage2 = function () {
            $(".xxx").animate({ "top": "+=400px" }, "slow");
            $(".xxx").css('height', '260px');
            $("#div-settings").hide();
            $('#div-pass').show();
        }

        $(function () {
            $("#datepicker").datepicker();
            $('#someElement').timepicker();
        });

        var currentDate = $("#datepicker").datepicker("getDate");




    </script>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" 
        SelectCommand="SELECT DISTINCT Pass.PassID, Pass.Datum, Anlaggning.Namn, Vikarie.Namn, NewLeader.Namn, Traningsform.Namn FROM Pass 
        LEFT JOIN Vikarie ON Pass.OrdinarieLedare = Vikarie.VikarieID 
        LEFT JOIN Vikarie as NewLeader ON Pass.NyLedare = NewLeader.VikarieID 
        LEFT JOIN Anlaggning ON Pass.Anlaggning = Anlaggning.AnlaggningID 
        LEFT JOIN Traningsform ON Pass.TraningsForm = Traningsform.TraningsformID LEFT JOIN Respons ON Pass.PassID = Respons.PassID 
        WHERE Pass.NyLedare = (SELECT Vikarie.VikarieID FROM Vikarie WHERE Anvandarnamn = @UserName) 
        OR (Pass.OrdinarieLedare = (SELECT Vikarie.VikarieID FROM Vikarie WHERE Anvandarnamn = @UserName) 
            AND Pass.NyLedare IS NULL)">
        <SelectParameters>
            <asp:Parameter Name="UserName"/>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceAnlaggning" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" SelectCommand="SELECT [Namn] FROM [Anlaggning]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" SelectCommand="SELECT [Namn] FROM [Traningsform]"></asp:SqlDataSource>

    <p style="padding:10px; border:1px solid #E1E1E1; border-bottom:none; background-color:#F1F1F1; font-family:Verdana; font-size:16px; margin-top:30px; margin-bottom:0px; margin-left: 0px;">Mina pass</p>
    
    <asp:GridView style="margin-top:0px" ID="GridView3" runat="server" AutoGenerateColumns="False" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="10" ForeColor="Black" GridLines="Horizontal" AllowSorting="True" DataKeyNames="PassID" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="PassID" HeaderText="PassID" SortExpression="PassID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                <ItemStyle CssClass="hiddencol"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="PassID" HeaderText="ID" SortExpression="PassID" />
            <asp:BoundField DataField="Datum" HeaderText="Datum" SortExpression="Datum" />
            <asp:BoundField DataField="Namn" HeaderText="Ordinarie ledare" SortExpression="Namn"/>
            <asp:BoundField DataField="Namn1" HeaderText="Vikarierande ledare" SortExpression="Namn1"/>
            <asp:BoundField DataField="Namn" HeaderText="Anläggning" SortExpression="Namn" />
            <asp:BoundField DataField="Namn1" HeaderText="Pass" SortExpression="Namn1" />
        </Columns>
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle  Font-Bold="False" ForeColor="#444444" HorizontalAlign="Left" BackColor="#F5FCF5" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Left" />
        <SelectedRowStyle BackColor="#CC3333" Font-Bold="False" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="Silver" />
        <SortedDescendingCellStyle BackColor="#F7F7F7" />
        <SortedDescendingHeaderStyle BackColor="Silver" />
    </asp:GridView>
     <br/>





    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetEmployees" TypeName="EmployeeBLL"></asp:ObjectDataSource>
    <br/>
        <asp:GridView style="margin-top:0px" ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="10" ForeColor="Black" GridLines="Horizontal" AllowSorting="True" OnRowCommand="GridView2_RowCommand" DataKeyNames="PassID" OnRowDataBound="GridView2_RowDataBound">    
        <Columns>
            <asp:BoundField DataField="PassID" HeaderText="PassID" SortExpression="PassID" ItemStyle-CssClass="hiddencol" HeaderStyle-CssClass="hiddencol">
                <HeaderStyle CssClass="hiddencol"></HeaderStyle>
                <ItemStyle CssClass="hiddencol"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="Datum" HeaderText="Datum" SortExpression="Datum" />
            <asp:BoundField DataField="Anvandarnamn" HeaderText="Ledare" SortExpression="Anvandarnamn" />            
            <asp:BoundField DataField="Namn" HeaderText="Anläggning" SortExpression="Namn" />
            <asp:BoundField DataField="Namn1" HeaderText="Pass" SortExpression="Namn1" />
            <asp:ButtonField ButtonType="Button" CommandName="JaCommand" Text="Ja" />
            <asp:ButtonField ButtonType="Button" CommandName="NejCommand" Text="Nej" />
        </Columns>
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle  Font-Bold="False" ForeColor="#444444" HorizontalAlign="Left" BackColor="#FAFAFA" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Left" />
        <SelectedRowStyle BackColor="#CC3333" Font-Bold="False" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="Silver" />
        <SortedDescendingCellStyle BackColor="#F7F7F7" />
        <SortedDescendingHeaderStyle BackColor="Silver" />
    </asp:GridView>

    <div id="kkk" class="xxx" style="height:260px; top:-300px; left:0px; background-color:#FEFEFE; position:fixed; width:100%; opacity:0.8; border:1px solid #AAAAAA; border-left:none; border-right:none;"></div>
    <div class="xxx" style="top:-300px; position:fixed; width:700px; margin: 0 auto;">
        <div id="div-pass" style="display:block;  width:350px; height:181px; margin: 0 auto; background-color:none; margin-top:5px;">
           <form method="POST" action="User.aspx">
            <p id="message1" style="margin-left:118px; margin-bottom:5px; opacity:0;">Du måste fylla i alla uppgifter...</p>
            <asp:Label ID="Label7" runat="server" Text="Datum" Width="115px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <input type="text" id="datepicker" name="datepicker" style="margin-top:4px; width:202px; height:20px; border:solid 1px black;" /><br/>
            <asp:Label ID="Label8" runat="server" Text="Starttid" Width="115px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <input id="someElement" name="someElement" type="text" data-time-format="H:i:s" style="margin-top:8px; width:202px; height:20px; border:solid 1px black;"/><br/>
            <asp:Label ID="Label9" runat="server" Text="Anläggning" Width="115px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceAnlaggning" DataTextField="Namn" DataValueField="Namn" style="margin-top:8px; width:204px; height:25px; border:solid 1px black;" Width="200px"></asp:DropDownList><br/>
            <asp:Label ID="Label10" runat="server" Text="Träningsform" Width="115px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource2" DataTextField="Namn" DataValueField="Namn" style="margin-top:8px; width:204px; height:25px; border:solid 1px black;" Width="200px"></asp:DropDownList><br/>
            <asp:Button ID="Button2" runat="server" Text="Skapa pass" runat="server" BackColor="#FFFBFF" BorderColor="black" BorderStyle="dotted" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em" Style="margin-left:117px; margin-top:8px;" Height="25px" Width="204px" OnClick="Button2_Click" />
            </form>
        </div>
        <div id="div-settings" style="display:none; padding-top:10px; position:relative; width:350px; height:193px; margin:0 auto; background-color:none;">  
            <p id="message" style="margin-left:118px; margin-bottom:5px; opacity:0;">Du måste fylla i alla uppgifter...</p>
            <asp:Label ID="Label1" runat="server" Text="Namn" Width="110px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:TextBox ID="tbxNamn" Text="" runat="server" BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" Width="200px" Style="margin:4px; padding-left:2px; z-index:100"></asp:TextBox><br>
            <asp:Label ID="Label2" runat="server" Text="Telefonnummer" Width="110px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:TextBox ID="tbxTelefon" runat="server" BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" Width="200px" Style="margin:4px; padding-left:2px"></asp:TextBox><br>
            <asp:Label ID="Label3" runat="server" Text="E-mail" Width="110px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:TextBox ID="tbxEmail" runat="server" BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" Width="200px" Style="margin:4px; padding-left:2px"></asp:TextBox><br>
            <asp:Label ID="Label4" runat="server" Text="Personnummer" Width="110px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:TextBox ID="tbxPersonNum" runat="server" BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" Width="200px" Style="margin:4px; padding-left:2px"></asp:TextBox><br>
            <asp:Button ID="Button1" runat="server" Text="Spara ändringar"  BackColor="#FFFBFF" BorderColor="black" BorderStyle="dotted" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em" Style="margin-left:117px; margin-top: 4px;" Height="25px" Width="204px" OnClick="Button1_Click" />
        </div>
        <div id="div1" style="display:block; padding-top:0px; position:relative; width:350px; margin:0 auto; background-color:none;">  
            <asp:Button ID="Button3" runat="server" Text="Återgå" runat="server" BackColor="#FFFBFF" BorderColor="black" BorderStyle="dotted" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em" Style="margin-left:117px; margin-top:8px;" Height="25px" Width="204px" OnClick="Button3_Click" />
        </div>
    </div>  
</asp:Content>

