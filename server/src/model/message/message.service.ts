import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm'
import { MessageDTO } from 'src/socket/model/message.dto'
import { Repository } from 'typeorm'
import { Message } from './entity/message.entity'

@Injectable()
export class MessageService extends TypeOrmCrudService<Message> {
	constructor(@InjectRepository(Message) private readonly messageRepository: Repository<Message>) {
		super(messageRepository)
	}

	public save(message: Message) {
		return this.messageRepository.save(message)
	}

	public saveAll(messages: Message[]) {
		this.messageRepository.save(messages)
	}

	public saveFromDTO(messageDto: MessageDTO) {
		return this.messageRepository.save(messageDto)
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

	public async updateMultipleMessageRead(messages: Message[]) {
		messages.forEach((message) => (message.isRead = true))
		this.saveAll(messages)
	}
}
