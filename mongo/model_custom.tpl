package model

{{if .Cache}}import (
    "github.com/zeromicro/go-zero/core/stores/cache"
    "github.com/zeromicro/go-zero/core/stores/monc"
){{else}}import "github.com/zeromicro/go-zero/core/stores/mon"{{end}}

var _ {{.Type}}Model = (*custom{{.Type}}Model)(nil)

{{if .Cache}}// TODO: you should customize the cache key prefix here{{end}}
{{if .Cache}}var prefix{{.Type}}CustomCacheKey = "custom:" + "cache:"{{end}}

type (
    // {{.Type}}Model is an interface to be customized, add more methods here,
    // and implement the added methods in custom{{.Type}}Model.
    {{.Type}}Model interface {
        {{.lowerType}}Model
    }

    custom{{.Type}}Model struct {
        *default{{.Type}}Model
    }
)

// New{{.Type}}Model returns a model for the mongo.
func New{{.Type}}Model(url, db, collection string{{if .Cache}}, c cache.CacheConf{{end}}) {{.Type}}Model {
    conn := {{if .Cache}}monc{{else}}mon{{end}}.MustNewModel(url, db, collection{{if .Cache}}, c{{end}})
    return &custom{{.Type}}Model{
        default{{.Type}}Model: newDefault{{.Type}}Model(conn),
    }
}
