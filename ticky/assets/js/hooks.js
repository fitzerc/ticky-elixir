let Hooks = {}

Hooks.DownloadCSV = {
    mounted() {
        this.handleEvent("download_csv", ({ csv, filename }) => {
            const blob = new Blob([csv], { type: "text/csv" })
            const url = URL.createObjectURL(blob)
            const a = document.createElement("a")
            a.href = url
            a.download = filename || "time_entries.csv"
            document.body.appendChild(a)
            a.click()
            document.body.removeChild(a)
            URL.revokeObjectURL(url) // Clean up the URL object
        })
    }
}

export default Hooks