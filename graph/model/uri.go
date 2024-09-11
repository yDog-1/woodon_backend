package model

import (
	"fmt"
	"io"
	"net/url"
	"strconv"

	"github.com/99designs/gqlgen/graphql"
)

func MarshalURI(u url.URL) graphql.Marshaler {
	return graphql.WriterFunc(func(w io.Writer) {
		io.WriteString(w, strconv.Quote(u.String()))
	})
}

func UnmarshalURI(v any) (url.URL, error) {
	switch v := v.(type) {
	case string:
		u, err := url.Parse(v)
		if err != nil {
			return url.URL{}, err
		}
		return *u, nil
	case []byte:
		u := &url.URL{}
		err := u.UnmarshalBinary(v)
		if err != nil {
			return url.URL{}, err
		}
		return *u, nil
	default:
		return url.URL{}, fmt.Errorf("%T is not a url.URL", v)
	}
}
