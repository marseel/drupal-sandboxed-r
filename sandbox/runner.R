args <- commandArgs(trailingOnly = TRUE)
sand <- args[[2]]

size <- nchar(args[[1]])
prefix <- substr(args[[1]], 1, size - 2)
img <- paste(prefix, "png", sep="")
png(img)

if (args[[3]] == "1") {
    source(paste(args[[2]], "blacklist.R", sep=""))
    source(paste(args[[2]], "init.R", sep=""))
    source(paste(args[[2]], "masked.functions.R", sep=""))
    source(paste(args[[2]], "sandbox.R", sep=""))
    src <- readChar(args[[1]], file.info(args[[1]])$size)
    res <- tryCatch(sandbox(src), error = function(e) e)

    if (any(class(res) == 'error')) {
        print('FAIL');
        print(res[[1]]);
    }
} else {
    setTimeLimit(elapsed = 10)
    source(args[[1]]);
    setTimeLimit(elapsed = Inf)
}

img.exists <- !is.na(file.info(img)$size)
off <- dev.off()
