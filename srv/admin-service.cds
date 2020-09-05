using {sap.capire.bookshop as my} from '../db/schema';

service AdminService @(_requires : 'admin') {
    entity Movies              as projection on my.Movies;
    entity Books               as projection on my.Books;
    entity Magazines           as projection on my.Magazines;
    entity Authors             as projection on my.Authors;
    entity Orders              as select from my.Orders;
    entity COVID19_Survey      as projection on my.COVID19_Survey;
    entity COVID19_Temperature as projection on my.COVID19_Temperature;
    entity ProductionReport    as projection on my.ProductionReport;
}
