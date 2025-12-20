==> Running 'npm run dev'
> mob-pizza-backend@0.1.0 dev
> node server.js
Mongoose connected to MongoDB
MongoDB connected to: ac-vjygqnf-shard-00-01.ax0nlid.mongodb.net
Database: mob-pizza
API listening on port 10000
==> Your service is live 🎉
==> 
==> ///////////////////////////////////////////////////////////
==> 
==> Available at your primary URL https://mob-pizza.onrender.com
==> 
==> ///////////////////////////////////////////////////////////
[onboarding] payload {
  phone: undefined,
  email: 'aymanbod04@gmail.com',
  googleId: '109847488579231149428',
  firstName: 'Ayman',
  lastName: undefined,
  locale: 'en',
  allowLocation: false,
  allowNotifications: false,
  ts: '2025-12-20T20:10:12.474Z'
}
[onboarding] validation check {
  isOAuthFlow: true,
  isPhoneFlow: false,
  hasEmail: true,
  hasGoogleId: true,
  hasPhone: false
}
[onboarding] error MongoServerError: Plan executor error during findAndModify :: caused by :: E11000 duplicate key error collection: mob-pizza.users index: phone_1 dup key: { phone: null }
    at Connection.onMessage (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/connection.js:202:26)
    at MessageStream.<anonymous> (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/connection.js:61:60)
    at MessageStream.emit (node:events:518:28)
    at processIncomingData (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/message_stream.js:124:16)
    at MessageStream._write (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/message_stream.js:33:9)
    at writeOrBuffer (node:internal/streams/writable:572:12)
    at _write (node:internal/streams/writable:501:10)
    at Writable.write (node:internal/streams/writable:510:10)
    at TLSSocket.ondata (node:internal/streams/readable:1009:22)
    at TLSSocket.emit (node:events:518:28) {
  ok: 0,
  code: 11000,
  codeName: 'DuplicateKey',
  keyPattern: { phone: 1 },
  keyValue: { phone: null },
  '$clusterTime': {
    clusterTime: new Timestamp({ t: 1766261412, i: 9 }),
    signature: {
      hash: Binary.createFromBase64("6EIIse4IhjcdPjpaa7JoogLnm6A=", 0),
      keyId: new Long("7522352073225011201")
    }
  },
  operationTime: new Timestamp({ t: 1766261412, i: 9 }),
  [Symbol(errorLabels)]: Set(0) {}
}
MongoServerError: Plan executor error during findAndModify :: caused by :: E11000 duplicate key error collection: mob-pizza.users index: phone_1 dup key: { phone: null }
    at Connection.onMessage (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/connection.js:202:26)
    at MessageStream.<anonymous> (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/connection.js:61:60)
    at MessageStream.emit (node:events:518:28)
    at processIncomingData (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/message_stream.js:124:16)
    at MessageStream._write (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/message_stream.js:33:9)
    at writeOrBuffer (node:internal/streams/writable:572:12)
    at _write (node:internal/streams/writable:501:10)
    at Writable.write (node:internal/streams/writable:510:10)
    at TLSSocket.ondata (node:internal/streams/readable:1009:22)
    at TLSSocket.emit (node:events:518:28)
==> Detected service running on port 10000
==> Docs on specifying a port: https://render.com/docs/web-services#port-binding
==> Setting WEB_CONCURRENCY=1 by default, based on available CPUs in the instance
==> Deploying...
==> Running 'npm run dev'
> mob-pizza-backend@0.1.0 dev
> node server.js
Mongoose connected to MongoDB
MongoDB connected to: ac-vjygqnf-shard-00-01.ax0nlid.mongodb.net
Database: mob-pizza
API listening on port 10000
==> Your service is live 🎉
==> 
==> ///////////////////////////////////////////////////////////
==> 
==> Available at your primary URL https://mob-pizza.onrender.com
==> 
==> ///////////////////////////////////////////////////////////
[onboarding] payload {
  phone: undefined,
  email: 'aymanbod04@gmail.com',
  googleId: '109847488579231149428',
  firstName: 'Ayman',
  lastName: undefined,
  locale: 'en',
  allowLocation: false,
  allowNotifications: false,
  ts: '2025-12-20T20:18:53.299Z'
}
[onboarding] validation check {
  isOAuthFlow: true,
  isPhoneFlow: false,
  hasEmail: true,
  hasGoogleId: true,
  hasPhone: false
}
[onboarding] error MongoServerError: Updating the path 'firstName' would create a conflict at 'firstName'
    at Connection.onMessage (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/connection.js:202:26)
    at MessageStream.<anonymous> (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/connection.js:61:60)
    at MessageStream.emit (node:events:518:28)
    at processIncomingData (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/message_stream.js:124:16)
    at MessageStream._write (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/message_stream.js:33:9)
    at writeOrBuffer (node:internal/streams/writable:572:12)
    at _write (node:internal/streams/writable:501:10)
    at Writable.write (node:internal/streams/writable:510:10)
    at TLSSocket.ondata (node:internal/streams/readable:1009:22)
    at TLSSocket.emit (node:events:518:28) {
  ok: 0,
  code: 40,
  codeName: 'ConflictingUpdateOperators',
  '$clusterTime': {
    clusterTime: new Timestamp({ t: 1766261932, i: 9 }),
    signature: {
      hash: Binary.createFromBase64("qRD/SULQGNFAo6YYyXsflf7v6z8=", 0),
      keyId: new Long("7522352073225011201")
    }
  },
  operationTime: new Timestamp({ t: 1766261932, i: 9 }),
  [Symbol(errorLabels)]: Set(0) {}
}
MongoServerError: Updating the path 'firstName' would create a conflict at 'firstName'
    at Connection.onMessage (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/connection.js:202:26)
    at MessageStream.<anonymous> (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/connection.js:61:60)
    at MessageStream.emit (node:events:518:28)
    at processIncomingData (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/message_stream.js:124:16)
    at MessageStream._write (/opt/render/project/src/apps/backend/node_modules/mongodb/lib/cmap/message_stream.js:33:9)
    at writeOrBuffer (node:internal/streams/writable:572:12)
    at _write (node:internal/streams/writable:501:10)
    at Writable.write (node:internal/streams/writable:510:10)
    at TLSSocket.ondata (node:internal/streams/readable:1009:22)
    at TLSSocket.emit (node:events:518:28)