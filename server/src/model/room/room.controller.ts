import { Controller, Get, Query } from '@nestjs/common'
import { Room } from './entity/room.entity'
import { RoomService } from './room.service'

@Controller('room')
export class RoomController {
	constructor(private readonly roomService: RoomService) {}

	@Get('getRoomsOfUser')
	public async getRoomsOfUser(@Query('userId') userId: string): Promise<Room[]> {
		return await this.roomService.getRoomsOfUsers(userId)
	}
}
