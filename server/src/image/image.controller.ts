import { Controller, Post, UseInterceptors, UploadedFile, Res, Req, Body, HttpStatus, Get, Param, NotFoundException, Delete } from '@nestjs/common'
import { ImageService } from './image.service'
import { FileInterceptor } from '@nestjs/platform-express'
import { SkipAuth } from 'src/decorators/decorators'

@Controller('image')
export class ImageController {
	constructor(private imageService: ImageService) {}

	@Post('')
	@UseInterceptors(FileInterceptor('file'))
	async uploadImage(@UploadedFile() file, @Res() res, @Req() req, @Body() body) {
		const image = await this.imageService.create(file, body)
		const newImage = image.toObject()

		const host = req.get('host')
		newImage.image_file = undefined
		newImage.url = `http://${host}/image/${newImage._id}`

		return res.send(newImage)
	}

	@Get('')
	async getImages(@Req() req) {
		const host = req.get('host')
		const images = await this.imageService.findAll()

		images.forEach((image) => {
			image.url = `http://${host}/image/${image._id}`
		})

		return images
	}

	@SkipAuth()
	@Get(':id')
	async getImage(@Res() res, @Body() body, @Param('id') id) {
		const image = await this.imageService.getById(id)
		if (!image) throw new NotFoundException('Image does not exist!')
		res.setHeader('Content-Type', image.image_file.contentType)
		return res.send(image.image_file.data.buffer)
	}

	@Delete(':id')
	async deleteImage(@Res() res, @Body() body, @Param('id') id) {
		const image = await this.imageService.removeImage(id)

		if (!image) throw new NotFoundException('Image does not exist!')
		return res.status(HttpStatus.OK).json({ msg: 'Image removed.' })
	}
}
