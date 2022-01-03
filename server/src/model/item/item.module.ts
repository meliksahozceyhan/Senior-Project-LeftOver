import { Module } from '@nestjs/common'
import { ItemService } from './item.service'
import { ItemController } from './item.controller'
import { Item } from './entity/item.entity'
import { TypeOrmModule } from '@nestjs/typeorm'

@Module({
	imports: [TypeOrmModule.forFeature([Item])],
	controllers: [ItemController],
	providers: [ItemService]
})
export class ItemModule {}
