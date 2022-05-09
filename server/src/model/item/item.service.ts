import { Injectable } from '@nestjs/common'
import { InjectRepository } from '@nestjs/typeorm'
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm'
import { ImageService } from 'src/image/image.service'
import { Equal, getRepository, ILike, LessThanOrEqual, Like, Not, Repository } from 'typeorm'
import { Item } from './entity/item.entity'

@Injectable()
export class ItemService extends TypeOrmCrudService<Item> {
	private itemRepository = getRepository(Item)
	constructor(@InjectRepository(Item) private readonly itemRepo: Repository<Item>, private readonly imageService: ImageService) {
		super(itemRepo)
	}

	public async getItems(userId: string): Promise<Item[]> {
		return await this.itemRepository.find({
			where: [
				{ expirationDate: Not(LessThanOrEqual(new Date())), user: Not(Equal(userId)) },
				{ expirationDate: null, user: Not(Equal(userId)) }
			]
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

	public async getItemsOfUser(userId: string): Promise<Item[]> {
		return await this.itemRepository.find({
			where: { user: userId }
		})
	}

	public async handleItemAfterRemove(item: Item) {
		this.imageService.removeImage(item.itemImage)
	}
}
