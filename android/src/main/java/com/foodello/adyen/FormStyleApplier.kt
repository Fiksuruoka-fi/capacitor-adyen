package com.foodello.adyen

import android.content.res.ColorStateList
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.util.TypedValue
import android.view.View
import android.view.ViewGroup
import android.widget.CompoundButton
import android.widget.EditText
import android.widget.TextView
import androidx.appcompat.widget.AppCompatAutoCompleteTextView
import androidx.appcompat.widget.SwitchCompat
import com.foodello.adyen.style.*
import com.getcapacitor.JSObject
import com.google.android.material.button.MaterialButton
import com.google.android.material.materialswitch.MaterialSwitch
import com.google.android.material.textfield.TextInputLayout

object FormStyleApplier {
    fun apply(root: ViewGroup, style: JSObject?) {
        if (style == null) return
        val s = style

        // Top-level
        s.optNonBlankString("backgroundColor")?.asColorOrNull()?.let(root::setBackgroundColor)
        val tint = s.optNonBlankString("tintColor")?.asColorOrNull()?.let(ColorStateList::valueOf)
        val separatorColor = s.optNonBlankString("separatorColor")?.asColorOrNull()

        // Text field colors
        val tf = s.optJSObject("textField")
        val titleColor =
            tf?.optJSObject("title")?.optNonBlankString("color")?.asColorOrNull()
                ?: tf?.optNonBlankString("titleColor")?.asColorOrNull()
        val textColor =
            tf?.optJSObject("text")?.optNonBlankString("color")?.asColorOrNull()
                ?: tf?.optNonBlankString("textColor")?.asColorOrNull()
        val placeholderColor =
            tf?.optJSObject("placeholder")?.optNonBlankString("color")?.asColorOrNull()
                ?: tf?.optNonBlankString("placeholderColor")?.asColorOrNull()
        val errorColor =
            tf?.optNonBlankString("errorColor")?.asColorOrNull()
                ?: s.optNonBlankString("errorColor")?.asColorOrNull()

        // Buttons
        val mainBtn = s.optJSObject("button") ?: s.optJSObject("mainButton")
        val secBtn  = s.optJSObject("secondaryButton")

        // Switch/toggle style (computed once)
        val sw = s.optJSObject("switch") ?: s.optJSObject("toggle")
        val switchTitleColor =
            sw?.optJSObject("title")?.optNonBlankString("color")?.asColorOrNull()
                ?: sw?.optNonBlankString("titleColor")?.asColorOrNull()
        val switchTintColor =
            sw?.optNonBlankString("tintColor")?.asColorOrNull()
                ?: s.optNonBlankString("tintColor")?.asColorOrNull()

        traverse(root) { v ->
            when (v) {
                is MaterialSwitch,
                is SwitchCompat,
                is CompoundButton -> {
                    val cb = v

                    // Color the control's own text (works for CheckBox, sometimes for SwitchCompat)
                    switchTitleColor?.let(cb::setTextColor)

                    // ✅ Also color sibling labels in the same row/container
                    (cb.parent as? ViewGroup)?.let { row ->
                        for (i in 0 until row.childCount) {
                            val sib = row.getChildAt(i)
                            if (sib !== cb && sib is TextView) {
                                switchTitleColor?.let(sib::setTextColor)
                            }
                        }
                    }

                    switchTintColor?.let { color ->
                        val tintList = ColorStateList.valueOf(color)
                        when (cb) {
                            is MaterialSwitch -> {
                                cb.thumbTintList = tintList
                                cb.trackTintList = ColorStateList.valueOf(color.withAlphaFraction(0.4f))
                            }
                            is SwitchCompat -> {
                                cb.thumbTintList = tintList
                                cb.trackTintList = ColorStateList.valueOf(color.withAlphaFraction(0.4f))
                            }
                            else -> cb.buttonTintList = tintList // e.g., MaterialCheckBox
                        }
                    }
                }

                is TextInputLayout -> {
                    separatorColor?.let { v.boxStrokeColor = it }
                    titleColor?.let {
                        v.hintTextColor = ColorStateList.valueOf(it)
                        v.defaultHintTextColor = ColorStateList.valueOf(it)
                    }
                    errorColor?.let { v.setErrorTextColor(ColorStateList.valueOf(it)) }
                    s.optNonBlankString("backgroundColor")?.asColorOrNull()?.let { v.boxBackgroundColor = it }

                    v.editText?.let { et ->
                        textColor?.let(et::setTextColor)
                        placeholderColor?.let(et::setHintTextColor)
                        tint?.let { setCursorTintCompat(et, it.defaultColor) }

                        tf?.optJSObject("text")?.optJSObject("font")?.let { f ->
                            f.optNonBlankString("size")?.toIntOrNull()?.let { sp ->
                                et.setTextSize(TypedValue.COMPLEX_UNIT_SP, sp.toFloat())
                            }
                            f.optNonBlankString("weight")?.let { w -> applyTypefaceWeight(et, w) }
                        }
                    }
                }

                is MaterialButton -> {
                    val styleObj = if (v.isEnabled) (mainBtn ?: secBtn) else (secBtn ?: mainBtn)
                    styleObj?.let { b ->
                        b.optNonBlankString("backgroundColor")?.asColorOrNull()
                            ?.let { v.backgroundTintList = ColorStateList.valueOf(it) }
                        b.optNonBlankString("textColor")?.asColorOrNull()?.let(v::setTextColor)
                        b.optJSObject("font")?.optNonBlankString("size")?.toIntOrNull()
                            ?.let { sp -> v.setTextSize(TypedValue.COMPLEX_UNIT_SP, sp.toFloat()) }
                        b.optJSObject("font")?.optNonBlankString("weight")
                            ?.let { w -> applyTypefaceWeight(v, w) }
                        b.optNonBlankString("cornerRadius")?.toIntOrNull()
                            ?.let { r -> v.cornerRadius = dp(v.context, r) }
                    }
                }

                is AppCompatAutoCompleteTextView,
                is TextView -> {
                    var colored = false

                    // 1) Buckets (header/hint/footnote/linkText)
                    style.optJSObject("header")?.optNonBlankString("color")?.asColorOrNull()?.let {
                        v.setTextColor(it); v.alpha = 1f; colored = true
                    }
                    if (!colored) style.optJSObject("hint")?.optNonBlankString("color")?.asColorOrNull()?.let {
                        v.setTextColor(it); v.alpha = 1f; colored = true
                    }
                    if (!colored) style.optJSObject("footnote")?.optNonBlankString("color")?.asColorOrNull()?.let {
                        v.setTextColor(it); v.alpha = 1f; colored = true
                    }
                    if (!colored) style.optJSObject("linkText")?.optNonBlankString("color")?.asColorOrNull()?.let {
                        v.setTextColor(it); v.alpha = 1f; colored = true
                    }

                    // 2) Treat as the label for a neighboring switch
                    if (!colored) {
                        val sw = style.optJSObject("switch") ?: style.optJSObject("toggle")
                        val labelColor = sw?.optJSObject("title")?.optNonBlankString("color")?.asColorOrNull()
                            ?: sw?.optNonBlankString("titleColor")?.asColorOrNull()

                        if (labelColor != null) {
                            val p = v.parent as? ViewGroup
                            val hasSwitchSibling = p?.let { parent ->
                                (0 until parent.childCount).any { idx ->
                                    when (parent.getChildAt(idx)) {
                                        is MaterialSwitch,
                                        is SwitchCompat,
                                        is CompoundButton -> true
                                        else -> false
                                    }
                                }
                            } ?: false

                            if (hasSwitchSibling) {
                                v.setTextColor(labelColor)
                                v.alpha = 1f             // remove disabled greying
                                v.isEnabled = true       // ensure no automatic disabled alpha
                            }
                        }
                    }
                }
            }
        }
    }

    private fun traverse(root: View, block: (View) -> Unit) {
        block(root)
        if (root is ViewGroup) {
            for (i in 0 until root.childCount) traverse(root.getChildAt(i), block)
        }
    }

    private fun setCursorTintCompat(editText: EditText, color: Int) {
        if (Build.VERSION.SDK_INT >= 29) {
            val d = GradientDrawable().apply {
                shape = GradientDrawable.RECTANGLE
                setSize(dp(editText.context, 2), editText.lineHeight)
                setColor(color)
            }
            editText.textCursorDrawable = d
        }
    }

    private fun applyTypefaceWeight(tv: TextView, weight: String) {
        when (weight.lowercase()) {
            "thin", "light", "regular" -> tv.setTypeface(tv.typeface, Typeface.NORMAL)
            "medium", "semibold", "bold", "heavy", "black" -> tv.setTypeface(tv.typeface, Typeface.BOLD)
        }
    }
}
