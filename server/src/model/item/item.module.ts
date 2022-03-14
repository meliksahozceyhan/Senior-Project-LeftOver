import { Module } from '@nestjs/common'
import { ItemService } from './item.service'
import { ItemController } from './item.controller'
import { Item } from './entity/item.entity'
import { TypeOrmModule } from '@nestjs/typeorm'
import { ImageService } from 'src/image/image.service'
import { ImageModule } from 'src/image/image.module'
import { ItemSubscriber } from './item.subscriber'

@Module({
	imports: [TypeOrmModule.forFeature([Item]), ImageModule],
	controllers: [ItemController],
	providers: [ItemService, ItemSubscriber]
})
export class ItemModule {}
