const ip = require('ip')

const { Kafka, logLevel } = require('kafkajs')

const host = process.env.HOST_IP || ip.address()
const br = ["b-2-public.amanokomsk.zudyhp.c4.kafka.ap-northeast-2.amazonaws.com:9196","b-1-public.amanokomsk.zudyhp.c4.kafka.ap-northeast-2.amazonaws.com:9196"];

const kafka = new Kafka({
  logLevel: logLevel.INFO,
  // brokers: [`${host}:9092`],
  brokers: br,
  clientId: 'producer',
  // ssl: true,
  sasl: {
    mechanism: 'plain', // scram-sha-256 or scram-sha-512
    username: 'consumer',
    password: 'consumer123!'
  },
})

const topic = 'topic-test'
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