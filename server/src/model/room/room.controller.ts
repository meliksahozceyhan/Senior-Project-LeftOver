import { Body, Controller, Get, Post, Query } from '@nestjs/common'
import { Crud, CrudController } from '@nestjsx/crud'
import { Room } from './entity/room.entity'
import { RoomService } from './room.service'
@Crud({
	model: {
		type: Room
	},
	params: {
		id: { field: 'id', type: 'uuid', primary: true }
	},
	query: { join: { participant1: { eager: true }, participant2: { eager: true } } }
})
@Controller('room')
export class RoomController implements CrudController<Room> {
	constructor(public service: RoomService) {}

	@Get('getRoomsOfUser')
	public async getRoomsOfUser(@Query('userId') userId: string): Promise<any> {
		return await this.service.getRoomsOfUsers(userId)
	}

	@Post('createRoomViaNotification')
	public async createRoomViaNotification(@Body() room: Room): Promise<Room> {
		return await this.service.createRoomViaNotification(room)
	}
}
