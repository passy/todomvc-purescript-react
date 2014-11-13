'use scrict';

var gulp = require('gulp');
var purescript = require('gulp-purescript');

gulp.task('build', function () {
    gulp.src('purs/*.purs')
        .pipe(purescript.psc({
            output: 'js/app.js'
        }))
        .pipe(gulp.dest('js/'));
});

gulp.task('watch', function () {
    gulp.watch('purs/*.purs', ['build']);
})

gulp.task('default', ['build']);
