import { json, type RequestHandler } from '@sveltejs/kit'
import db from '$lib/database'

export const GET: RequestHandler = async (event) => {
  const timecards = await db.timecard.findMany()

  return json(timecards)
}
