import { Injectable } from '@nestjs/common'
import { Notification } from 'src/model/notification/entity/notification.entity'
import { NotificationService } from 'src/model/notification/notification.service'
import { User } from 'src/model/user/entity/user.entity'
import { NotificationBody } from './model/notification_body'

@Injectable()
export class SocketService {
	constructor(private readonly notificationService: NotificationService) {}

	public async getNotificationsOfUser(userId: String): Promise<Notification[]> {
		return await this.notificationService.getNotificationsOfUser(userId)
	}

	public async deleteReadNotifications(notifications: Notification[]) {
		await this.notificationService.deleteManyNotification(notifications)
	}

	public async createNotification(notification: NotificationBody) {
		await this.notificationService.saveNotification(notification)
	}
}
