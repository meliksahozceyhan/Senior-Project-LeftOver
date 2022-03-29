import { Module } from '@nestjs/common'
import { NotificationService } from './notification.service'
import { NotificationController } from './notification.controller'
import { Notification } from './entity/notification.entity'
import { TypeOrmModule } from '@nestjs/typeorm'

@Module({
	imports: [TypeOrmModule.forFeature([Notification])],
	controllers: [NotificationController],
	providers: [NotificationService],
	exports: [NotificationService]
})
export class NotificationModule {}
