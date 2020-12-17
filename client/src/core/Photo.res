@decco
type thumbnail = {
  url: string,
  width: int,
  heigh: int,
}

@decco
type thumbnails = {
  small: thumbnail,
  large: thumbnail,
  full: thumbnail,
}

@decco
type t = {
  id: string,
  url: string,
  filename: string,
  size: int,
  thumbnails: thumbnails,
}
