import { Body, Controller, Get, Post, Request, Query } from '@nestjs/common'
import { Crud, CrudController } from '@nestjsx/crud'
import { SkipAuth } from 'src/decorators/decorators'
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

	@Get('/getItems')
	public async getItems(@Request() req, @Query('userId') userId: string): Promise<any> {
		return this.service.getItems(userId)
	}

	@Get('/searchItems')
	public async searchItems(@Request() req, @Query('searchValue') searchValue: string): Promise<any> {
		return this.service.searchItems(searchValue)
	}

	@Get('/getItemsOfUser')
	public async getItemsOfUser(@Query('userId') userId: string): Promise<Item[]> {
		return this.service.getItemsOfUser(userId)
	}
}
