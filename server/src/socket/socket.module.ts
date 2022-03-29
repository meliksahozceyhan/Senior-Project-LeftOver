import { Module } from '@nestjs/common'
import { SocketService } from './socket.service'
import { SocketGateway } from './socket.gateway'
import { NotificationModule } from 'src/model/notification/notification.module'
import { NotificationService } from 'src/model/notification/notification.service'

@Module({
	imports: [NotificationModule],
	providers: [SocketGateway, SocketService]
})
export class SocketModule {}
