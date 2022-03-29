import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm'
import { NotificationBody } from 'src/socket/model/notification_body'
import { Repository } from 'typeorm'
import { User } from '../user/entity/user.entity'
import { Notification } from './entity/notification.entity'

@Injectable()
export class NotificationService extends TypeOrmCrudService<Notification> {
	constructor(@InjectRepository(Notification) private readonly notificationRepository: Repository<Notification>) {
		super(notificationRepository)
	}

	public saveNotification(notification: NotificationBody) {
		return this.notificationRepository.save(notification)
	}

	public async getNotificationsOfUser(userId: String): Promise<Notification[]> {
		return await this.notificationRepository.find({ where: { to: userId } })
	}

	public async deleteOneNotification(notification: Notification) {
		await this.notificationRepository.delete(notification)
	}

	public async deleteManyNotification(notifications: Notification[]) {
		await this.notificationRepository.remove(notifications)
	}
}
