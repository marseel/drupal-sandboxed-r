args <- commandArgs(trailingOnly = TRUE)
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
