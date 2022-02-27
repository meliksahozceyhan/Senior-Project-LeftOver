export default () => ({
	database: {
		host: process.env.TYPEORM_HOST,
		port: process.env.TYPEORM_PORT,
		username: process.env.TYPEORM_USERNAME,
		password: process.env.TYPEORM_PASSWORD,
		database: process.env.TYPEORM_DATABASE,
		schema: process.env.TYPEORM_SCHEMA
	},
	mongo: {
		uri: process.env.MONGO_URI
	}
})
