import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm'
import { Repository } from 'typeorm'
import { Message } from './entity/message.entity'

@Injectable()
export class MessageService extends TypeOrmCrudService<Message> {
	constructor(@InjectRepository(Message) private readonly messageRepository: Repository<Message>) {
		super(messageRepository)
	}

	public async save(message: Message): Promise<Message> {
		return await this.messageRepository.save(message)
	}

	public async getMessagesOfTheRoom(roomId: string, messageCount: number, pageNumber: number): Promise<Message[]> {
		const result = await this.messageRepository.find({ where: { to: roomId }, order: { createdAt: 'DESC' }, take: messageCount, skip: (pageNumber - 1) * messageCount })
		return result
	}

	public async updateMessageRead(message: Message) {
		const result = await this.messageRepository.findOne(message.id)
		result.isRead = true
		this.save(result)
	}
}
