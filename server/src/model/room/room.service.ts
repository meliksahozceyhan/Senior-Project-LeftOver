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

	public async getRoomsOfUsers(userId: string): Promise<Room[]> {
		return await this.roomRepository.find({ where: [{ participant1: userId }, { participant2: userId }] })
	}
}
