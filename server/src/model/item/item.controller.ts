import { Body, Controller, Post } from '@nestjs/common'
import { Crud, CrudController } from '@nestjsx/crud'
import { Item } from './entity/item.entity'
import { ItemService } from './item.service'

@Crud({
	model: {
		type: Item
	},
	params: {
		id: { field: 'id', type: 'uuid', primary: true }
	},
	query: { join: { user: { eager: true } } }
})
@Controller('/item')
export class ItemController implements CrudController<Item> {
	constructor(public service: ItemService) {}
}
