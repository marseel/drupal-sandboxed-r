args <- commandArgs(trailingOnly = TRUE)
source(paste(args[[2]], "blacklist.R", sep=""))
source(paste(args[[2]], "init.R", sep=""))
source(paste(args[[2]], "masked.functions.R", sep=""))
source(paste(args[[2]], "sandbox.R", sep=""))

size <- nchar(args[[1]])
prefix <- substr(args[[1]], 1, size - 2)
img <- paste(prefix, ".png", sep="")
png(img)

src <- readChar(args[[1]], file.info(args[[1]])$size)
res <- tryCatch(sandbox(src), error = function(e) e)

img.exists <- !is.na(file.info(img)$size)
dev.off()

if (any(class(res) == 'error')) {
    print('FAIL');
    print(res[[1]]);
}
