param publicIPAddressId string = 'nestedPublicIp'

output ipAddress string = reference(publicIPAddressId, '2020-05-01').ipAddress