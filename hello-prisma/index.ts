import { PrismaClient } from '@prisma/client'
import { v4 as uuid } from 'uuid'
const prisma  = new PrismaClient()

function getUsersFromState(state: string) {
  return prisma.user.findMany({
    where: {
      profile: {
        location: {
          some: {
            state: "Veracruz"
          }
        }
      }
    },
    include: {
      profile: {
        include: {
          location: true
        }
      }
    }
  })
}

function createUserOfState(state: string) {
  return prisma.user.create({
    data: {
      user_id: uuid(),
      email: "chema@gmail.com",
      profile: {
        create: {
          full_name: "Jose Maria CLi",
          profile_id: uuid(),
          location: {
            create: {
              location_id: uuid(),
              state
            }
          }
        }
      }
    }
  })
  .then(user => user)
  .catch(e => e)
}

function run() {
  const myState = "Veracruz"
  getUsersFromState(myState)
  .then(u => console.log(u[0].profile?.location[0]))
  .catch(console.error)
}

run()
