import { json, type RequestHandler } from '@sveltejs/kit'
import db from '$lib/database'

export const GET: RequestHandler = async (event) => {
  const entries = await db.entry.findMany()

  return json(entries)
}

export const POST: RequestHandler = async (event) => {
  const data = await event.request.formData()
  const task = data.get('task')
  const numberOfHours = data.get('numberOfHours')
  const timecardId = data.get('timecardId')
  

  // save entry to database
  await db.entry.create({
    data: {
					task,
					numberOfHours: parseInt(numberOfHours),
          timecard: {
											connect: {
												id: parseInt(timecardId),
											},
										}
				}
  });


  // return success
  return new Response(JSON.stringify({ success: true }), {
    headers: {
      'Content-Type': 'application/json'
    }
  })

}