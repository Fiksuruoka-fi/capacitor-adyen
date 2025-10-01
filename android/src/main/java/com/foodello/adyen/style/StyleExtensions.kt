package com.foodello.adyen.style

import android.content.Context
import android.graphics.Color
import com.getcapacitor.JSObject
import androidx.core.graphics.toColorInt
import com.getcapacitor.Logger

/* ----------------------- JSON helpers ----------------------- */

fun JSObject.optNonBlankString(key: String): String? =
    if (has(key) && !isNull(key)) getString(key)?.trim()?.takeIf { it.isNotEmpty() } else null

fun JSObject.optJSObject(key: String): JSObject? =
    if (has(key) && !isNull(key)) getJSObject(key) else null

/* ----------------------- Color helpers ----------------------- */

fun String.asColorOrNull(tag: String = "AdyenStyle"): Int? {
    return try {
        val s = trim()
        if (s.isEmpty()) return null
        val hex = if (s.startsWith("#")) s else "#$s"
        hex.toColorInt()
    } catch (e: IllegalArgumentException) {
        Logger.error("$tag Ignored invalid color: '$this'", e)
        null
    }
}

fun Int.withAlphaFraction(fraction: Float): Int {
    val a = (Color.alpha(this) * fraction).toInt().coerceIn(0, 255)
    return Color.argb(a, Color.red(this), Color.green(this), Color.blue(this))
}

/* ----------------------- View helpers ----------------------- */

fun dp(ctx: Context, v: Int): Int =
    (v * ctx.resources.displayMetrics.density).toInt()
