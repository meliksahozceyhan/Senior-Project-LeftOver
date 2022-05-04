import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm'
import { Repository } from 'typeorm'
import { Room } from './entity/room.entity'

@Injectable()
export class RoomService extends TypeOrmCrudService<Room> {
	constructor(@InjectRepository(Room) private readonly roomRepository: Repository<Room>) {
		super(roomRepository)
	}

	public async save(room: Room): Promise<Room> {
		return await this.roomRepository.save(room)
	}

	public async getRoomsOfUsers(userId: string): Promise<any> {
		const roomsAndMessages = await this.getUnreadMessagesAndRooms(userId)
		const rooms = await this.roomRepository.find({ where: [{ participant1: userId }, { participant2: userId }], order: { updatedAt: 'DESC' } })
		rooms.forEach((room) => {
			var countedResult = roomsAndMessages.find((roomAndMessage) => room.id === roomAndMessage.roomId)
			if (countedResult !== undefined && countedResult !== null) {
				room.messageCount = countedResult.messageCount
			} else {
				room.messageCount = 0
			}
		})
		return rooms
	}

	public async getUnreadMessagesAndRooms(userId: string): Promise<any> {
		const result = await this.roomRepository.query(
			`SELECT r.id as "roomId", COUNT(m.id) as "messageCount" FROM room r
		LEFT OUTER JOIN message m ON m.to_id = r.id
		WHERE m.is_read != true AND m.from_id != $1 AND
		(r.participant2_id = $1 OR r.participant1_id = $1)
		GROUP BY r.id;`,
			[userId]
		)
		return result
	}

	public async createRoomViaNotification(room: Room): Promise<Room> {
		const existingResult = await this.roomRepository.find({
			where: [
				{ participant1: room.participant1.id, participant2: room.participant2.id },
				{ participant1: room.participant2.id, participant2: room.participant1.id }
			]
		})
		let resultToSend: Room
		if (existingResult.length <= 0) {
			console.log('we did not found a record')
			resultToSend = await this.roomRepository.save(room)
			resultToSend = await this.findOne(resultToSend.id)
		} else {
			console.log('we Found a record and sending you that back')
			resultToSend = existingResult[0]
		}
		return resultToSend
	}
}
