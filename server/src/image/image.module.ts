import { HttpException, HttpStatus, Module } from '@nestjs/common'
import { ImageService } from './image.service'
import { ImageController } from './image.controller'
import { extname } from 'path'
import { ImageModel, ImageModelSchema } from './image.model'
import { MulterModule } from '@nestjs/platform-express'
import { MongooseModule } from '@nestjs/mongoose'

const imageFilter = function (req, file, cb) {
	// accept image only
	if (!file.originalname.match(/\.(jpg|jpeg|png)$/)) {
		cb(new HttpException(`Unsupported file type ${extname(file.originalname)}`, HttpStatus.BAD_REQUEST), false)
	}
	cb(null, true)
}

@Module({
	controllers: [ImageController],
	imports: [
		MongooseModule.forFeature([
			{
				name: ImageModel.name,
				schema: ImageModelSchema
			}
		]),
		MulterModule.registerAsync({
			useFactory: () => ({
				fileFilter: imageFilter
			})
		})
	],
	providers: [ImageService]
})
export class ImageModule {}
