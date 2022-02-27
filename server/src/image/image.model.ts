import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose'
import * as mongoose from 'mongoose'
import { ImageFile } from './image_file.model'

export type ImageDocument = ImageModel & mongoose.Document

@Schema()
export class ImageModel {
	// Created automatically, just needed for TS
	readonly _id: mongoose.Schema.Types.ObjectId

	@Prop({ type: 'string', required: true })
	name: string

	@Prop({ default: { data: null, contentType: null } })
	image_file: ImageFile

	@Prop({ default: Date.now() })
	createdAt: Date

	// We'll manually populate this property
	url: string
}

export const ImageModelSchema = SchemaFactory.createForClass(ImageModel)
