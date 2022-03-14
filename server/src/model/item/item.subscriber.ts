import { Injectable } from '@nestjs/common'
import { InjectConnection } from '@nestjs/typeorm'
import { Connection, EntitySubscriberInterface, RemoveEvent } from 'typeorm'
import { Item } from './entity/item.entity'
import { ItemService } from './item.service'

@Injectable()
export class ItemSubscriber implements EntitySubscriberInterface<Item> {
	constructor(@InjectConnection() readonly connection: Connection, private readonly itemService: ItemService) {
		connection.subscribers.push(this)
	}

	listenTo() {
		return Item
	}

	afterRemove(event: RemoveEvent<Item>): void | Promise<any> {
		this.itemService.handleItemAfterRemove(event.databaseEntity)
	}
}
