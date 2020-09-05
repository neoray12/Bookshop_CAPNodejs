namespace sap.capire.bookshop;

using {
    Currency,
    managed,
    cuid
} from '@sap/cds/common';

using {sap.capire.products.Products} from '../products/index';

entity Books : managed, additionalInfo {
    key ID       : Integer;
        title    : localized String(111);
        descr    : localized String(1111);
        author   : Association to Authors;
        stock    : Integer;
        price    : Decimal(9, 2);
        currency : Currency;
}

entity Magazines : Products {
    author : Association to Authors;
}

@cds.autoexpose
entity Authors : managed {
    key ID    : Integer;
        name  : String(111);
        books : Association to many Books
                    on books.author = $self;
}

entity Orders : managed, cuid {
    OrderNo  : String       @title : 'Order Number'; //> readable key
    Items    : Composition of many OrderItems
                   on Items.parent = $self;
    total    : Decimal(9, 2)@readonly;
    currency : Currency;
}

entity OrderItems : cuid {
    parent    : Association to Orders;
    book      : Association to Books;
    amount    : Integer;
    netAmount : Decimal(9, 2);
}

entity Movies : additionalInfo {
    key ID   : Integer;
        name : String(111);

}

aspect additionalInfo {

    genre    : String(100);
    language : String(200);

}

entity COVID19_Survey : managed, cuid {
    email               : String;
    department          : String;
    statusA             : Boolean;
    statusB             : Boolean;
    statusC             : Boolean;
    statusD             : Boolean;
    statusBComment      : String;
    statusD_Train       : Boolean;
    statusD_TrainNumber : String;
    statusD_HSR         : Boolean;
    statusD_HSRNumber   : Integer;
    statusD_MRT         : Boolean;
    statusD_MRT_start   : String;
    statusD_MRT_end     : String;
}

entity COVID19_Temperature : managed, cuid {
    email        : String;
    department   : String;
    submitDate   : Date;
    foreheadTemp : Boolean;
    earTemp      : Boolean;
    armTemp      : Boolean;
    temperature  : Decimal(3, 1)
}

entity ProductionReport : managed, cuid {
    email       : String;
    department  : String;
    workstation : String;
    workProcess : String;
    duration    : Time;
    material    : String;
    piece       : Integer;
}
