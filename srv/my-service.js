/**
 * Implementation for CatalogService defined in ./cat-service.cds
 */

const cds = require('@sap/cds')
const { Books } = cds.entities

module.exports = (srv) => {

    // Add some discount for overstocked books
    srv.after('READ', 'Books', each => each.stock > 111 && _addDiscount2(each, 11))

    // Reduce stock of books upon incoming orders
    srv.before('CREATE', 'Orders', _reduceStock)

    // srv.before('CREATE', 'Orders', async (req) => {
    //     const tx = cds.transaction(req), order = req.data;
    //     if (order.Items) {
    //         const affectedRows = await tx.run(order.Items.map(item =>
    //             UPDATE(Books).where({ ID: item.book_ID })
    //                 .and(`stock >=`, item.amount)
    //                 .set(`stock -=`, item.amount)
    //         )
    //         )
    //         if (affectedRows.some(row => !row)) req.error(409, 'Sold out, sorry')
    //     }
    // })

    srv.before('*', (req) => {

        console.debug('>>>', req.method, req.target.name, req.data, req.user.id)
        // req.error(400, 'oh no there is error')

    })

}

function _addDiscount2(each, discount) {
    each.title += ` -- ${discount}% discount!`
}

async function _reduceStock(req) {
    const { Items: orderItems } = req.data

    return cds.transaction(req).run(() => orderItems.map(item =>
        UPDATE(Books)
            .set('stock -=', item.amount)
            .where('ID =', item.book_ID).and('stock >=', item.amount)
    )).then(all => all.forEach((affectedRows, i) => {
        if (affectedRows === 0) {
            req.error(409, `${orderItems[i].amount} exceeds stock for book #${orderItems[i].book_ID}`)
        }
    }))
}