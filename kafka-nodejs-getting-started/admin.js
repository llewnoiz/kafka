const ip = require('ip')
require('dotenv').config()
const { Kafka, logLevel } = require('kafkajs')
const { async } = require('rxjs')

const host = process.env.HOST_IP || ip.address()
const brokerPrimary = process.env.PRIMARY || "b-1-public.amanokomsk.1k4f5y.c4.kafka.ap-northeast-2.amazonaws.com:9196"
const brokerSecond = process.env.SECOND || "b-2-public.amanokomsk.1k4f5y.c4.kafka.ap-northeast-2.amazonaws.com:9196"


const kafka = new Kafka({
  logLevel: logLevel.INFO,
  // brokers: [`127.0.0.1:9092`],
  brokers: [ brokerPrimary, brokerSecond ],
  clientId: 'admin',
  ssl: true,
  sasl: {
    mechanism: 'scram-sha-512', // scram-sha-256 or scram-sha-512
    username: 'consumer',
    password: 'consumer123!'
  },
})

const admin = kafka.admin();

const run = async () => {
    await admin.connect();
    await admin.createTopics({
        validateOnly: false,
        waitForLeaders: false,
        timeout: 10000,
        topics: [
            {
                topic: "test",
            }
        ]
    })
    const topic = await admin.listTopics()
    console.log(topic);
    await admin.disconnect()
}

run().catch(e => console.error(`[example/admin] ${e.message}`, e))