import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm'
import { ImageService } from 'src/image/image.service'
import { getRepository, ILike, LessThanOrEqual, Like, Not, Repository } from 'typeorm'
import { Item } from './entity/item.entity'

@Injectable()
export class ItemService extends TypeOrmCrudService<Item> {
	private itemRepository = getRepository(Item)
	constructor(@InjectRepository(Item) private readonly itemRepo: Repository<Item>, private readonly imageService: ImageService) {
		super(itemRepo)
	}

	public async getItems(): Promise<Item[]> {
		return await this.itemRepository.find({
			where: [{ expirationDate: Not(LessThanOrEqual(new Date())) }, { expirationDate: null }]
		})
	}

	public async searchItems(searchValue: string): Promise<Item[]> {
		return await this.itemRepository.find({
			where: [
				{ expirationDate: Not(LessThanOrEqual(new Date())), itemName: ILike('%' + searchValue + '%') },
				{ expirationDate: null, itemName: ILike('%' + searchValue + '%') }
			]
		})
	}

	public async handleItemAfterRemove(item: Item) {
		this.imageService.removeImage(item.itemImage)
	}
}
