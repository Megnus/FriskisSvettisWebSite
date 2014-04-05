<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="User.aspx.cs" Inherits="User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
      .hiddencol { display: none; }
    </style>
    <script>
        window.onload = function () {

            if (window.location.href.indexOf('loginfailure') > 0) {
                $(".xxx").css({ top: '100px' });

            } else {
                $(".xxx").animate({ "top": "+=400px" }, "slow");
            }


            //alert(document.URL);
            //alert(window.location.);


            // alert(window.location.href);
            //parent.location.hash = "loaded";
            //alert(this.href.toString());
            //var second = getUrlVars()["ReturnUrl"];
            //window.location = window.location + '?loaded';

            $('input:radio[name="radio-group"]').change(function () {

                if ($(this).val() == 'login-user') {


                    $("#create-user").fadeOut("fast", function () {
                        // $("#create-user").css({ display: 'none' });
                        $("#login-user").fadeIn("slow").css("display", "inline-block");;
                        $("#kkk").animate({ "height": "220px" }, "fast");
                    });


                }
                if ($(this).val() == 'create-user') {
                    //$("#login-user").css({ display: 'none' });
                    //$("#create-user").css({ display: 'inline-block' });
                    $("#login-user").fadeOut("fast", function () {

                        $("#create-user").fadeIn('slow').css("display", "inline-block");
                        $("#kkk").animate({ "height": "280px" }, "fast");
                    });

                }
            });


        }

        fitta = function () {
            alert("hello");
        }
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

    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetEmployees" TypeName="EmployeeBLL"></asp:ObjectDataSource>
        
    <p style="padding:10px; border:1px solid #E1E1E1; border-bottom:none; background-color:#F1F1F1; font-family:Verdana; font-size:16px; margin-top:30px; margin-bottom:0px; margin-left: 0px;">Vakanta pass</p>

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

    <div id="kkk" class="xxx" style="height:220px; top:-300px; left:0px; background-color:#FEFEFE; position:fixed; width:100%; opacity:0.8; border:1px solid #AAAAAA; border-left:none; border-right:none;">
    <div class="xxx" style="top:-300px; background-color:none; width:400px; padding-top:30px; height:180px; margin: 0 auto;">
        
            <asp:Label ID="Label1" runat="server" Text="Namn" Width="110px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:TextBox ID="tbxNamn" Text="" runat="server" BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" Width="200px" Style="margin:4px; padding-left:2px; z-index:100"></asp:TextBox><br>
            <asp:Label ID="Label2" runat="server" Text="Telefonnummer" Width="110px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:TextBox ID="tbxTelefon" runat="server" BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" Width="200px" Style="margin:4px; padding-left:2px"></asp:TextBox><br>
            <asp:Label ID="Label3" runat="server" Text="E-mail" Width="110px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:TextBox ID="tbxEmail" runat="server" BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" Width="200px" Style="margin:4px; padding-left:2px"></asp:TextBox><br>
            <asp:Label ID="Label4" runat="server" Text="Personnummer" Width="110px" Font-Size="Small" Font-Names="Verdana"></asp:Label>
            <asp:TextBox ID="tbxPersonNum" runat="server" BorderColor="black" BorderStyle="Solid" BorderWidth="1px" Height="20px" Width="200px" Style="margin:4px; padding-left:2px"></asp:TextBox><br>
            <asp:Button ID="Button1" runat="server" Text="Spara ändringar"  BackColor="#FFFBFF" BorderColor="black" BorderStyle="dotted" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.9em" Style="margin-left:117px; margin-top: 4px;" Height="25px" Width="204px" OnClick="Button1_Click"/>

    </div>    
</asp:Content>

