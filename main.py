import re
from flask import Flask, render_template, request
from pyswip import Prolog

app = Flask(__name__)

prolog = Prolog()
prolog.consult("schedule.pl")

def build_course_credit_map():
    credit_map = {}
    for query in [
        "core_course(C, Cr)",
        "capstone(C, Cr)",
        "sector_course(C, Cr)",
        "concentration_course(C, Cr)",
    ]:
        for row in prolog.query(query):
            course = str(row["C"]).strip()
            credits = row["Cr"]
            if isinstance(credits, int):
                credit_map[course.lower()] = credits
    return credit_map

COURSE_CREDITS = build_course_credit_map()

def format_schedule(raw_schedule):
    formatted = []

    for item in raw_schedule:
        text = item.strip().lstrip(",")

        sem_match = re.search(r"semester\((\w+),\s*(\d+)\)", text)
        courses_match = re.search(r"\[(.*?)\]", text)

        if not sem_match or not courses_match:
            continue

        term, year = sem_match.groups()
        courses = [c.strip().replace("'", "") for c in courses_match.group(1).split(",") if c.strip()]

        clean_courses = []
        for course in courses:
            course_key = course.lower()
            credits = COURSE_CREDITS.get(course_key, 0)
            clean_courses.append({
                "code": course.upper(),
                "credits": credits,
            })

        semester_total = sum(c["credits"] for c in clean_courses)

        formatted.append({
            "semester": f"{term.capitalize()} {year}",
            "courses": clean_courses,
            "total_credits": semester_total,
        })

    return formatted

@app.route("/", methods=["GET", "POST"])
def index():
    schedule = None
    error_message = None

    form_values = {
        "year": "",
        "term": "fall",
        "sector1": "computing",
        "sector2": "energy",
        "concentration": "computing",
    }

    if request.method == "POST":
        form_values["year"] = request.form.get("year", "").strip()
        form_values["term"] = request.form.get("term", "fall").strip()
        form_values["concentration"] = request.form.get("concentration", "").strip()
        form_values["sector1"] = request.form.get("sector1", "").strip()
        form_values["sector2"] = request.form.get("sector2", "").strip()

        year = form_values["year"]
        term = form_values["term"]
        concentration = form_values["concentration"]
        sector1 = form_values["sector1"]
        sector2 = form_values["sector2"]

        if not sector1 or not sector2 or sector1 == sector2:
            error_message = "Please select two different sectors"
            return render_template("index.html", schedule=schedule, error_message=error_message, form_values=form_values)
        if not concentration:
            error_message = "Please select a concentration"
            return render_template("index.html", schedule=schedule, error_message=error_message, form_values=form_values)
        if concentration not in (sector1, sector2):
            error_message = "Concentration must match one of your selected sectors"
            return render_template("index.html", schedule=schedule, error_message=error_message, form_values=form_values)

        query = f"generate_schedule({sector1}, {sector2}, {concentration}, semester({term}, {year}), 8, S)"

        result = list(prolog.query(query))

        if result:
            raw_schedule = result[0]["S"]
            schedule = format_schedule(raw_schedule)
        else:
            error_message = "No valid schedule found for the selected options."

    return render_template("index.html", schedule=schedule, error_message=error_message, form_values=form_values)

if __name__ == "__main__":
    app.run(debug=True)

