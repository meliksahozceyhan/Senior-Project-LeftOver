import { Controller, Get, Query } from '@nestjs/common'
import { Message } from './entity/message.entity'
import { MessageService } from './message.service'

@Controller('message')
export class MessageController {
	constructor(private readonly messageService: MessageService) {}

	@Get('getUnreadMessagesOfRoom')
	public async getUnreadMessagesOfRoom(@Query('roomId') roomId: string, @Query('pageNumber') pageNumber: number, @Query('messageCountr') messageCount: number): Promise<Message[]> {
		return await this.messageService.getMessagesOfTheRoom(roomId, pageNumber, messageCount)
	}
}
