backend logs ::
[cart] Adding item to cart for identifier: 8106020049
[cart] Looking up user by phone: 8106020049
[cart] Found user: new ObjectId("696cc6e343011a2a87b550ba") - adding item to their cart
[cart] error adding item: Error: User validation failed: cart.0.selectedSize: `18"` is not a valid enum value for path `selectedSize`.
    at ValidationError.inspect (/opt/render/project/src/apps/backend/node_modules/mongoose/lib/error/validation.js:50:26)
    at formatValue (node:internal/util/inspect:877:19)
    at inspect (node:internal/util/inspect:404:10)
    at formatWithOptionsInternal (node:internal/util/inspect:2402:40)
    at formatWithOptions (node:internal/util/inspect:2264:10)
    at console.value (node:internal/console/constructor:345:14)
    at console.error (node:internal/console/constructor:412:61)
    at exports.addItem (/opt/render/project/src/apps/backend/src/controllers/cart.controller.js:152:13)
    at process.processTicksAndRejections (node:internal/process/task_queues:105:5) {
  errors: {
    'cart.0.selectedSize': ValidatorError: `18"` is not a valid enum value for path `selectedSize`.
        at validate (/opt/render/project/src/apps/backend/node_modules/mongoose/lib/schematype.js:1365:13)
        at SchemaType.doValidate (/opt/render/project/src/apps/backend/node_modules/mongoose/lib/schematype.js:1349:7)
        at /opt/render/project/src/apps/backend/node_modules/mongoose/lib/document.js:3006:18
        at process.processTicksAndRejections (node:internal/process/task_queues:85:11) {
      properties: [Object],
      kind: 'enum',
      path: 'selectedSize',
      value: '18"',
      reason: undefined,
      [Symbol(mongoose:validatorError)]: true
    }
  },
  _message: 'User validation failed'
}
[user] updating profile for identifier: 8106020049 with: { phone: '8106020049', phoneVerified: true }
[order] Creating order for identifier: 8106020049
[order] Order data: {"itemsCount":1,"customerName":"Aymann Quad","phoneNumber":"8106020049","totalPrice":31.78}
[order] Looking up user by phone: 8106020049
[order] Found user: new ObjectId("696cc6e343011a2a87b550ba") role: customer
[order] Mapping size: "18"" -> "medium"
[order] Creating order with items: [
  {
    "name": "Meat Lover",
    "size": "medium",
    "hasMenuItem": false
  }
]
[order] About to save order, orderId will be auto-generated
[order] Order saved successfully with orderId: ORD-20260121-003
[cart] Clearing cart for identifier: 8106020049
[cart] Looking up user by phone: 8106020049
[cart] Found user: new ObjectId("696cc6e343011a2a87b550ba") - clearing their cart
[payment] Amount mismatch: requested 3178, order 1918
[payment] Created payment intent pi_3Ss0RqGkRrxVQekM0FNkLoLW for order 6970c53a5dc1179658399711