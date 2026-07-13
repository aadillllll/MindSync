from app.core.supabase import supabase


class ContextService:

    # ==========================================================
    # USER PROFILE
    # ==========================================================

    @staticmethod
    def build_profile(user_id: str) -> str:

        result = (
            supabase.table("profiles")
            .select(
                "full_name,username,bio,college,course,semester,productivity_score"
            )
            .eq("id", user_id)
            .single()
            .execute()
        )

        if not result.data:
            return ""

        p = result.data

        return f"""
USER PROFILE

Name: {p.get("full_name", "")}
Username: {p.get("username", "")}
College: {p.get("college", "")}
Course: {p.get("course", "")}
Semester: {p.get("semester", "")}
Productivity Score: {p.get("productivity_score", 0)}
Bio: {p.get("bio", "")}

"""


    # ==========================================================
    # TASKS
    # ==========================================================

    @staticmethod
    def build_tasks(user_id: str) -> str:

        result = (
            supabase.table("tasks")
            .select(
                "title,status,priority,due_date,is_completed"
            )
            .eq("user_id", user_id)
            .order("created_at")
            .limit(20)
            .execute()
        )

        if not result.data:
            return ""

        lines = ["TASKS"]

        for task in result.data:

            due = task.get("due_date") or "No deadline"

            lines.append(
                f"""
• {task["title"]}
Status: {task["status"]}
Priority: {task["priority"]}
Completed: {task["is_completed"]}
Due: {due}
"""
            )

        return "\n".join(lines) + "\n\n"


    # ==========================================================
    # HABITS
    # ==========================================================

    @staticmethod
    def build_habits(user_id: str) -> str:

        result = (
            supabase.table("habits")
            .select(
                "title,current_streak,longest_streak"
            )
            .eq("user_id", user_id)
            .limit(20)
            .execute()
        )

        if not result.data:
            return ""

        lines = ["HABITS"]

        for habit in result.data:

            lines.append(
                f"""
• {habit["title"]}
Current Streak: {habit["current_streak"]}
Longest Streak: {habit["longest_streak"]}
"""
            )

        return "\n".join(lines) + "\n\n"


    # ==========================================================
    # GOALS
    # ==========================================================

    @staticmethod
    def build_goals(user_id: str) -> str:

        result = (
            supabase.table("goals")
            .select(
                "title,progress,target,completed"
            )
            .eq("user_id", user_id)
            .limit(20)
            .execute()
        )

        if not result.data:
            return ""

        lines = ["GOALS"]

        for goal in result.data:

            lines.append(
                f"""
• {goal["title"]}
Progress: {goal["progress"]}%
Target: {goal["target"]}
Completed: {goal["completed"]}
"""
            )

        return "\n".join(lines) + "\n\n"


    # ==========================================================
    # NOTES
    # ==========================================================

    @staticmethod
    def build_notes(user_id: str) -> str:

        result = (
            supabase.table("notes")
            .select(
                "title,content,category,is_pinned"
            )
            .eq("user_id", user_id)
            .limit(10)
            .execute()
        )

        if not result.data:
            return ""

        lines = ["NOTES"]

        for note in result.data:

            content = note.get("content", "")

            if len(content) > 250:
                content = content[:250]

            lines.append(
                f"""
• {note["title"]}
Category: {note["category"]}
Pinned: {note["is_pinned"]}

{content}
"""
            )

        return "\n".join(lines) + "\n\n"


    # ==========================================================
    # CALENDAR
    # ==========================================================

    @staticmethod
    def build_calendar(user_id: str) -> str:

        result = (
            supabase.table("calendar_events")
            .select(
                "title,start_time,end_time,event_type"
            )
            .eq("user_id", user_id)
            .order("start_time")
            .limit(10)
            .execute()
        )

        if not result.data:
            return "UPCOMING EVENTS\nNone\n\n"

        lines = ["UPCOMING EVENTS"]

        for event in result.data:

            lines.append(
                f"""
• {event["title"]}
Type: {event["event_type"]}
Start: {event["start_time"]}
End: {event["end_time"]}
"""
            )

        return "\n".join(lines) + "\n\n"


    # ==========================================================
    # FULL CONTEXT
    # ==========================================================

    @staticmethod
    def build_full_context(user_id: str) -> str:

        return (
            ContextService.build_profile(user_id)
            + ContextService.build_tasks(user_id)
            + ContextService.build_habits(user_id)
            + ContextService.build_goals(user_id)
            + ContextService.build_notes(user_id)
            + ContextService.build_calendar(user_id)
        )


    # ==========================================================
    # SMART ROUTER
    # ==========================================================

    @staticmethod
    def build_context(prompt: str, user_id: str) -> str:

        prompt = prompt.lower()

        profile = ContextService.build_profile(user_id)

        if any(word in prompt for word in [
            "task", "todo", "pending", "complete", "deadline"
        ]):
            return profile + ContextService.build_tasks(user_id)

        if any(word in prompt for word in [
            "habit", "streak"
        ]):
            return profile + ContextService.build_habits(user_id)

        if any(word in prompt for word in [
            "goal", "progress", "target"
        ]):
            return profile + ContextService.build_goals(user_id)

        if any(word in prompt for word in [
            "note", "notes", "remember"
        ]):
            return profile + ContextService.build_notes(user_id)

        if any(word in prompt for word in [
            "calendar",
            "schedule",
            "meeting",
            "event",
            "today",
            "tomorrow"
        ]):
            return (
                profile
                + ContextService.build_calendar(user_id)
                + ContextService.build_tasks(user_id)
            )

        # Default → give AI everything
        return ContextService.build_full_context(user_id)