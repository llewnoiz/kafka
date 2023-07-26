const ip = require('ip')
require('dotenv').config()
const { Kafka, CompressionTypes, logLevel } = require('kafkajs')
const { Partitioners } = require('kafkajs')
const host = process.env.HOST_IP || ip.address()
const brokerPrimary = process.env.PRIMARY || "b-2-public.amanokomsk.1k4f5y.c4.kafka.ap-northeast-2.amazonaws.com:9196"
const brokerSecond = process.env.SECOND || "b-1-public.amanokomsk.1k4f5y.c4.kafka.ap-northeast-2.amazonaws.com:9196"

const kafka = new Kafka({
  logLevel: logLevel.INFO,
  // brokers: [`${host}:9092`],
  brokers: [ brokerPrimary, brokerSecond ],
  clientId: 'producer',
  ssl: true,
  sasl: {
    mechanism: 'scram-sha-512', // scram-sha-256 or scram-sha-512
    username: 'producer',
    password: 'producer123!'
  },
})

const producer = kafka.producer({ createPartitioner: Partitioners.LegacyPartitioner })

const getRandomNumber = () => Math.round(Math.random(10) * 1000)
const createMessage = num => ({
  key: `key-${num}`,
  value: `value-${num}-${new Date().toISOString()}`,
})


const topic = 'test'

const sendMessage = () => {
  return producer
    .send({
      topic,
      compression: CompressionTypes.GZIP,
      messages: Array(getRandomNumber())
        .fill()
        .map(_ => createMessage(getRandomNumber())),
    })
    .then(console.log)
    .catch(e => console.error(`[example/producer] ${e.message}`, e))
}

const run = async () => {
  await producer.connect()
  // setInterval(sendMessage, 3000)
  sendMessage();
}

run().catch(e => console.error(`[example/producer] ${e.message}`, e))

// const errorTypes = ['unhandledRejection', 'uncaughtException']
// const signalTraps = ['SIGTERM', 'SIGINT', 'SIGUSR2']

// errorTypes.forEach(type => {
//   process.on(type, async () => {
//     try {
//       console.log(`process.on ${type}`)
//       await producer.disconnect()
//       process.exit(0)
//     } catch (_) {
//       process.exit(1)
//     }
//   })
// })

// signalTraps.forEach(type => {
//   process.once(type, async () => {
//     try {
//       await producer.disconnect()
//     } finally {
//       process.kill(process.pid, type)
//     }
//   })
// })