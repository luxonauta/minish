const babel = require("gulp-babel");
const coffee = require("gulp-coffee");
const gulp = require("gulp");
const sass = require("gulp-sass");
const uglify = require("gulp-uglify-es").default;

exports.default = () => {
    gulp.watch("./*.sass", () => {
        return gulp.src("./*.sass")
            .pipe(sass({ outputStyle: "compressed" }).on("error", sass.logError))
            .pipe(gulp.dest("./dist/"))
    });

    gulp.watch("./*.coffee", () => {
        return gulp.src("./*.coffee")
            .pipe(coffee())
            .pipe(babel({ presets: ["@babel/env"] }))
            .pipe(uglify())
            .pipe(gulp.dest("./dist/"))
    });
}