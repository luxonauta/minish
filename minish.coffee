document.addEventListener("DOMContentLoaded", () =>
    document.querySelectorAll(".js-copy").forEach((copy) =>
        copy.addEventListener("click", (e) =>
            e.preventDefault()
            
            content = e.currentTarget.nextElementSibling
            range = document.createRange()
            range.selectNode(content)
            
            window.getSelection().addRange(range)

            try
                successful = document.execCommand("copy")
                msg = successful ? "successful" : "unsuccessful"
                console.log({ msg })

            catch error
                console.log("Oops, unable to copy...")

            window.getSelection().removeAllRanges()
        )
    )

    document.querySelectorAll("pre code[data-language='html'] span.line").forEach((line) =>
        content = line.innerHTML
        content = content.replaceAll(/(&lt;(\/?))(.+?(?=&gt;))(&gt;)/g, "$1<span class='pink'>$3</span>$4")

        line.innerHTML = content
        pink = line.querySelector(".pink")

        if pink != null
            content = pink.innerHTML.split(" ")
            content = content.map((part, index) =>
                if index > 0
                    if part.includes("=")
                        part = part.replaceAll(/(.+?)(".*)/g, "<span class='green'>$1</span><span class='yellow'>$2</span>")
                    else
                        part = part.replaceAll(/(.*\S)/g, "<span class='green'>$1</span>")
                part
            ).join(" ")
            pink.innerHTML = content
        return
    )

    document.querySelectorAll("pre code[data-language='css'] span.line").forEach((line) =>
        content = line.innerHTML
        
        if line.dataset.indent
            content = content.split(/:/g).map((part, index) =>
                if index == 0
                    part.replace(/(.*)/g, "<span class='blue'>$1</span>")
                else
                    part = part.replaceAll(/(\S.+?(?=\s|;))/g, "<span class='purple'>$1</span>")
                    part = part.replaceAll(/(".+?(?=,|\s|;))/g, "<span class='yellow'>$1</span>")
                    part = part.replaceAll(/(url\(.+?(?=\s|;))/g, "<span class='green'>$1</span>")
                    part.replaceAll(/\((.+?(?=\)))/g, "(<span class='yellow'>$1</span>")
            ).join(":")
        else
            content = content.replaceAll(/(.+?(?=,|\s|{}))/g, "<span class='pink'>$1</span>")
            content = content.replaceAll(/((\.|:).+?(?=\s))/g, "<span class='green'>$1</span>")
        
        line.innerHTML = content
        return
    )
)