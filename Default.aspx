<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" Theme="Theme" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"></asp:Content>
<asp:Content ID="Content2" runat="server" contentplaceholderid="ContentPlaceHolder1">
    <%--Imports--%>
    <head>
        <link rel="stylesheet" type="text/css" href="css/global.css" />
    </head>
    <%--Connections--%>
    <asp:SqlDataSource ID="SqlDataSourceDefault" runat="server" ConnectionString="<%$ ConnectionStrings:FriskisSvettisConnectionString %>" 
        SelectCommand="SELECT DISTINCT Pass.PassID, Pass.Datum, Anlaggning.Namn, Vikarie.Namn, Traningsform.Namn FROM Pass 
            LEFT JOIN Vikarie ON Pass.OrdinarieLedare = Vikarie.VikarieID 
            LEFT JOIN Anlaggning ON Pass.Anlaggning = Anlaggning.AnlaggningID 
            LEFT JOIN Traningsform ON Pass.TraningsForm = Traningsform.TraningsformID LEFT JOIN Respons ON Pass.PassID = Respons.PassID 
            WHERE Pass.NyLedare IS NULL">
    </asp:SqlDataSource>
    <%--Grid views--%>                
    <asp:GridView ID="GridView1" CssClass="grid-view" runat="server" DataSourceID="SqlDataSourceDefault" DataKeyNames="PassID">
        <Columns>
            <asp:BoundField DataField="PassID" HeaderText="PassID" InsertVisible="False" ReadOnly="True" SortExpression="PassID" Visible="False" />
            <asp:BoundField DataField="Datum" HeaderText="Datum" SortExpression="Datum" />
            <asp:BoundField DataField="Namn1" HeaderText="Ordinarie ledare" SortExpression="Namn1" />
            <asp:BoundField DataField="Namn" HeaderText="Anläggning" SortExpression="Namn" />
            <asp:BoundField DataField="Namn2" HeaderText="Träningsform" SortExpression="Namn2" />
        </Columns>
        <HeaderStyle BackColor="#FAFAFA" />
    </asp:GridView>
</asp:Content>


