const ip = require('ip')
require('dotenv').config()
const { Kafka, logLevel } = require('kafkajs')

const host = process.env.HOST_IP || ip.address()
const brokerPrimary = process.env.PRIMARY || "b-2-public.amanokomsk.1k4f5y.c4.kafka.ap-northeast-2.amazonaws.com:9196"
const brokerSecond = process.env.SECOND || "b-1-public.amanokomsk.1k4f5y.c4.kafka.ap-northeast-2.amazonaws.com:9196"


const kafka = new Kafka({
  logLevel: logLevel.INFO,
  // brokers: [`${host}:9092`],
  brokers: [ brokerPrimary, brokerSecond ],
  clientId: 'consumer',
  ssl: true,
  sasl: {
    mechanism: 'scram-sha-512', // scram-sha-256 or scram-sha-512
    username: 'consumer',
    password: 'consumer123!'
  },
})

const topic = 'test'
const consumer = kafka.consumer({ groupId: 'test-group' })

const run = async () => {
  await consumer.connect()
  await consumer.subscribe({ topic, fromBeginning: true })
  await consumer.run({
    // eachBatch: async ({ batch }) => {
    //   console.log(batch)
    // },
    eachMessage: async ({ topic, partition, message }) => {
      const prefix = `${topic}[${partition} | ${message.offset}] / ${message.timestamp}`
      console.log(`- ${prefix} ${message.key}#${message.value}`)
    },
  })
}

run().catch(e => console.error(`[example/consumer] ${e.message}`, e))

const errorTypes = ['unhandledRejection', 'uncaughtException']
const signalTraps = ['SIGTERM', 'SIGINT', 'SIGUSR2']

errorTypes.forEach(type => {
  process.on(type, async e => {
    try {
      console.log(`process.on ${type}`)
      console.error(e)
      await consumer.disconnect()
      process.exit(0)
    } catch (_) {
      process.exit(1)
    }
  })
})

signalTraps.forEach(type => {
  process.once(type, async () => {
    try {
      await consumer.disconnect()
    } finally {
      process.kill(process.pid, type)
    }
  })
})