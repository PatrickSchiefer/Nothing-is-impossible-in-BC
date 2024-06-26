namespace PatrickSchiefer.Printer;
page 50400 PrinterList
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Printer;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Implementation; printerEnum)
                {
                    ApplicationArea = All;
                }
            }
            repeater(list)
            {
                field(Name; Rec.Name)
                {

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Clear)
            {
                ApplicationArea = all;
                Image = Delete;
                trigger OnAction()
                begin
                    rec.DeleteAll();
                end;
            }
            action(GetPrinters)
            {
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                var
                    printImplementation: Interface IPrinterList;
                begin
                    printImplementation := printerEnum;
                    printImplementation.GetPrinters(rec);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        printerEnum := Enum::PrinterImplementations::MiddleLayer;
    end;

    var
        printerEnum: Enum PrinterImplementations;
}