import { Injectable } from '@nestjs/common'
import { InjectModel } from '@nestjs/mongoose'
import { Model } from 'mongoose'
import { ImageModel, ImageDocument } from './image.model'

@Injectable()
export class ImageService {
	constructor(@InjectModel(ImageModel.name) private readonly imageModel: Model<ImageDocument>) {}

	async create(file, createCatDto: { name: string; image_file: Buffer }) {
		const newImage = await new this.imageModel(createCatDto)
		newImage.image_file.data = file.buffer
		newImage.image_file.contentType = file.mimetype
		return newImage.save()
	}

	async findAll(): Promise<ImageModel[] | null> {
		return await this.imageModel.find({}, { image_file: 0 }).lean().exec()
	}

	async getById(id): Promise<ImageModel> {
		return await this.imageModel.findById(id).exec()
	}

	async removeImage(id): Promise<ImageModel> {
		return this.imageModel.findByIdAndDelete(id)
	}
}
