import plotly.express as px
import pandas as pd

import plotly.express as px
import pandas as pd

df = pd.DataFrame({
    'Score': [90, 80, 60, 85, 75, 95, 70, 85, 90, 60, 80, 70] * 2,
    'Skill': ['Python', 'Java', 'C++', 'Python', 'Java', 'C++', 'Python', 'Java', 'C++', 'Python', 'Java', 'C++'] * 2,
    'Person': ['Expert', 'Intermediate', 'Beginner', 'Expert', 'Intermediate', 'Beginner', 'Expert', 'Intermediate', 'Beginner', 'Expert', 'Intermediate', 'Beginner'] * 2
})

fig = px.line_polar(df, r='Score', theta='Skill', color='Person',
                    line_close=True, template="plotly_dark",
                    color_discrete_sequence=px.colors.qualitative.Pastel)
fig.update_traces(fill='toself', opacity=0.6)
fig.write_html("radar_chart.html")
print("Chart saved as radar_chart.html — open it in your browser!")