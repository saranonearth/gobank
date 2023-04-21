package api

import (
	"github.com/go-playground/validator/v10"
	"github.com/saranonearth/gobank/utils"
)

var validCurrency validator.Func = func(fieldLevel validator.FieldLevel) bool {
	if currency, ok := fieldLevel.Field().Interface().(string); ok {
		return utils.IsSupportedCurrecy(currency)
	}
	return false
}
