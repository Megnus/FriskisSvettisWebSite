<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>

<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <style type="text/css">
      .hiddencol { display: none; }
    </style>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" 
        SelectCommand="SELECT DISTINCT Pass.PassID, Pass.Datum, Anlaggning.Namn, Vikarie.Anvandarnamn, Traningsform.Namn FROM Pass LEFT JOIN Vikarie ON Pass.OrdinarieLedare = Vikarie.VikarieID LEFT JOIN Anlaggning ON Pass.Anlaggning = Anlaggning.AnlaggningID LEFT JOIN Traningsform ON Pass.TraningsForm = Traningsform.TraningsformID LEFT JOIN Respons ON Pass.PassID = Respons.PassID">
    </asp:SqlDataSource>

    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetEmployees" TypeName="EmployeeBLL"></asp:ObjectDataSource>
        

                
    <asp:GridView style="margin-top:20px" ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" Width="100%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="10" ForeColor="Black" GridLines="Horizontal" AllowSorting="True" DataKeyNames="PassID">
        <Columns>
            <asp:BoundField DataField="PassID" HeaderText="PassID" InsertVisible="False" ReadOnly="True" SortExpression="PassID" Visible="False" />
            <asp:BoundField DataField="Datum" HeaderText="Datum" SortExpression="Datum" />
            <asp:BoundField DataField="Anvandarnamn" HeaderText="Ledare" SortExpression="Anvandarnamn"/>
            <asp:BoundField DataField="Namn" HeaderText="Namn" SortExpression="Namn" />
            <asp:BoundField DataField="Namn1" HeaderText="Namn1" SortExpression="Namn1" />
        </Columns>

        <HeaderStyle BackColor="#FAFAFA" HorizontalAlign="Left" />

    </asp:GridView>
</asp:Content>


